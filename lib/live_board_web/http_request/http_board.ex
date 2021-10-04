defmodule HttpBoard do
  def board_repos(client, query_list) do
    Tesla.post(client, "/board/goBoardFromApp", query_list)
  end

  def lane_repos(client, query_list) do
    Tesla.post(client, "/board/getLaneTasks", query_list)
  end

  def change_order(client, query_list) do
    Tesla.post(client, "/task/change_order", query_list)
  end

  def change_list_order(client, query_list) do
    Tesla.post(client, "/list_c/changeOrder", query_list)
  end

  def change_lane_order(client, query_list) do
    Tesla.post(client, "/board/rearrangeLane", query_list)
  end

  def edit_task(client, query_list) do
    Tesla.post(client, "/task/edit", query_list)
  end

  def get_project_boards(client, project_id) do
    Tesla.get(client, "/project/get_project_boards/#{project_id}")
  end

  def get_board_activity(client, query_list) do
    Tesla.post(client, "/board/getActivity", query_list)
  end

  def add_card(client, query_list) do
    Tesla.post(client, "/task/add", query_list)
  end

  def delete_card(client, query_list) do
    Tesla.post(client, "/task/delete", query_list)
  end

  def load_card_shortcut_info(client, query_list) do
    Tesla.post(client, "/task/get_shortcut_task_info", query_list)
  end

  def load_card_fields(client, query_list) do
    Tesla.get(
      client,
      "/task/fields/get2?board_id=#{query_list[:board_id]}&task_id=#{query_list[:task_id]}&type_id=#{query_list[:card_type_id]}"
    )
  end

  def load_card_upload_file(client, query_list) do
    Tesla.get(client, "/task/uploadFile/#{query_list[:board_id]}/#{query_list[:task_id]}")
  end

  def load_card_check_list(client, query_list) do
    Tesla.post(client, "/task/getChecklist", query_list)
  end

  def edit_check_list_item(client, query_list) do
    Tesla.post(client, "/chklst/edit", query_list)
  end

  def delete_check_list_item(client, query_list) do
    Tesla.post(client, "/chklst/deleteItem", query_list)
  end

  def load_card_desk(client, query_list) do
    Tesla.post(client, "/task/getTaskDesc", query_list)
  end

  def save_card_desc(client, query_list) do
    Tesla.post(client, "/task/editTaskDesc", query_list)
  end

  def load_card_connection_info(client, query_list) do
    Tesla.get(
      client,
      "/task_conn/index?board_id=#{query_list[:board_id]}&task_id=#{query_list[:task_id]}"
    )
  end

  def load_card_comment_info(client, query_list) do
    Tesla.post(client, "/task/getTaskComment", query_list)
  end

  def add_check_list_item(client, query_list) do
    Tesla.post(client, "/chklst/addItem", query_list)
  end

  def update_check_list_item_checked(client, query_list) do
    Tesla.post(client, "/chklst/checked", query_list)
  end

  def add_comment(client, query_list) do
    Tesla.post(client, "/task/addTaskComment", query_list)
  end

  def client(cookie) do
    middleware = [
      {Tesla.Middleware.BaseUrl, "http://dev.leangoo.com/kanban"},
      Tesla.Middleware.EncodeFormUrlencoded,
      Tesla.Middleware.JSON,
      {Tesla.Middleware.Headers, [{"cookie", cookie}]}
    ]

    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 60_000]}
    Tesla.client(middleware, adapter)
  end
end
