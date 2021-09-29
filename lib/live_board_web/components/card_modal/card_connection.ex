defmodule CardConnection do
  use Surface.LiveComponent

  data(card_connection_info, :list, default: [])

  def render(assigns) do
    ~F"""
    <div id="card_connection_container">
      <div :if={length(@card_connection_info) > 0} class="flex flex-col mt-1">
        <div class="flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M12.586 4.586a2 2 0 112.828 2.828l-3 3a2 2 0 01-2.828 0 1 1 0 00-1.414 1.414 4 4 0 005.656 0l3-3a4 4 0 00-5.656-5.656l-1.5 1.5a1 1 0 101.414 1.414l1.5-1.5zm-5 5a2 2 0 012.828 0 1 1 0 101.414-1.414 4 4 0 00-5.656 0l-3 3a4 4 0 105.656 5.656l1.5-1.5a1 1 0 10-1.414-1.414l-1.5 1.5a2 2 0 11-2.828-2.828l3-3z" clip-rule="evenodd" />
          </svg>
          <span class="text-gray-500 text-base font-bold">关联</span>
        </div>
        <div class="flex mt-1 flex-wrap">
          {#for connection <- @card_connection_info}
          {#case connection["type"]}
            {#match "1"}<!--卡片-->
            <div class="w-[330px] mr-4 rounded border border-solid border-gray-200 p-2 text-xs text-gray-500 mb-1 relative">
              <span class="absolute top-0 right-0 bg-gray-300 rounded-tr px-1 py-0.5">卡片</span>
              <div class="">{connection["task_name"]}</div>
              <div class="flex justify-end my-2">{connection["board_name"]}.{connection["list_name"]}</div>
            </div>
            {#match "2"}<!--看板-->
              <div class="w-[330px] mr-4 rounded border border-solid border-gray-200 p-2 text-xs text-gray-500 mb-1 relative">
                <span class="absolute top-0 right-0 bg-gray-300 rounded-tr px-1 py-0.5">看板</span>
                <div class="">{connection["board_name"]}</div>
                <div class="flex justify-end my-2">{connection["project_name"]}</div>
              </div>
            {#match "3"}<!--脑图-->
              <div class="w-[330px] mr-4 rounded border border-solid border-gray-200 p-2 text-xs text-gray-500 mb-1 relative">
                <span class="absolute top-0 right-0 bg-gray-300 rounded-tr px-1 py-0.5">看板</span>
                <div class="">看板啊啊啊</div>
                <div class="flex justify-end my-2">项目AA</div>
              </div>
            {#match "4"}<!--项目-->
              <div class="w-[330px] mr-4 rounded border border-solid border-gray-200 p-2 text-xs text-gray-500 mb-1 relative">
                <span class="absolute top-0 right-0 bg-gray-300 rounded-tr px-1 py-0.5">项目</span>
                <div class="">{connection["project_name"]}</div>
              </div>
            {#match "5"}<!--链接-->
              <div class="w-[330px] mr-4 rounded border border-solid border-gray-200 p-2 text-xs text-gray-500 mb-1 relative">
                <span class="absolute top-0 right-0 bg-gray-300 rounded-tr px-1 py-0.5">链接</span>
                <div class="">{connection["link_title"]}</div>
              </div>
            {#match "7"}<!--文件-->
              <div class="w-[330px] mr-4 rounded border border-solid border-gray-200 p-2 text-xs text-gray-500 mb-1 relative">
                <span class="absolute top-0 right-0 bg-gray-300 rounded-tr px-1 py-0.5">看板</span>
                <div class="">看板啊啊啊</div>
                <div class="flex justify-end my-2">项目AA</div>
              </div>
            {#match _}
          {/case}
          {/for}
        </div>
      </div>
    </div>
    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_connection_info: data)
  end
end
