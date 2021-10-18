defmodule BoardAction do
  use Surface.LiveComponent
  alias Surface.Components.Link

  prop(board_name, :string, required: false)
  prop(board_data, :map, required: true)
  data(is_multiple_mode, :boolean, default: false)

  def render(assigns) do
    ~F"""
    <header x-data class="px-2" id="board_action">
      <div class="flex justify-between items-center  py-1 border-gray-200">
        <div class="flex items-center">
          <button :on-click={"show_board_switch_dropdown", target: "#board_switch_dropdown_container"} class="h-8 px-1 flex flex-row items-center rounded hover:bg-[rgba(255,255,255,.6)] flex-shrink-0">
            <span class="board-name text-white text-[16px] font-bold">{@board_name}</span>
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </button>
          <button class="h-8 px-1 ml-1 flex flex-row items-center rounded hover:bg-[rgba(255,255,255,.6)] flex-shrink-0">
            <span class="text-white text-[14px]">{@board_data["board"]["begin_date"]} - {@board_data["board"]["end_date"]}</span>
          </button>
          <button class="h-8 px-1 flex flex-row items-center flex-shrink-0">
            <Link
              to={"#{Application.get_env(:live_board, :old_base_url)}/kanban/project/go/#{@board_data["board"]["project_id"]}"}
              class="text-white text-[14px]"
            >{@board_data["board"]["project_name"]}</Link>
          </button>
          <button class="h-6 px-1 pt-[2px] flex ml-1 flex-row items-center rounded hover:bg-[rgba(255,255,255,.6)]">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M11.049 2.927c.3-.921 1.603-.921 1.902 0l1.519 4.674a1 1 0 00.95.69h4.915c.969 0 1.371 1.24.588 1.81l-3.976 2.888a1 1 0 00-.363 1.118l1.518 4.674c.3.922-.755 1.688-1.538 1.118l-3.976-2.888a1 1 0 00-1.176 0l-3.976 2.888c-.783.57-1.838-.197-1.538-1.118l1.518-4.674a1 1 0 00-.363-1.118l-3.976-2.888c-.784-.57-.38-1.81.588-1.81h4.914a1 1 0 00.951-.69l1.519-4.674z" />
            </svg>
          </button>
          <button class="h-6 px-1 flex ml-1 flex-row items-center rounded hover:bg-[rgba(255,255,255,.6)]">
            <span class="leangoo icon-chart text-sm text-white"></span>
          </button>
          <button class="h-6 px-1 flex ml-1 flex-row items-center rounded hover:bg-[rgba(255,255,255,.6)] flex-shrink-0">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" viewBox="0 0 20 20" fill="currentColor">
              <path d="M13 6a3 3 0 11-6 0 3 3 0 016 0zM18 8a2 2 0 11-4 0 2 2 0 014 0zM14 15a4 4 0 00-8 0v3h8v-3zM6 8a2 2 0 11-4 0 2 2 0 014 0zM16 18v-3a5.972 5.972 0 00-.75-2.906A3.005 3.005 0 0119 15v3h-3zM4.75 12.094A5.973 5.973 0 004 15v3H1v-3a3 3 0 013.75-2.906z" />
            </svg>
            <span class="text-white text-[14px]">项目成员可见</span>
          </button>
          <button class="h-6 px-1 flex ml-1 flex-row items-center rounded hover:hover:bg-[rgba(255,255,255,.6)] flex-shrink-0">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M4.293 15.707a1 1 0 010-1.414l5-5a1 1 0 011.414 0l5 5a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414 0zm0-6a1 1 0 010-1.414l5-5a1 1 0 011.414 0l5 5a1 1 0 01-1.414 1.414L10 5.414 5.707 9.707a1 1 0 01-1.414 0z" clip-rule="evenodd" />
            </svg>
            <span class="text-white text-[14px]">折叠</span>
          </button>
          <button :if={!@is_multiple_mode} :on-click="set_multiple_mode" class="h-6 px-1 flex ml-1 flex-row items-center rounded hover:hover:bg-[rgba(255,255,255,.6)] flex-shrink-0">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-white" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
            </svg>
            <span class="text-white ml-1 text-[14px]">批量操作</span>
          </button>
          <button :if={@is_multiple_mode} class="h-6 bg-[#5cb85c] flex flex-row items-center rounded mr-1">
            <span class="h-6 text-sm text-white leading-6 px-2 font-bold rounded-[4px] cursor-pointer">批量操作</span>
            <span :on-click="cancel_multiple_mode" class="text-white m-auto px-2 py-1 h-6 hover:bg-[#449d44]">
              <svg class="h-4 w-4" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
              </svg>
            </span>
          </button>
        </div>
        <div class="flex items-center">
          {#for tab <- LiveBoardWeb.BoardAsideMenuData.get_aside_menu()}
          <button :on-click={"board_aside_menu_active_content", target: "#board_aside_menu"}
            :values={active_tab: tab.key}
            class="h-6 px-1 flex flex-row items-center rounded hover:hover:bg-[rgba(255,255,255,.6)]">
            {Phoenix.HTML.html_escape({:safe, tab.icon})}
            <span class="text-white ml-1 text-[14px]">{tab.name}</span>
          </button>
          {/for}
        </div>
      </div>
       <!--看板切换选择下拉框-->
      <BoardSwitchDropdown id="component_board_switch_dropdown" project_id={@board_data["board"]["project_id"]} />
    </header>
    """
  end

  def handle_event("set_multiple_mode", _, socket) do
    socket =
      socket
      |> assign(:is_multiple_mode, true)

    send(self(), {:switch_multiple_mode, %{"is_multiple_mode" => true}})
    {:noreply, push_event(socket, "set_multiple_draggble_mode", %{})}
  end

  def handle_event("cancel_multiple_mode", _, socket) do
    socket =
      socket
      |> assign(:is_multiple_mode, false)

    send(self(), {:switch_multiple_mode, %{"is_multiple_mode" => false}})
    {:noreply, push_event(socket, "set_simple_draggble_mode", %{})}
  end
end
