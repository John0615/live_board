defmodule CardCheckList do
  use Surface.LiveComponent
  import LiveBoardWeb.LiveHelpers
  data(card_check_list_info, :list, default: [])
  data(hidden_item_index, :integer, default: nil)
  data(finished_check_list_item_status, :integer, default: "99")
  data(unfinished_check_list_item_status, :integer, default: "1")
  prop(task_id, :string, required: true)

  def render(assigns) do
    ~F"""
    <div :hook="CardCheckListHook" id="card_check_list_container">
      <div :if={length(@card_check_list_info) > 0} class="flex flex-col mt-1">
        <div class="flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
          </svg>
          <span class="text-gray-500 text-base font-bold">检查项</span>
        </div>
        <div class="flex flex-col mt-1">
          {#for {item, index} <- Enum.with_index(@card_check_list_info)}
          <div :on-click="show_edit_item_input" :values={index: index}
            id={item["item_id"]}
            class={"card-modal-checklist-item", "flex", "items-start", "justify-between", "p-2", "bg-gray-100", "mb-2", "rounded", "relative", hidden: index == @hidden_item_index}>
            <div class="flex items-start">
              <div class="flex mr-1 mt-[2px] items-center">
                {#if item["status"] == @finished_check_list_item_status}
                <input :on-click="select_item" checked :values={item_id: item["item_id"]} class="" type="checkbox" />
                {#else}
                <input :on-click="select_item" :values={item_id: item["item_id"]} class="" type="checkbox" />
                {/if}
              </div>
              <span class={"text-gray-500", "text-sm", "break-all", "line-through": item["status"] == @finished_check_list_item_status}>{format_check_list_item(item["item_name"])}</span>
            </div>
            <div class="action-icons flex flex-row items-center absolute top-2 right-2">
              <svg :on-click="copy" xmlns="http://www.w3.org/2000/svg"
                data-clipboard-text={Phoenix.HTML.html_escape({:safe, String.replace(item["item_name"], "</br>", "\n")})}
                class="copy-check-list-item h-4 w-4 text-gray-300 hover:text-gray-500" viewBox="0 0 20 20" fill="currentColor">
                <path d="M7 9a2 2 0 012-2h6a2 2 0 012 2v6a2 2 0 01-2 2H9a2 2 0 01-2-2V9z" />
                <path d="M5 3a2 2 0 00-2 2v6a2 2 0 002 2V5h8a2 2 0 00-2-2H5z" />
              </svg>
              <svg :on-click={"show_confirm_delete_popper", target: "#confirm_delete_popper_container"}
                :values={confirm_fun_name: "delete_check_list_item", target: "#card_check_list_container",
                title: "确定删除该检查项吗？", position_id: item["item_id"], business_id: item["item_id"]}
                xmlns="http://www.w3.org/2000/svg"
                class="h-4 w-4 text-gray-300 hover:text-gray-500 ml-1" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
            </div>
          </div>
          <div :if={index==@hidden_item_index} class="bg-gray-100 w-full mb-2 rounded p-2"
            x-data={"{ shiftPressed: false, item_id:  '#{item["item_id"]}'}"}
            x-init="
              element = document.querySelector('#check_list_item_name_textarea')
              element.style.height = 'auto';
              element.style.height = element.scrollHeight+2+'px';
            "
            x-on:submit.prevent="
              element = document.querySelector('#check_list_item_name_textarea')
              element.blur()
              CardCheckListHook.pushEventTo('#card_check_list_container', 'save_check_list_item_name', {item_name: element.value, item_id})
            ">
            <textarea rows="4" placeholder="输入内容... shift+enter换行，回车提交"
              id="check_list_item_name_textarea"
              x-on:keydown.shift="console.log('按下shift');shiftPressed = true"
              x-on:keyup.shift="console.log('松开shift');shiftPressed = false"
              x-on:input="
              $event.srcElement.style.height = 'auto';
              $event.srcElement.style.height = $event.srcElement.scrollHeight+2+'px';
              "
              x-on:keydown.enter.prevent="
              if (shiftPressed) {
                isShowButton=true
                $event.target.value = $event.target.value + '\n'
                $event.srcElement.style.height = 'auto';
                $event.srcElement.style.height = $event.srcElement.scrollHeight+2+'px';
                return;
              }
              $dispatch('submit');
              "
              class="w-full rounded p-2 focus:outline-none focus:ring-0 text-gray-500 text-sm">{Phoenix.HTML.html_escape({:safe, String.replace(item["item_name"], "</br>", "\n")})}</textarea>
            <div class="flex flex-row items-center my-1">
              <button
                x-on:click="
                  element = document.querySelector('#check_list_item_name_textarea')
                  CardCheckListHook.pushEventTo('#card_check_list_container', 'save_check_list_item_name', {item_name: element.value, item_id})
                "
                class="flex flex-row items-center justify-center w-20 h-8 bg-[rgb(0,121,191)] hover:bg-[rgb(2,106,167)] rounded text-white">保存</button>
              <button :on-click="cancel_edit_item" class="w-20 h-8 ml-2 bg-white hover:bg-gray-300 rounded border">取消</button>
            </div>
          </div>
          {/for}
          <div :if={length(@card_check_list_info) > 0} class="w-full mb-2 rounded">
            <textarea rows="1" placeholder="输入内容... shift+enter换行，回车提交"
              x-data="{ shiftPressed: false}"
              x-on:keydown.shift="shiftPressed = true"
              x-on:keyup.shift="shiftPressed = false"
              x-on:input="
                $event.srcElement.style.height = 'auto';
                $event.srcElement.style.height = $event.srcElement.scrollHeight+2+'px';
              "
              x-on:keydown.enter.prevent="
                if (shiftPressed) {
                  isShowButton=true
                  $event.target.value = $event.target.value + '\n'
                  $event.srcElement.style.height = 'auto';
                  $event.srcElement.style.height = $event.srcElement.scrollHeight+2+'px';
                  return;
                }
                $dispatch('submit');
              "
              x-on:submit.prevent.once="
                element = $refs.new_check_list_item
                element.blur()
                CardCheckListHook.pushEventTo('#card_check_list_container', 'add_check_list_item', {item_name: element.value})
              "
              x-ref="new_check_list_item"
              id="check_list_item_name_textarea"
              class="w-full rounded p-2 focus:outline-none focus:ring-0 placeholder-gray-300 border border-gray-300 text-gray-500 text-sm resize-none"></textarea>
          </div>
        </div>
      </div>
    </div>

    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_check_list_info: data)
  end

  def handle_event("show_edit_item_input", %{"index" => index} = _params, socket) do
    {:noreply, assign(socket, :hidden_item_index, String.to_integer(index))}
  end

  def handle_event("cancel_edit_item", _params, socket) do
    {:noreply, assign(socket, :hidden_item_index, nil)}
  end

  def handle_event("select_item", %{"item_id" => item_id} = _params, socket) do
    socket =
      update(socket, :card_check_list_info, fn card_check_list_info ->
        Enum.map(card_check_list_info, fn item ->
          cond do
            item["item_id"] == item_id &&
                item["status"] != socket.assigns.finished_check_list_item_status ->
              %{item | "status" => socket.assigns.finished_check_list_item_status}

            item["item_id"] == item_id &&
                item["status"] == socket.assigns.finished_check_list_item_status ->
              %{item | "status" => socket.assigns.unfinished_check_list_item_status}

            true ->
              item
          end
        end)
      end)

    Enum.find(socket.assigns.card_check_list_info, fn item -> item["item_id"] == item_id end)
    |> update_check_list_item_checked(socket.assigns.task_id)

    {:noreply, socket}
  end

  def handle_event("copy", _params, socket), do: {:noreply, socket}

  def handle_event("delete_check_list_item", %{"id" => id} = _params, socket) do
    ConfirmDeletePopper.close()

    check_list_item =
      Enum.find(socket.assigns.card_check_list_info, fn item -> item["item_id"] == id end)

    send(
      self(),
      {:delete_check_list_item,
       %{
         "item_id" => id,
         "item_name" => check_list_item["item_name"],
         "status" => check_list_item["status"],
         "task_id" => socket.assigns.task_id
       }}
    )

    socket =
      update(socket, :card_check_list_info, fn card_check_list_info ->
        Enum.filter(card_check_list_info, fn item ->
          item["item_id"] != id
        end)
      end)

    {:noreply, socket}
  end

  def handle_event(
        "save_check_list_item_name",
        %{"item_id" => item_id, "item_name" => item_name} = _params,
        socket
      ) do
    send(
      self(),
      {:edit_check_list_item,
       %{
         "item_id" => item_id,
         "item_name" => item_name,
         "task_id" => socket.assigns.task_id
       }}
    )

    socket =
      update(socket, :card_check_list_info, fn card_check_list_info ->
        Enum.map(card_check_list_info, fn item ->
          cond do
            item["item_id"] == item_id ->
              %{item | "item_name" => String.replace(item_name, "\n", "</br>")}

            true ->
              item
          end
        end)
      end)

    {:noreply, assign(socket, :hidden_item_index, nil)}
  end

  def handle_event("add_check_list_item", %{"item_name" => item_name} = _params, socket) do
    params = %{
      "item_name" => item_name,
      "item_id" => generate_card_id(),
      "task_id" => socket.assigns.task_id
    }

    send(self(), {:add_check_list_item, params})

    socket =
      update(socket, :card_check_list_info, fn card_check_list_info ->
        %{params | "item_name" => String.replace(item_name, "\n", "</br>")}
        |> Map.merge(%{
          "position" => nil,
          "status" => "1"
        })
        |> then(fn new_params ->
          card_check_list_info ++ [new_params]
        end)
      end)

    {:noreply, socket}
  end

  def format_check_list_item(item_name) do
    new_item_name =
      String.replace(item_name, "<br>", "\n")
      |> Linkify.link(
        new_window: true,
        class: "text-[#428bca] hover:underline"
      )

    Phoenix.HTML.html_escape({:safe, new_item_name})
  end

  def update_check_list_item_checked(item, task_id) do
    params = %{
      "item_id" => item["item_id"],
      "status" => item["status"],
      "task_id" => task_id
    }

    send(self(), {:update_check_list_item_checked, params})
  end
end
