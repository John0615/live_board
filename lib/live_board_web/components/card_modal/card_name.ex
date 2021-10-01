defmodule CardName do
  use Surface.LiveComponent

  prop(task_name, :string, required: true)
  prop(task_id, :string, required: true)

  def render(assigns) do
    ~F"""
    <div id="card_name_container"
      x-data="{ shiftPressed: false, isShowButton: false }"
      x-init="
      $refs.card_name_textarea.style.height = 'auto';
      $refs.card_name_textarea.style.height = $refs.card_name_textarea.scrollHeight+'px';
      "
      x-on:submit.prevent="
      isShowButton=false
      $refs.card_name_textarea.blur()
      BoardLiveHook.pushEventTo('#card_name_container', 'save_task_name', {task_name: $refs.card_name_textarea.value})
      ">
      <textarea rows="1"
        @keydown.shift="shiftPressed = true"
        @keyup.shift="shiftPressed = false"
        @input="
        $event.srcElement.style.height = 'auto';
        $event.srcElement.style.height = $event.srcElement.scrollHeight+'px';
        "
        @keydown.enter.prevent="
        if (shiftPressed) {
          isShowButton=true
          $event.target.value = $event.target.value + '\n'
          $event.srcElement.style.height = 'auto';
          $event.srcElement.style.height = $event.srcElement.scrollHeight+'px';
          return;
        }
        $dispatch('submit');
        "
        x-ref="card_name_textarea"
        class="resize-none text-base py-1 px-1 focus:outline-none w-full rounded
      border-none border-0 focus:outline-none focus:ring-0 focus:bg-gray-300 hover:bg-gray-300">{Phoenix.HTML.html_escape({:safe, String.replace(@task_name, "</br>", "\n")})}</textarea>
      <template x-if="isShowButton">
        <div class="flex flex-row items-center my-1">
          <button @click="
          isShowButton=false
          $refs.card_name_textarea.blur()
          BoardLiveHook.pushEventTo('#card_name_container', 'save_task_name', {task_name: $refs.card_name_textarea.value})
          "
            class="w-20 h-8 bg-[rgb(0,121,191)] hover:bg-[rgb(2,106,167)] rounded text-white">保存</button>
          <button @click="
            isShowButton=false
            $refs.card_name_textarea.blur()
            "
            class="w-20 h-8 ml-2 bg-white hover:bg-gray-300 rounded border">取消</button>
        </div>
      </template>
    </div>
    """
  end

  def handle_event("save_task_name", %{"task_name" => task_name} = _params, socket) do
    params = [
      edit_task_name: task_name,
      task_id: socket.assigns.task_id
    ]

    send(self(), {:edit_task, params})
    {:noreply, socket}
  end
end
