defmodule CardShortcutInfo do
  use Surface.LiveComponent

  data(card_shortcut_info, :list, default: [])
  data(is_show_more, :boolean, default: false)

  def render(assigns) do
    ~F"""
    <div class="flex flex-row justify-between">
      <div class="flex flex-col">
        {#for {item, index} <- Enum.with_index(@card_shortcut_info)}
        <div class={"pl-4", "flex", "text-sm", hidden: index > 0 && !@is_show_more}>
          <span class="text-gray-600 flex-shrink-0 mr-1">此卡片被引用至</span>
          <a href={item["url"]} title="产品Backlog"
            class="text-gray-600 truncate hover:text-gray-800 max-w-[180px] underline">{item["board_name"]}</a>
          <a href={item["url"]} target="_blank" title="在新标签页打开" class="mr-1">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path d="M11 3a1 1 0 100 2h2.586l-6.293 6.293a1 1 0 101.414 1.414L15 6.414V9a1 1 0 102 0V4a1 1 0 00-1-1h-5z" />
              <path d="M5 5a2 2 0 00-2 2v8a2 2 0 002 2h8a2 2 0 002-2v-3a1 1 0 10-2 0v3H5V7h3a1 1 0 000-2H5z" />
            </svg>
          </a>
          <span class="text-gray-600 flex-shrink-0 mr-1">看板</span>
          <a href={item["url"]} title="以后的Sprint"
            class="text-gray-600 truncate hover:text-gray-800 max-w-[180px] underline">{item["list_name"]}</a>
          <a href={item["url"]} target="_blank" title="在新标签页打开" class="mr-1">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
              <path d="M11 3a1 1 0 100 2h2.586l-6.293 6.293a1 1 0 101.414 1.414L15 6.414V9a1 1 0 102 0V4a1 1 0 00-1-1h-5z" />
              <path d="M5 5a2 2 0 00-2 2v8a2 2 0 002 2h8a2 2 0 002-2v-3a1 1 0 10-2 0v3H5V7h3a1 1 0 000-2H5z" />
            </svg>
          </a>
          <span class="text-gray-600 flex-shrink-0">列表中</span>
        </div>
        {/for}
      </div>

      <div class="flex flex-shrink-0 mx-2">
        <a :if={length(@card_shortcut_info)>1 && !@is_show_more} href="#" :on-click="show_more" class="underline text-sm text-gray-600 hover:text-gray-800">查看更多</a>
        <a :if={@is_show_more} href="#" :on-click="hidden_more" class="underline text-sm text-gray-600 hover:text-gray-800">隐藏更多</a>
      </div>
    </div>
    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_shortcut_info: data)
  end

  def handle_event("show_more", _, socket) do
    {:noreply, assign(socket, :is_show_more, true)}
  end

  def handle_event("hidden_more", _, socket) do
    {:noreply, assign(socket, :is_show_more, false)}
  end
end
