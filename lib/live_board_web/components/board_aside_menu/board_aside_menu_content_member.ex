defmodule BoardAsideMenuContentMember do
  use Surface.LiveComponent

  prop(users, :list, required: true)
  data(board_activity_data, :list, default: [])

  def render(assigns) do
    ~F"""
    <div class="py-1" role="none">
      <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
        <ul class="mt-2">
        {#for user <- @users}
        <li class="text-gray-700 group flex items-center px-4 py-2 text-sm cursor-pointer">
          {#case user}
            {#match nil}
              ""
            {#match %{"head_img_path" => ""} = user}
              <span title={user["email"]}
              class="w-8 h-8 text-[12px] leading-8 text-center font-bold rounded-[4px]
               bg-[#ccc] cursor-pointer">{user["head_img_letter"]}</span>
            {#match %{"head_img_path" => head_img_path}}
              <img class="w-8 h-8 rounded-l" src={"#{Application.get_env(:live_board, :old_base_url)}/kanban"<>head_img_path} alt="">
            {#match _}
          {/case}
          <span class="ml-2">{user["nick_name"]}</span>
        </li>
        {/for}
      </ul>

      <a href="#" class="group px-4 inline-flex items-center font-medium text-indigo-600 hover:text-indigo-900">
        <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-indigo-500 group-hover:text-indigo-900" viewBox="0 0 20 20" fill="currentColor">
          <path d="M8 9a3 3 0 100-6 3 3 0 000 6zM8 11a6 6 0 016 6H2a6 6 0 016-6zM16 7a1 1 0 10-2 0v1h-1a1 1 0 100 2h1v1a1 1 0 102 0v-1h1a1 1 0 100-2h-1V7z" />
        </svg>
        <span class="ml-2">添加成员</span>
      </a>

      <!--看板动态-->
      <div class="border-t">
        <span class="group px-4 inline-flex items-center font-medium mt-1">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
          </svg>
          <span class="ml-2">看板动态</span>
        </span>
        <!--内容-->
        <div class="overflow-y-auto">
          {#for item <- @board_activity_data}
            <div class="text-gray-700 group flex flex-col items-start mx-4 py-2 text-sm border-b">
              <div class="flex">
                {#case item}
                  {#match nil}
                    ""
                  {#match %{"head_img_path" => ""} = item}
                    <span title={item["email"]}
                    class="w-8 h-8 text-[12px] leading-8 text-center font-bold rounded-[4px]
                      bg-[#ccc] cursor-pointer">{item["head_img_letter"]}</span>
                  {#match %{"head_img_path" => head_img_path}}
                    <img class="w-8 h-8 rounded-l" src={"#{Application.get_env(:live_board, :old_base_url)}/kanban"<>head_img_path} alt="">
                  {#match _}
                {/case}

                {#case item["action"]}
                  {#match "change_task_order"}
                  <span class="ml-1">
                    将卡片
                    <span class="text-gray-400">{item["details"]["task_name"]}</span>
                    从
                    <span class="text-gray-400">{item["details"]["list_name_from"]}</span>
                    列表移动到
                    <span class="text-gray-400">{item["details"]["list_name_to"]}</span>
                    列表中
                  </span>
                  {#match "change_list_order"}
                  未翻译
                  {#match "delete_task"}
                  未翻译
                  {#match "add_task"}
                  未翻译
                  {#match "edit_task_name"}
                  未翻译
                  {#match "add_chklstItem"}
                  未翻译
                  {#match "task_add_comment"}
                  未翻译
                  {#match "set_card_deadline"}
                  未翻译
                  {#match "change_card_start_time"}
                  未翻译
                  {#match "set_card_start_time"}
                  未翻译
                  {#match "add_task_attachment"}
                  未翻译
                  {#match "setEstimate"}
                  未翻译
                  {#match "add_task_desc"}
                  未翻译
                  {#match "create_shortcut_to_other_board"}
                  未翻译
                  {#match "change_card_type"}
                  未翻译
                  {#match "create_shortcut_from_other_board"}
                  ""
                  {#match "copy_task_to_other_board"}
                  未翻译
                  {#match "addBoard"}
                  未翻译
                  {#match "copy_list"}
                  未翻译
                  {#match "copy_task_from_other_board"}
                  未翻译
                  {#match "card_deadline_finished"}
                  未翻译
                  {#match "edit_chklstItem"}
                  未翻译
                  {#match "edit_task_desc"}
                  未翻译
                  {#match "delete_chklstItem"}
                  未翻译
                  {#match _}
                  未匹配
                {/case}
              </div>
              <div class="text-right w-full">{item["create_datetime"]}</div>
            </div>
          {/for}
        </div>

      </div>
    </div>
    """
  end

  def mount(socket) do
    send(self(), :get_board_activity_data)
    {:ok, socket}
  end

  def handle_event("show_more_tag", _, socket) do
    {:noreply, assign(socket, :is_show_more_tags, true)}
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, board_activity_data: data)
  end
end
