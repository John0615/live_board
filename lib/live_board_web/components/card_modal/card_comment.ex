defmodule CardComment do
  use Surface.LiveComponent

  data(card_comment_info, :list, default: [])
  prop(task_detail, :map, required: true)

  def render(assigns) do
    ~F"""
    <div id="card_comment_container">
      <!--评论内容-->
      <div class="flex flex-col mr-1 mt-3">
        <div class="flex flex-row items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
            <path d="M2 5a2 2 0 012-2h7a2 2 0 012 2v4a2 2 0 01-2 2H9l-3 3v-3H4a2 2 0 01-2-2V5z" />
            <path d="M15 7v2a4 4 0 01-4 4H9.828l-1.766 1.767c.28.149.599.233.938.233h2l3 3v-3h2a2 2 0 002-2V9a2 2 0 00-2-2h-1z" />
          </svg>
          <span class="text-gray-500 text-base font-bold">评论</span>
        </div>
        {#for comment <- @card_comment_info}
        <div class="flex flex-col mt-1">
          <div class="flex flex-row items-start">
            <div class="w-8">
              <button class="w-7 h-7 rounded-md border-none bg-gray-300 text-gray-500 font-bold mr-1 mb-1 flex-grow">
              {#case comment}
                {#match %{"head_img_path" => ""}}
                  <span title={comment["email"]} class="w-8 h-8 text-[12px] leading-8 font-bold rounded-[4px] bg-[#ccc] cursor-pointer">{comment["head_img_letter"]}</span>
                {#match %{"head_img_path" => head_img_path}}
                  <img class="w-8 h-8 rounded-l" src={"#{Application.get_env(:live_board, :live_base_url)}/kanban"<>head_img_path} alt="">
                {#match _}
              {/case}
              </button>
            </div>
            <span class="bg-gray-200  w-full px-2 py-2 text-gray-500 text-sm rounded break-all">{comment["comment"]}</span>
          </div>
          <div class="flex flex-row items-center justify-end mb-1">
            <span class="mr-2 text-gray-500 text-xs leading-[7px]">{comment["create_datetime"]}</span>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-300" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
            </svg>
          </div>
        </div>
        {/for}
      </div>
      <!--评论输入框-->
      <div class="flex flex-col mt-1" x-data="{is_show_add_commont_area: false}">
        <textarea maxlength="600" rows="2"
          x-on:input="is_show_add_commont_area=true"
          x-ref="card_comment_textarea"
          class="resize-none focus:outline-none focus:shadow focus:border-blue-200 w-full border-gray-400 rounded text-sm text-gray-500"
          placeholder="输入评论... 可@其他看板成员，Ctrl+Enter保存"></textarea>
        <template x-if="is_show_add_commont_area">
          <div class="flex flex-row items-center my-2">
            <button x-on:click="
              $refs.card_comment_textarea.blur()
              BoardLiveHook.pushEventTo('#card_comment_container', 'save_task_comment', {comment: $refs.card_comment_textarea.value})
              $refs.card_comment_textarea.value=''
              is_show_add_commont_area=false
              "
              class="w-20 h-8 bg-[rgb(0,121,191)] hover:bg-[rgb(2,106,167)] rounded text-white">保存</button>
            <button x-on:click="
              $refs.card_comment_textarea.blur()
              $refs.card_comment_textarea.value=''
              is_show_add_commont_area=false
            "
              class="w-20 h-8 ml-2 bg-white hover:bg-gray-300 rounded border">取消</button>
          </div>
        </template>
      </div>
    </div>
    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_comment_info: data)
  end

  def handle_event("save_task_comment", %{"comment" => comment} = _params, socket) do
    # comment: rertrter
    # board_id: 29522591
    # list_name: 收纳池
    # task_id: 3aa2395caedcad59
    # head_img_status: 1
    # head_img_letter: PR
    # at_user_id:
    # send(self(), {:add_card_comment, %{
    #   "list_id" => socket.assigns.task_detail["list_id"],
    #   "task_id" => socket.assigns.task_detail["task_id"],
    #   "comment" => comment,
    #   "at_user_id" => nil
    # }})
    {:noreply, socket}
  end
end
