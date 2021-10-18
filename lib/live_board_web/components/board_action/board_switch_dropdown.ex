defmodule BoardSwitchDropdown do
  use Surface.LiveComponent
  alias Surface.Components.LivePatch
  prop(project_id, :string, required: true)
  data(boards_mindmaps, :map, default: %{})
  data(is_show, :boolean, default: false)

  def render(assigns) do
    ~F"""
    <div id="board_switch_dropdown_container" :hook="BoardSwitchDropdownHook"
      x-data @closepanel.window="BoardLiveHook.pushEventTo('#board_switch_dropdown_container', 'close_board_switch_dropdown')"
      class="z-20">
      <nav :if={@is_show} data-popper-arrow class="flex flex-col z-20 max-h-[500px]">
        <div class="w-72 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none" role="menu" >
          <div class="px-4 py-3" role="none">
            <p class="text-sm font-medium text-gray-900 truncate" role="none">修改名称</p>
          </div>
          {#if Map.get(@boards_mindmaps, "board_list")}
          {#for {key, item} <- @boards_mindmaps}
          <div class="py-1" role="none">
            <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
            {#if length(item) > 0}
            <span class="text-[#428bca] text-left font-bold block px-4 py-2 text-sm">{translation(key)}</span>
            {#for board <- item}
              <span :on-click="close_board_switch_dropdown">
              <LivePatch class="text-gray-700 text-left hover:bg-gray-100 block px-4 py-2 text-sm"
                to={"#{Application.get_env(:live_board, :live_base_url)}/kanban/board/go/#{board["board_id"]}"}>
              {board["board_name"]}
              </LivePatch>
              </span>
            {/for}
            {/if}
          </div>
          {/for}
          {/if}
        </div>
      </nav>
    </div>
    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, boards_mindmaps: data)
  end

  def translation(key) do
    case key do
      "board_list" -> "看板"
      "mindmap_list" -> "脑图"
      _ -> ""
    end
  end

  def handle_event("show_board_switch_dropdown", _params, socket) do
    send(self(), {:get_project_board_list, %{"project_id" => socket.assigns.project_id}})
    {:noreply, assign(socket, :is_show, !socket.assigns.is_show)}
  end

  def handle_event("close_board_switch_dropdown", _params, socket) do
    {:noreply, assign(socket, :is_show, false)}
  end
end
