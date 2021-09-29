defmodule EditCardModal do
  use Surface.LiveComponent

  data(task_offset, :map, default: %{})
  data(task_detail, :map, default: %{})
  data(is_show, :boolean, default: false)

  def render(assigns) do
    ~F"""
    <div id="edit_task_container"
      x-data="{shiftPressed: false}">
      <div :if={@is_show} style={"z-index": 500}
        x-init="
          $refs.taskContentRef.style.height = 'auto';
          $refs.taskContentRef.style.height = $refs.taskContentRef.scrollHeight+'px';
          "
          @submit.prevent="
          PageLiveHook.pushEventTo('#edit_task_container', 'save_task_name', {task_name: $refs.taskContentRef.value})
          content='';
        "
        :on-window-keydown="hide"
        phx-key="Escape"
        phx-capture-click="close"
        phx-page-loading
        class="modal h-screen w-full fixed left-0 top-0 bg-[rgba(0,0,0,0.7)]">
        <div style={top: "#{@task_offset["y"]}px", left: "#{@task_offset["x"]}px"}
        class=" rounded shadow-lg w-64 mt-20 mx-auto fixed">
          <textarea
            autoHeight="true"
            @keydown.shift="shiftPressed = true"
            @keyup.shift="shiftPressed = false"
            @input="
            $event.srcElement.style.height = 'auto';
            $event.srcElement.style.height = $event.srcElement.scrollHeight+'px';
            "
            @keydown.enter.prevent="
            if (shiftPressed) {
              $event.target.value = $event.target.value + '\n'
              $event.srcElement.style.height = 'auto';
              $event.srcElement.style.height = $event.srcElement.scrollHeight+'px';
              return;
            }
            $event.srcElement.style.height = '80px';
            $dispatch('submit');
            "
            x-ref="taskContentRef"
            class="resize-none bg-white focus:outline-none text-[14px] text-[rgb(85,85,85)]
              rounded min-h-[95px] w-full overflow-hidden shadow-none">{Phoenix.HTML.html_escape({:safe, String.replace(@task_detail["task_name"], "</br>", "\n")})}</textarea>
          <button
            @click="
            PageLiveHook.pushEventTo('#edit_task_container', 'save_task_name', {task_name: $refs.taskContentRef.value})
            "
            class="w-20 h-8 mt-2 bg-[rgb(0,121,191)] hover:bg-[rgb(2,106,167)] rounded text-white">保存</button>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, :is_show, false)}
  end

  def handle_event("save_task_name", %{"task_name" => task_name}, socket) do
    params = [
      edit_task_name: task_name,
      task_id: socket.assigns.task_detail["task_id"]
    ]

    send(self(), {:edit_task, params})
    {:noreply, assign(socket, :is_show, false)}
  end

  def show(task_offset, task_detail) do
    send_update(__MODULE__,
      id: "component_edit_task_modal",
      is_show: true,
      task_detail: task_detail,
      task_offset: task_offset
    )
  end
end
