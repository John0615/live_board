defmodule AddCard do
  use Surface.LiveComponent

  prop(block_id, :string, required: true)
  data(new_card, :map, default: %{})

  def render(assigns) do
    ~F"""
    <div class="relative mt-1" id={"component_add_card_"<>@block_id}
      x-data={"{ shiftPressed: false, content: '',block_id: '#{@block_id}' }"}
      x-init="
        $nextTick(() => {
          let el=document.getElementById(block_id);
          el.scrollTop=el.scrollHeight;
        });
      "
      @submit.prevent={"BoardLiveHook.pushEventTo('#component_add_card_#{@block_id}', 'add_card', {content: content});content='';"}>
      <div class="bg-white rounded-md">
        <textarea placeholder="Enter提交，Shift+Enter换行"
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
          x-model="content"
          class="min-h-[80px] w-full resize-none border-0 focus:outline-none text-[14px]
          text-[rgb(85,85,85)] rounded p-0 focus:ring-0 px-2 py-1"></textarea>
      </div>
      <div class="flex items-center">
        <span style="background-color: #63BA3C" class="pr-1.5 h-[14px] ml-1 rounded"></span>
        <span class="text-[14px] ml-[1px] text-[rgb(144,147,153)] ">用户故事</span>
      </div>
      <div class="flex flex-row items-center">
        <button @click={"BoardLiveHook.pushEventTo('#component_add_card_#{@block_id}', 'add_card', {content: content});content='';"}
          class="w-20 h-8 mt-2 bg-[rgb(0,121,191)] hover:bg-[rgb(2,106,167)] rounded text-white">添加</button>
        <button :on-click={"cancel_add_task", target: "#block_#{@block_id}"}
          class="w-20 h-8 mt-2 ml-2 bg-white hover:bg-gray-300 rounded">取消</button>
      </div>
    </div>
    """
  end

  def handle_event("add_card", %{"content" => content} = _params, socket) do
    # IO.inspect(_params, label: "4555666666", pretty: true)
    send(self(), {:add_card, %{"content" => content, "block_id" => socket.assigns.block_id}})
    {:noreply, socket}
  end
end
