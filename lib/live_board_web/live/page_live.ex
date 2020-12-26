defmodule LiveBoardWeb.PageLive do
  use LiveBoardWeb, :live_view

  @data %{
    "blocks" => [
      %{
        "block_id" => "b59ebb16c0291275",
        "list_id" => "9452430",
        "lane_id" => "0000000002951008",
        "block_status" => nil
      },
      %{
        "block_id" => "648c2a28bc0961ec",
        "list_id" => "9452431",
        "lane_id" => "0000000002951008",
        "block_status" => nil
      },
      %{
        "block_id" => "ea0463d8dfcd43f2",
        "list_id" => "9452432",
        "lane_id" => "0000000002951008",
        "block_status" => nil
      },
      %{
        "block_id" => "7d8645019af496a4",
        "list_id" => "9452433",
        "lane_id" => "0000000002951008",
        "block_status" => nil
      },
      %{
        "block_id" => "cfad0ca4f202972e",
        "list_id" => "9452434",
        "lane_id" => "0000000002951008",
        "block_status" => nil
      }
    ],
    "tasks" => [
      %{
        "list_id" => "9452431",
        "task_id" => "899409ac1ff40bae",
        "type" => "1",
        "task_name" => "这一列放置以后的迭代可能会开发的用户故事。这些用户故事的优先级随着产品研发的持续推进可能会发生变化，产品负责人需要及时进行调整。",
        "linked_users" => "",
        "tag_codes" => "H2",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "0",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "648c2a28bc0961ec",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      },
      %{
        "list_id" => "9452433",
        "task_id" => "49ec62bff6adf866",
        "type" => "1",
        "task_name" => "这一列放置优先级最高，在当前迭代需要进行开发的用户故事。当前迭代开始的时候，这些用户故事会被引用到Sprint看板，进行任务分解",
        "linked_users" => "",
        "tag_codes" => "H2",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "0",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "7d8645019af496a4",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      },
      %{
        "list_id" => "9452433",
        "task_id" => "1ef720595ceff867",
        "type" => "1",
        "task_name" => "用户故事模板：作为 ...用户，我期望...，以便于...",
        "linked_users" => "",
        "tag_codes" => "H2",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "3",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "7d8645019af496a4",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      },
      %{
        "list_id" => "9452430",
        "task_id" => "da6be2a58e38768a",
        "type" => "0",
        "task_name" => "作为企业owner，admin和主管，能够看到仪表盘，并能加载出所有参与统计的项目",
        "linked_users" => "",
        "tag_codes" => "",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "0",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "b59ebb16c0291275",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      },
      %{
        "list_id" => "9452430",
        "task_id" => "b6d667569316ec20",
        "type" => "1",
        "task_name" => "这一列放置用户或相关干系人等的反馈的待整理的原始需求，经过整理后这些需求会变成用户故事，规划到迭代中。",
        "linked_users" => "",
        "tag_codes" => "H2",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "0",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "b59ebb16c0291275",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      },
      %{
        "list_id" => "9452434",
        "task_id" => "40d3510fe94649d5",
        "type" => "1",
        "task_name" => "这一列放置已经完成的用户故事。每个Sprint结束的时候，产品负责人把团队这个迭代完成的故事拖动到已交付列表。",
        "linked_users" => "",
        "tag_codes" => "",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "0",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "cfad0ca4f202972e",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      },
      %{
        "list_id" => "9452432",
        "task_id" => "c14828b1177d8ae4",
        "type" => "1",
        "task_name" => "这一列放置接下来一个迭代可能需要开发的备选用户故事。在当前迭代过程中，产品负责人需要和开发团队成员抽出时间对这些故事进行梳理和细化。",
        "linked_users" => "",
        "tag_codes" => "H2",
        "estimate" => nil,
        "progress" => nil,
        "actual_working_hour" => nil,
        "chklstitem_total_amount" => "0",
        "chklstitem_finished_amount" => "0",
        "has_files" => "N",
        "has_desc" => "N",
        "deadline" => "",
        "start_time" => "",
        "deadline_status" => nil,
        "block_id" => "ea0463d8dfcd43f2",
        "comment_total_amount" => "0",
        "card_type_id" => "173",
        "card_type_name" => "任务",
        "card_type_color" => "#409EFF",
        "show_card_type" => false,
        "has_connection" => false
      }
    ],
    "lanes" => [
      %{
        "lane_id" => "0000000002951008",
        "blocks" => [
          %{
            "block_id" => "b59ebb16c0291275",
            "block_status" => nil,
            "list_id" => "9452430",
            "name" => "待整理的原始需求",
            "tasks" => [
              %{
                "list_id" => "9452430",
                "task_id" => "da6be2a58e38768a",
                "type" => "0",
                "task_name" => "作为企业owner，admin和主管，能够看到仪表盘，并能加载出所有参与统计的项目",
                "linked_users" => "",
                "tag_codes" => "",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "0",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "b59ebb16c0291275",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              },
              %{
                "list_id" => "9452430",
                "task_id" => "b6d667569316ec20",
                "type" => "1",
                "task_name" => "这一列放置用户或相关干系人等的反馈的待整理的原始需求，经过整理后这些需求会变成用户故事，规划到迭代中。",
                "linked_users" => "",
                "tag_codes" => "H2",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "0",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "b59ebb16c0291275",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              }
            ]
          },
          %{
            "block_id" => "648c2a28bc0961ec",
            "block_status" => nil,
            "list_id" => "9452431",
            "name" => "以后的Sprint",
            "tasks" => [
              %{
                "list_id" => "9452431",
                "task_id" => "899409ac1ff40bae",
                "type" => "1",
                "task_name" => "这一列放置以后的迭代可能会开发的用户故事。这些用户故事的优先级随着产品研发的持续推进可能会发生变化，产品负责人需要及时进行调整。",
                "linked_users" => "",
                "tag_codes" => "H2",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "0",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "648c2a28bc0961ec",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              }
            ]
          },
          %{
            "block_id" => "ea0463d8dfcd43f2",
            "block_status" => nil,
            "list_id" => "9452432",
            "name" => "下个Sprint",
            "tasks" => [
              %{
                "list_id" => "9452432",
                "task_id" => "c14828b1177d8ae4",
                "type" => "1",
                "task_name" =>
                  "这一列放置接下来一个迭代可能需要开发的备选用户故事。在当前迭代过程中，产品负责人需要和开发团队成员抽出时间对这些故事进行梳理和细化。",
                "linked_users" => "",
                "tag_codes" => "H2",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "0",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "ea0463d8dfcd43f2",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              }
            ]
          },
          %{
            "block_id" => "7d8645019af496a4",
            "block_status" => nil,
            "list_id" => "9452433",
            "name" => "当前Sprint",
            "tasks" => [
              %{
                "list_id" => "9452433",
                "task_id" => "49ec62bff6adf866",
                "type" => "1",
                "task_name" => "这一列放置优先级最高，在当前迭代需要进行开发的用户故事。当前迭代开始的时候，这些用户故事会被引用到Sprint看板，进行任务分解",
                "linked_users" => "",
                "tag_codes" => "H2",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "0",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "7d8645019af496a4",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              },
              %{
                "list_id" => "9452433",
                "task_id" => "1ef720595ceff867",
                "type" => "1",
                "task_name" => "用户故事模板：作为 ...用户，我期望...，以便于...",
                "linked_users" => "",
                "tag_codes" => "H2",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "3",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "7d8645019af496a4",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              }
            ]
          },
          %{
            "block_id" => "cfad0ca4f202972e",
            "block_status" => nil,
            "list_id" => "9452434",
            "name" => "已交付",
            "tasks" => [
              %{
                "list_id" => "9452434",
                "task_id" => "40d3510fe94649d5",
                "type" => "1",
                "task_name" => "这一列放置已经完成的用户故事。每个Sprint结束的时候，产品负责人把团队这个迭代完成的故事拖动到已交付列表。",
                "linked_users" => "",
                "tag_codes" => "",
                "estimate" => nil,
                "progress" => nil,
                "actual_working_hour" => nil,
                "chklstitem_total_amount" => "0",
                "chklstitem_finished_amount" => "0",
                "has_files" => "N",
                "has_desc" => "N",
                "deadline" => "",
                "start_time" => "",
                "deadline_status" => nil,
                "block_id" => "cfad0ca4f202972e",
                "comment_total_amount" => "0",
                "card_type_id" => "173",
                "card_type_name" => "任务",
                "card_type_color" => "#409EFF",
                "show_card_type" => false,
                "has_connection" => false
              }
            ]
          }
        ]
      }
    ]
  }

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> assign(:data, @data)

    {:ok, socket}
  end

  # @impl true
  # def handle_event("move_task", params, socket) do
  #   IO.inspect(params, label: "move_task>>>>>>", pretty: true)
  #   {:noreply, socket}
  # end

  @impl true
  def handle_event(
        "move_task",
        %{
          "draggedId" => dragged_id,
          "dropzoneBlockId" => dropzone_block_id,
          "draggableIndex" => draggable_index
        },
        %{assigns: _assigns} = socket
      ) do
    IO.puts(1111)

    new_data =
      find_dragged(dragged_id)
      |> update_list(dragged_id, dropzone_block_id, draggable_index)

    socket = socket |> assign(:data, new_data)
    {:noreply, socket}
  end

  @impl true
  def handle_params(%{"task_id" => task_id} = _params, _uri, socket) do
    task_detail = Enum.find(@data["tasks"], fn item -> item["task_id"] == task_id end)

    socket =
      socket
      |> assign(:task_detail, task_detail)

    {:noreply, socket}
  end

  def handle_params(_params, _uri, socket), do: {:noreply, socket}

  defp find_dragged(dragged_id) do
    [[[dragged]]] =
      @data["lanes"]
      |> Enum.map(fn line ->
        Enum.map(line["blocks"], fn block ->
          Enum.filter(block["tasks"], fn task ->
            task["task_id"] == dragged_id
          end)
        end)
        |> Enum.filter(fn item -> length(item) != 0 end)
      end)

    dragged
  end

  def update_list(dragged, dragged_id, dropzone_block_id, draggable_index) do
    %{@data | "lanes" => @data["lanes"] |> remove_dragged(dragged_id)}
    # |> IO.inspect(label: "ksksksk", pretty: true)
    |> insert_dragged(dragged, dropzone_block_id, draggable_index)
    |> insert_dragged(dragged, dropzone_block_id, draggable_index)
  end

  def remove_dragged(list, dragged_id) do
    list
    |> Enum.map(fn line ->
      %{
        line
        | "blocks" =>
            Enum.map(line["blocks"], fn block ->
              %{
                block
                | "tasks" =>
                    Enum.filter(block["tasks"], fn task ->
                      task["task_id"] != dragged_id
                    end)
              }
            end)
      }
    end)
  end

  def insert_dragged(data, dragged, dropzone_block_id, draggable_index) do
    %{
      data
      | "lanes" =>
          Enum.map(data["lanes"], fn lane ->
            %{
              lane
              | "blocks" =>
                  Enum.map(lane["blocks"], fn block ->
                    cond do
                      block["block_id"] == dropzone_block_id and
                          !Enum.find(block["tasks"], fn item ->
                            item["task_id"] == dragged["task_id"]
                          end) ->
                        %{
                          block
                          | "tasks" =>
                              List.insert_at(
                                block["tasks"],
                                String.to_integer(draggable_index) + 1,
                                dragged
                              )
                        }

                      true ->
                        block
                    end
                  end)
            }
          end)
    }
  end
end
