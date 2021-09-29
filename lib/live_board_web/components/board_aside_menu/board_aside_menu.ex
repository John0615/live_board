defmodule BoardAsideMenu do
  use Surface.LiveComponent

  data(is_show, :boolean, default: false)
  data(active_tab, :string, default: "")
  prop(board_tags, :list, required: true)
  prop(board_data, :map, required: true)

  def render(assigns) do
    ~F"""
    <div :hook="BoardAsideMenuHook"
      x-data="{isShow: false, boardBodyElement: document.querySelector('.board-body')}"
      x-ref="asideMenuRef"
      @showasidemenu.window="
        if(isShow) return;
        isShow=true;
        setTimeout(()=> {
          boardBodyElement.style.width=(boardBodyElement.offsetWidth-$refs.asideMenuRef.offsetWidth)+'px';
        }, 1000);
      "
      data-active_tab={@active_tab}
      id="board_aside_menu"
      class="absolute inset-y-0 right-0 max-w-full flex z-20">
      <!--
        滑动面板，根据滑动状态显示/隐藏。
        Entering: "transform transition ease-in-out duration-500 sm:duration-700"
          From: "translate-x-full"
          To: "translate-x-0"
        Leaving: "transform transition ease-in-out duration-500 sm:duration-700"
          From: "translate-x-0"
          To: "translate-x-full"
      -->
      <div x-show="isShow"
        x-transition:enter="transform transition ease-in-out duration-500 sm:duration-700"
        x-transition:enter-start="transform translate-x-full"
        x-transition:enter-end="transform translate-x-0"
        x-transition:leave="transform transition ease-in-out duration-500 sm:duration-700"
        x-transition:leave-start="transform translate-x-0"
        x-transition:leave-end="transform translate-x-full"
        class="w-screen max-w-md">
        <div class="h-full p-0 flex flex-col bg-white shadow-xl">
          <div class="p-6">
            <div class="flex items-start justify-between">
              <h2 class="text-lg font-medium text-gray-900" id="slide-over-title">菜单</h2>
              <div class="ml-3 h-7 flex items-center">
                <button
                  @click="
                    isShow=false
                    boardBodyElement.style.width='100%';
                  "
                  :on-click="reset_active_tab_value"
                  class="bg-white rounded-md text-gray-400 hover:text-gray-500 focus:ring-2 focus:ring-indigo-500">
                  <span class="sr-only">关闭</span>
                  <!-- Heroicon name: outline/x -->
                  <svg class="h-6 w-6" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="currentColor" aria-hidden="true">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                  </svg>
                </button>
              </div>
            </div>
          </div>
          <div class="border-b border-gray-200">
            <div class="px-6">
              <nav class="-mb-px flex space-x-6">
                <!-- Current: "border-indigo-500 text-indigo-600", Default: "border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300" -->
                {#for tab <- LiveBoardWeb.BoardAsideMenuData.get_aside_menu()}
                {#if tab.key == @active_tab}
                <a href="#" class="border-indigo-500 text-indigo-600 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm">{tab.name}</a>
                {#else}
                <a href="#" :on-click="select_tab" :values={tab_key: tab.key} class="border-transparent text-gray-500 hover:text-gray-700 hover:border-gray-300 whitespace-nowrap pb-4 px-1 border-b-2 font-medium text-sm">{tab.name}</a>
                {/if}
                {/for}
              </nav>
            </div>
          </div>
          <!--内容-->
          {#case @active_tab}
            {#match "member"}
            <BoardAsideMenuContentMember users={@board_data["board"]["users"]} id="board_aside_menu_content_member_component" />
            {#match "filter"}
            <BoardAsideMenuContentFilter board_tags={@board_tags} board_data={@board_data} id="board_aside_menu_content_filter_component" />
            {#match "menu"}
            <BoardAsideMenuContentMenu id="board_aside_menu_content_menu_component" />
            {#match _}
          {/case}

        </div>
      </div>
    </div>
    """
  end

  def handle_event(
        "board_aside_menu_active_content",
        %{"active_tab" => active_tab} = _params,
        socket
      ) do
    {:noreply, assign(socket, :active_tab, active_tab)}
  end

  def handle_event("reset_active_tab_value", _, socket) do
    Process.sleep(1000)
    send_update(__MODULE__, id: "component_board_aside_menu", active_tab: "")
    {:noreply, socket}
  end

  def handle_event("select_tab", %{"tab_key" => tab_key} = _params, socket) do
    {:noreply, assign(socket, :active_tab, tab_key)}
  end
end
