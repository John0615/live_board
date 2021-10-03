defmodule LiveBoardWeb.BoardLive do
  use Surface.LiveView
  import LiveBoardWeb.LiveHelpers
  data(lane_data, :map, default: %{})
  data(board_data, :map, default: %{})
  data(board_name, :string, default: "")
  data(board_tags, :list, default: [])
  data(bg_style, :string, default: "background-color: rgb(0, 99, 177)")

  @impl true
  def mount(%{"board_id" => board_id} = _params, %{"cookie" => cookie}, socket) do
    if connected?(socket), do: Phoenix.PubSub.subscribe(LiveBoard.PubSub, "board_#{board_id}")

    socket =
      socket
      |> assign(:cookie, cookie)
      |> assign(:live_pid, self())

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"board_id" => board_id} = _params, _uri, socket) do
    if connected?(socket) do
      Process.send(
        LiveBoard.LoadHttpData,
        {:load_board_base_data,
         %{
           "live_pid" => socket.assigns.live_pid,
           "cookie" => socket.assigns.cookie,
           "query_list" => [board_id: board_id]
         }},
        []
      )
    end

    socket =
      socket
      |> assign(:lane_data, %{})
      |> assign(:board_data, %{})

    {:noreply, socket}
  end

  @impl true
  def handle_event(
        "task_dropped",
        %{
          "draggedId" => dragged_id,
          "dropzoneId" => drop_zone_id,
          "draggableIndex" => _draggable_index,
          "taskOrderTo" => task_order_to
        },
        socket
      ) do
    result =
      for lane <- socket.assigns.lane_data["lanes"],
          block <- lane["blocks"],
          block["block_id"] == drop_zone_id,
          do: %{
            list_id_to: block |> Map.get("list_id"),
            block_id_to: block |> Map.get("block_id"),
            lane_id_to: lane |> Map.get("lane_id")
          }

    params = [
      board_id: socket.assigns.board_data["board"]["board_id"],
      list_id_to: Enum.at(result, 0) |> Map.get(:list_id_to),
      lane_id_to: Enum.at(result, 0) |> Map.get(:lane_id_to),
      list_name_to:
        Enum.find(socket.assigns.board_data["lists"], fn list ->
          list["list_id"] == Enum.at(result, 0) |> Map.get(:list_id_to)
        end)
        |> Map.get("list_name"),
      block_id_to: Enum.at(result, 0) |> Map.get(:block_id_to),
      task_order_to: task_order_to
    ]

    new_params =
      String.split(dragged_id, ",")
      |> Enum.reduce(params, fn dragged_id, acc -> acc ++ ["task_ids[]": dragged_id] end)

    Process.send(
      LiveBoard.LoadHttpData,
      {:task_dropped_http, %{"cookie" => socket.assigns.cookie, "query_list" => new_params}},
      []
    )

    # 同步数据
    # Phoenix.PubSub.broadcast(LiveBoard.PubSub, "board", {:update_board, new_data})
    {:noreply, socket}
  end

  def handle_event(
        "list_dropped",
        %{
          "draggedId" => dragged_id,
          "listOrder" => list_order
        },
        socket
      ) do
    params = [
      board_id: socket.assigns.board_data["board"]["board_id"],
      list_id: dragged_id,
      list_order: list_order
    ]

    Process.send(
      LiveBoard.LoadHttpData,
      {:list_dropped_http, %{"cookie" => socket.assigns.cookie, "query_list" => params}},
      []
    )

    {:noreply, socket}
  end

  def handle_event(
        "lane_dropped",
        %{
          "draggedId" => dragged_id,
          "laneSort" => list_order
        },
        socket
      ) do
    params = [
      board_id: socket.assigns.board_data["board"]["board_id"],
      lane_id: dragged_id,
      laneSort: list_order
    ]

    Process.send(
      LiveBoard.LoadHttpData,
      {:lane_dropped_http, %{"cookie" => socket.assigns.cookie, "query_list" => params}},
      []
    )

    {:noreply, socket}
  end

  def handle_event("setting_background", %{"color" => color} = _params, socket) do
    {:noreply, assign(socket, :bg_style, "background-color: #{color}")}
  end

  def handle_event("setting_background", %{"img_name" => img_name} = _params, socket) do
    {:noreply,
     assign(
       socket,
       :bg_style,
       "background-image: url(\"#{Application.get_env(:live_board, :old_base_url)}/kanban/application/views/images/background/#{img_name}\")"
     )}
  end

  def handle_event("delete_card", %{"id" => task_id} = _params, socket) do
    socket =
      Map.update!(socket.assigns.lane_data, "lanes", fn lanes ->
        Enum.map(lanes, fn lane ->
          Map.update!(lane, "blocks", fn blocks ->
            Enum.map(blocks, fn block ->
              Map.update!(block, "tasks", fn tasks ->
                Enum.filter(tasks, fn task -> task["task_id"] != task_id end)
              end)
            end)
          end)
        end)
      end)
      |> then(fn lane_data ->
        update(socket, :lane_data, fn _ -> lane_data end)
      end)

    # 发送请求
    Process.send(
      LiveBoard.LoadHttpData,
      {:delete_card,
       %{
         "cookie" => socket.assigns.cookie,
         "live_pid" => socket.assigns.live_pid,
         "query_list" => [
           task_id: task_id,
           board_id: socket.assigns.board_data["board"]["board_id"]
         ]
       }},
      []
    )

    ConfirmDeletePopper.close()
    {:noreply, socket}
  end

  # @impl true
  # def handle_info({:update_board, new_data}, socket) do
  #   socket =
  #     socket
  #     |> assign(:data, new_data)

  #   {:noreply, socket}
  # end

  def handle_info({:switch_multiple_mode, %{"is_multiple_mode" => is_multiple_mode}}, socket) do
    Enum.each(socket.assigns.lane_data["lanes"], fn lane ->
      Enum.each(lane["blocks"], fn block ->
        Enum.each(block["tasks"], fn task ->
          Card.multiple_mode("component" <> task["task_id"], is_multiple_mode)
        end)
      end)
    end)
    {:noreply, socket}
  end

  @impl true
  def handle_info(
        {:update_board_base_data, %{"board_base_data" => board_base_data} = _params},
        socket
      ) do
    lanes_times = board_base_data["board_data"]["lanes_times"]
    # IO.inspect(board_base_data["board_data"], label: "85636555", pretty: true)
    Enum.each(0..(lanes_times - 1), fn lane_time ->
      Process.send(
        LiveBoard.LoadHttpData,
        {:load_lane_data,
         %{
           "cookie" => socket.assigns.cookie,
           "live_pid" => socket.assigns.live_pid,
           "query_list" => [
             current_times: lane_time,
             board_id: board_base_data["board_data"]["board"]["board_id"]
           ]
         }},
        []
      )
    end)

    # IO.inspect(board_base_data, label: "45652556", pretty: true)
    socket =
      socket
      |> assign(:board_data, board_base_data["board_data"])
      |> assign(:board_name, board_base_data["board_name"])
      |> assign(:board_tags, board_base_data["board_tags"])

    {:noreply, socket}
  end

  @impl true
  def handle_info({:update_lane, %{"board_lane_data" => board_lane_data} = _params}, socket) do
    Enum.each(board_lane_data["lanes"], fn lane ->
      Enum.each(lane["blocks"], fn block ->
        Enum.each(block["tasks"], fn task ->
          Card.init_board_data("component" <> task["task_id"], socket.assigns.board_data)
        end)
      end)
    end)

    socket =
      update(socket, :lane_data, fn lane ->
        case lane do
          %{"lanes" => _lanes} ->
            %{lane | "lanes" => lane["lanes"] ++ board_lane_data["lanes"]}

          _ ->
            board_lane_data
        end
      end)

    {:noreply, socket}
  end

  def handle_info({:edit_task, params}, socket) do
    params = params ++ [board_id: socket.assigns.board_data["board"]["board_id"]]

    Process.send(
      LiveBoard.LoadHttpData,
      {:edit_task, %{"cookie" => socket.assigns.cookie, "query_list" => params}},
      []
    )

    socket =
      Map.update!(socket.assigns.lane_data, "lanes", fn lanes ->
        Enum.map(lanes, fn lane ->
          Map.update!(lane, "blocks", fn blocks ->
            Enum.map(blocks, fn block ->
              Map.update!(block, "tasks", fn tasks ->
                Enum.map(tasks, fn task ->
                  cond do
                    task["task_id"] == params[:task_id] ->
                      Map.update!(task, "task_name", fn _task_name ->
                        params[:edit_task_name] |> String.replace("\n", "</br>")
                      end)

                    true ->
                      task
                  end
                end)
              end)
            end)
          end)
        end)
      end)
      |> then(fn lane_data ->
        update(socket, :lane_data, fn _ -> lane_data end)
      end)

    {:noreply, socket}
  end

  def handle_info({:get_project_board_list, %{"project_id" => project_id}}, socket) do
    HttpBoard.client(socket.assigns.cookie)
    |> HttpBoard.get_project_boards(project_id)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => boards_mindmaps}}} = result
      BoardSwitchDropdown.init_data("component_board_switch_dropdown", boards_mindmaps)
    end)

    {:noreply, socket}
  end

  def handle_info(:get_board_activity_data, socket) do
    Process.send(
      LiveBoard.LoadHttpData,
      {:load_board_activity_data,
       %{
         "cookie" => socket.assigns.cookie,
         "live_pid" => socket.assigns.live_pid,
         "query_list" => [board_id: socket.assigns.board_data["board"]["board_id"]]
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(
        {:update_board_activity, %{"board_activity_data" => board_activity_data}},
        socket
      ) do
    BoardAsideMenuContentMember.init_data(
      "board_aside_menu_content_member_component",
      board_activity_data
    )

    {:noreply, socket}
  end

  def handle_info({:add_card, %{"content" => content, "block_id" => block_id}}, socket) do
    [%{"lane_id" => lane_id, "list_id" => list_id, "task_ids" => task_ids}] =
      for lane <- socket.assigns.lane_data["lanes"],
          block <- lane["blocks"],
          block["block_id"] == block_id do
        IO.inspect(block, label: "2122121211212", pretty: true)

        %{
          "lane_id" => lane["lane_id"],
          "list_id" => block["list_id"],
          "task_ids" => Enum.map(block["tasks"], fn task -> task["task_id"] end)
        }
      end

    list_name =
      Enum.find(
        socket.assigns.board_data["lists"],
        fn list -> list["list_id"] == list_id end
      )
      |> then(fn item -> item["list_name"] end)

    task_id = generate_card_id()

    query_list = [
      new_task_name: content,
      board_id: socket.assigns.board_data["board"]["board_id"],
      lane_id: lane_id,
      list_id: list_id,
      block_id: block_id,
      task_id: task_id,
      list_name: list_name,
      task_order: (task_ids ++ [task_id]) |> Enum.join(","),
      type_id: 2094,
      card_type_category: 3
    ]

    IO.inspect(query_list, label: "4548798989889", pretty: true)

    # 发送请求
    Process.send(
      LiveBoard.LoadHttpData,
      {:add_card,
       %{
         "cookie" => socket.assigns.cookie,
         "live_pid" => socket.assigns.live_pid,
         "query_list" => query_list
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(
        {:update_board_add_card,
         %{"new_card" => new_card, "block_id" => block_id, "live_pid" => live_pid}},
        socket
      )
      when live_pid == socket.assigns.live_pid do
    socket =
      Map.update!(socket.assigns.lane_data, "lanes", fn lanes ->
        Enum.map(lanes, fn lane ->
          Map.update!(lane, "blocks", fn blocks ->
            Enum.map(blocks, fn block ->
              Map.update!(block, "tasks", fn tasks ->
                cond do
                  block["block_id"] == block_id -> tasks ++ [new_card]
                  true -> tasks
                end
              end)
            end)
          end)
        end)
      end)
      |> then(fn lane_data ->
        update(socket, :lane_data, fn _ -> lane_data end)
      end)

    {:noreply, socket}
  end

  def handle_info({:load_card_modal_data, %{"task" => task} = _params}, socket) do
    IO.inspect(socket.assigns.board_data, label: "11232465454548787", pretty: true)
    IO.inspect(socket.assigns.board_tags, label: "11232465454548787", pretty: true)

    # 发送请求
    Process.send(
      LiveBoard.LoadHttpData,
      {:load_card_modal_info,
       %{
         "cookie" => socket.assigns.cookie,
         "live_pid" => socket.assigns.live_pid,
         "query_list" => [
           task_id: task["task_id"],
           board_id: socket.assigns.board_data["board"]["board_id"],
           card_type_id: task["card_type_id"]
         ]
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(
        {:update_card_shortcut_info, %{"card_shortcut_info" => card_shortcut_info} = _params},
        socket
      ) do
    CardShortcutInfo.init_data(
      "component_card_shortcut_info",
      card_shortcut_info["task_shortcut_list"]
    )

    {:noreply, socket}
  end

  def handle_info({:update_card_fields_info, %{"card_fields_info" => ""} = _params}, socket) do
    {:noreply, socket}
  end

  def handle_info(
        {:update_card_fields_info, %{"card_fields_info" => card_fields_info} = _params},
        socket
      ) do
    CardFields.init_data("component_card_fields", card_fields_info)
    {:noreply, socket}
  end

  def handle_info(
        {:update_card_upload_file_info, %{"card_upload_file_info" => card_upload_file_info}},
        socket
      ) do
    CardUploadFile.init_data("component_card_upload_file", card_upload_file_info)
    {:noreply, socket}
  end

  def handle_info(
        {:update_card_check_list_info, %{"card_check_list_info" => card_check_list_info}},
        socket
      ) do
    CardCheckList.init_data("component_card_check_list", card_check_list_info)
    {:noreply, socket}
  end

  def handle_info({:update_card_desc_info, %{"card_desc_info" => card_desc_info}}, socket) do
    CardDesc.init_data("component_card_desc", card_desc_info)
    {:noreply, socket}
  end

  def handle_info(
        {:update_card_connection_info, %{"card_connection_info" => card_connection_info}},
        socket
      ) do
    CardConnection.init_data("component_card_connection", card_connection_info)
    {:noreply, socket}
  end

  def handle_info(
        {:update_card_comment_info, %{"card_comment_info" => card_comment_info}},
        socket
      ) do
    CardComment.init_data("component_card_comment", card_comment_info)
    {:noreply, socket}
  end

  def handle_info(
        {:edit_check_list_item,
         %{
           "item_id" => item_id,
           "item_name" => item_name,
           "task_id" => task_id
         }},
        socket
      ) do
    # 发送请求
    Process.send(
      LiveBoard.LoadHttpData,
      {:edit_check_list_item,
       %{
         "cookie" => socket.assigns.cookie,
         "query_list" => [
           item_id: item_id,
           item_name: item_name,
           task_id: task_id,
           board_id: socket.assigns.board_data["board"]["board_id"]
         ]
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(
        {:delete_check_list_item,
         %{
           "item_id" => item_id,
           "item_name" => item_name,
           "status" => status,
           "task_id" => task_id
         }},
        socket
      ) do
    Process.send(
      LiveBoard.LoadHttpData,
      {:delete_check_list_item,
       %{
         "cookie" => socket.assigns.cookie,
         "query_list" => [
           item_id: item_id,
           item_name: item_name,
           task_id: task_id,
           board_id: socket.assigns.board_data["board"]["board_id"],
           status: status
         ]
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(
        {:add_check_list_item,
         %{"item_name" => item_name, "item_id" => item_id, "task_id" => task_id}},
        socket
      ) do
    Process.send(
      LiveBoard.LoadHttpData,
      {:add_check_list_item,
       %{
         "cookie" => socket.assigns.cookie,
         "query_list" => [
           item_id: item_id,
           item_name: item_name,
           task_id: task_id,
           board_id: socket.assigns.board_data["board"]["board_id"]
         ]
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(
        {:update_check_list_item_checked,
         %{
           "item_id" => item_id,
           "status" => status,
           "task_id" => task_id
         }},
        socket
      ) do
    Process.send(
      LiveBoard.LoadHttpData,
      {:update_check_list_item_checked,
       %{
         "cookie" => socket.assigns.cookie,
         "query_list" => [
           item_id: item_id,
           status: status,
           task_id: task_id,
           board_id: socket.assigns.board_data["board"]["board_id"]
         ]
       }},
      []
    )

    {:noreply, socket}
  end

  def handle_info(_params, socket), do: {:noreply, socket}
end
