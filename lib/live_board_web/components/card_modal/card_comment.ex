defmodule CardComment do
  use Surface.LiveComponent

  data(card_comment_info, :list, default: [])

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
        <div class="flex flex-col mt-1">
          <div class="flex flex-row items-start">
            <div class="w-8">
              <button class="w-7 h-7 rounded-md border-none bg-gray-300 text-gray-500 font-bold mr-1 mb-1 flex-grow">
                Te
              </button>
            </div>
            <span class="bg-gray-200 px-2 py-2 text-gray-500 text-sm rounded break-all">12342234566123422345661234223456612342234566123422345661234223456612342234566123422345661234223456612342234566123422345661234223456612342234566123422345661234223456612342234566123422345661234223456612342234566</span>
          </div>
          <div class="flex flex-row items-center justify-end">
            <span class="mr-2 text-gray-500 text-xs">2021-01-27 17:36</span>
            <i title="删除" class=" fa fa-trash-o delete-icon-on-panel"></i>
          </div>
        </div>
      </div>
      <!--评论输入框-->
      <div class="flex flex-col mt-1">
        <textarea maxlength="600" rows="2"
          class="resize-none focus:outline-none focus:shadow focus:border-blue-300 focus:border-1 w-full border-gray-500 rounded text-sm text-gray-500"
          placeholder="输入评论... 可@其他看板成员，Ctrl+Enter保存"></textarea>
      </div>
    </div>
    """
  end
end
