defmodule CardDesc do
  use Surface.LiveComponent
  prop task_id, :string, required: true
  data(card_desc_info, :string, default: "")

  def render(assigns) do
    ~F"""
    <div :hook="CardDescHook" id="card_desc_container"
      x-data="{is_show_button: false}"
      class="mt-2 flex flex-col max-w-[700px]">
      <div class="flex flex-row items-center mb-4">
        <div class="flex flex-row items-center mr-2">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
          </svg>
          <span class="text-gray-500 text-base font-bold">描述</span>
        </div>
        <a class="flex flex-row items-center" href="#">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
            <path d="M17.414 2.586a2 2 0 00-2.828 0L7 10.172V13h2.828l7.586-7.586a2 2 0 000-2.828z" />
            <path fill-rule="evenodd" d="M2 6a2 2 0 012-2h4a1 1 0 010 2H4v10h10v-4a1 1 0 112 0v4a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" clip-rule="evenodd" />
          </svg>
          <span x-on:click="CardDescHook.initEditEditor();is_show_button=true" class="text-gray-400 text-sm">编辑</span>
        </a>
      </div>
      <input type="hidden" id="card-desc-info-value" value={@card_desc_info} />
      <div id="md-editor" class="pl-4"></div>
      <template x-if="is_show_button">
        <div class="flex flex-row items-center ml-4">
          <button x-on:click="CardDescHook.saveContent();is_show_button=false" class="w-20 h-8 mt-2 bg-[rgb(0,121,191)] hover:bg-[rgb(2,106,167)] rounded text-white">保存</button>
          <button x-on:click="CardDescHook.initViewEditor();is_show_button=false" class="w-20 h-8 mt-2 ml-2 bg-white hover:bg-gray-300 border rounded">取消</button>
        </div>
      </template>
    </div>
    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_desc_info: data)
  end

  def handle_event("save_card_desc", %{"task_desc" => task_desc, "action" => action} = _params, socket) do
    send(self(), {:save_card_desc, %{
      "task_id" => socket.assigns.task_id,
      "task_desc" => task_desc,
      "action" => action
      }})
    {:noreply, socket}
  end
end
