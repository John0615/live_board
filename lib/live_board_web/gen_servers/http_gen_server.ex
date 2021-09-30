defmodule LiveBoard.LoadHttpData do
  use GenServer

  def start_link(initial_state) do
    GenServer.start_link(__MODULE__, initial_state, name: __MODULE__)
  end

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_cast(
        {:load_card_shortcut_info,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_shortcut_info(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => card_shortcut_info}}} = result

      if length(card_shortcut_info["task_shortcut_list"]) > 0 do
        Process.send(
          live_pid,
          {:update_card_shortcut_info, %{"card_shortcut_info" => card_shortcut_info}},
          []
        )
      end
    end)

    {:noreply, state}
  end

  @impl true
  def handle_cast(
        {:load_card_fields,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_fields(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => card_fields_info}}} = result

      Process.send(
        live_pid,
        {:update_card_fields_info, %{"card_fields_info" => card_fields_info}},
        []
      )
    end)

    {:noreply, state}
  end

  def handle_cast(
        {:load_card_upload_file,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_upload_file(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: card_upload_file_info}} = result

      Process.send(
        live_pid,
        {:update_card_upload_file_info, %{"card_upload_file_info" => card_upload_file_info}},
        []
      )
    end)

    {:noreply, state}
  end

  def handle_cast(
        {:load_card_check_list,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_check_list(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => card_check_list_info}}} = result

      Process.send(
        live_pid,
        {:update_card_check_list_info, %{"card_check_list_info" => card_check_list_info}},
        []
      )
    end)

    {:noreply, state}
  end

  def handle_cast(
        {:load_card_desc_info,
         %{
           "live_pid" => live_pid,
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_desk(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => card_desc_info}}} = result
      Process.send(live_pid, {:update_card_desc_info, %{"card_desc_info" => card_desc_info}}, [])
    end)

    {:noreply, state}
  end

  def handle_cast(
        {:load_card_connection_info,
         %{
           "live_pid" => live_pid,
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_connection_info(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => card_connection_info}}} = result
      # IO.inspect(card_connection_info, label: "8e98e9e9e9e", pretty: true)

      Process.send(
        live_pid,
        {:update_card_connection_info, %{"card_connection_info" => card_connection_info}},
        []
      )
    end)

    {:noreply, state}
  end

  def handle_cast(
        {:load_card_comment_info,
         %{
           "live_pid" => live_pid,
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.load_card_comment_info(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => card_comment_info}}} = result
      # IO.inspect(card_comment_info, label: "card_comment_info", pretty: true)

      Process.send(
        live_pid,
        {:update_card_comment_info, %{"card_comment_info" => card_comment_info}},
        []
      )
    end)

    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:task_dropped_http, %{"cookie" => cookie, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie) |> HttpBoard.change_order(query_list)
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:list_dropped_http, %{"cookie" => cookie, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie) |> HttpBoard.change_list_order(query_list)
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:lane_dropped_http, %{"cookie" => cookie, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie) |> HttpBoard.change_lane_order(query_list)
    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:edit_task, %{"cookie" => cookie, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.edit_task(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => edit_result}} = _result} = result
      IO.inspect(edit_result, label: "444455s5s5s", pretty: true)
    end)

    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:load_board_base_data,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    board_base_data =
      HttpBoard.client(cookie)
      |> HttpBoard.board_repos(query_list)
      |> then(fn result ->
        {:ok, %Tesla.Env{body: %{"message" => board_base_data}}} = result

        %{
          board_base_data
          | "board_data" => Jason.decode!(board_base_data["board_data"])
        }
      end)

    Process.send(live_pid, {:update_board_base_data, %{"board_base_data" => board_base_data}}, [])

    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:load_lane_data,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    IO.inspect(query_list, label: "load lane data params>>>>>>", pretty: true)

    board_lane_data =
      HttpBoard.client(cookie)
      |> HttpBoard.lane_repos(query_list)
      |> then(fn result ->
        {:ok, %Tesla.Env{body: %{"message" => board_lane_data}}} = result
        board_lane_data
      end)

    Process.send(live_pid, {:update_lane, %{"board_lane_data" => board_lane_data}}, [])

    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:load_board_activity_data,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    board_activity_data =
      HttpBoard.client(cookie)
      |> HttpBoard.get_board_activity(query_list)
      |> then(fn result ->
        {:ok, %Tesla.Env{body: %{"message" => board_activity_data}}} = result
        IO.inspect(board_activity_data, label: "4585255666633", pretty: true)
        board_activity_data
      end)

    Process.sleep(500)

    Process.send(
      live_pid,
      {:update_board_activity, %{"board_activity_data" => board_activity_data}},
      []
    )

    {:noreply, state}
  end

  @impl GenServer
  def handle_info(
        {:add_card,
         %{"cookie" => cookie, "live_pid" => live_pid, "query_list" => query_list} = _params},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.add_card(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => _add_result}} = _result} = result

      new_card = %{
        "actual_working_hour" => nil,
        "block_id" => query_list[:block_id],
        "card_type_category" => 3,
        "card_type_color" => "#63BA3C",
        "card_type_id" => "2094",
        "card_type_name" => "用户故事",
        "chklstitem_finished_amount" => "0",
        "chklstitem_total_amount" => "0",
        "deadline" => "",
        "deadline_status" => 0,
        "deadline_status_disabled" => false,
        "estimate" => nil,
        "has_connection" => false,
        "has_desc" => "N",
        "linked_users" => "",
        "list_id" => query_list[:list_id],
        "progress" => nil,
        "show_card_type" => true,
        "start_time" => "",
        "tag_codes" => "",
        "task_id" => query_list[:task_id],
        "task_name" => query_list[:new_task_name],
        "type" => "1"
      }

      Phoenix.PubSub.broadcast(
        LiveBoard.PubSub,
        "board",
        {:update_board_add_card,
         %{"new_card" => new_card, "block_id" => query_list[:block_id], "live_pid" => live_pid}}
      )
    end)

    {:noreply, state}
  end

  def handle_info(
        {:delete_card,
         %{
           "cookie" => cookie,
           "live_pid" => _live_pid,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.delete_card(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => _delete_result}} = _result} = result
      IO.inspect(result, label: "delete_result", pretty: true)
    end)

    {:noreply, state}
  end

  def handle_info({:load_card_modal_info, params}, state) do
    # 加载卡片引用信息
    GenServer.cast(__MODULE__, {:load_card_shortcut_info, params})
    GenServer.cast(__MODULE__, {:load_card_fields, params})
    GenServer.cast(__MODULE__, {:load_card_upload_file, params})
    GenServer.cast(__MODULE__, {:load_card_check_list, params})
    GenServer.cast(__MODULE__, {:load_card_desc_info, params})
    GenServer.cast(__MODULE__, {:load_card_connection_info, params})
    GenServer.cast(__MODULE__, {:load_card_comment_info, params})
    {:noreply, state}
  end

  def handle_info(
        {:edit_check_list_item,
         %{
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.edit_check_list_item(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => edit_result}} = _result} = result
      IO.inspect(edit_result, label: "edit_result", pretty: true)
    end)

    {:noreply, state}
  end

  def handle_info(
        {:delete_check_list_item,
         %{
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.delete_check_list_item(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => delete_result}} = _result} = result
      IO.inspect(delete_result, label: "delete_result", pretty: true)
    end)

    {:noreply, state}
  end

  def handle_info(
        {:add_check_list_item,
         %{
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.add_check_list_item(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => add_result}} = _result} = result
      IO.inspect(add_result, label: "add_result", pretty: true)
    end)

    {:noreply, state}
  end

  def handle_info(
        {:update_check_list_item_checked,
         %{
           "cookie" => cookie,
           "query_list" => query_list
         }},
        state
      ) do
    HttpBoard.client(cookie)
    |> HttpBoard.update_check_list_item_checked(query_list)
    |> then(fn result ->
      {:ok, %Tesla.Env{body: %{"message" => update_check_list_item_checked_result}} = _result} =
        result

      IO.inspect(update_check_list_item_checked_result,
        label: "update_check_list_item_checked_result",
        pretty: true
      )
    end)

    {:noreply, state}
  end
end
