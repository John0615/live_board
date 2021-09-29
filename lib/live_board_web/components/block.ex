defmodule Block do
  use Surface.LiveComponent

  @doc "Someone to say hello to"
  prop(block, :map, required: true)
  data(is_show_add_task, :boolean, default: false)

  def render(assigns) do
    ~F"""
    <div id={"block_"<>@block["block_id"]} block_list_id={"block_list_"<>@block["list_id"]}
      class="block_container flex-shrink-0 w-64 p-1 mr-2 flex flex-col place-self-start overflow-hidden bg-[#eee] rounded-md">
      <ul id={@block["block_id"]} class="dropzone smart-scrollbar flex flex-col px-[2px] max-h-106 overflow-auto">
        {#for task <- @block["tasks"]}
        <Card task={task} id={"component"<>task["task_id"]}/>
        {/for}
        <AddCard :if={@is_show_add_task} block_id={@block["block_id"]} id={"component_add_card_"<>@block["block_id"]} />
      </ul>
      <div :if={!@is_show_add_task} class="mt-2 flex justify-between">
        <span :on-click="add_task" class="text-sm text-gray-500 cursor-pointer hover:text-gray-700 hover:underline">添加卡片</span>
        <button>
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-400" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M4.293 15.707a1 1 0 010-1.414l5-5a1 1 0 011.414 0l5 5a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414 0zm0-6a1 1 0 010-1.414l5-5a1 1 0 011.414 0l5 5a1 1 0 01-1.414 1.414L10 5.414 5.707 9.707a1 1 0 01-1.414 0z" clip-rule="evenodd" />
          </svg>
        </button>
      </div>
    </div>
    """
  end

  def handle_event("add_task", _unsigned_params, socket) do
    {:noreply, assign(socket, :is_show_add_task, true)}
  end

  def handle_event("cancel_add_task", _unsigned_params, socket) do
    {:noreply, assign(socket, :is_show_add_task, false)}
  end
end
