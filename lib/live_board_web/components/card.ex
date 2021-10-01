defmodule Card do
  use Surface.LiveComponent

  data(board_data, :map, default: %{})
  data multiple_mode, :boolean, default: false
  prop(task, :map, required: true)

  def render(assigns) do
    ~F"""
    <li id={@task["task_id"]} card_id={"card_"<>@task["task_id"]} :on-click="show_card_modal"
      :values={card_id: @task["task_id"]}
      class="draggable relative mt-1 bg-white rounded-md hover:bg-gray-200">
      <a href="#">
        <div class="flex items-center">
          <span :if={@task["task_number"]} class="text-xs text-center text-gray-500 px-1 h-4 rounded bg-gray-300">{@task["task_number"]}</span>
          <span style={"background-color": @task["card_type_color"]} class="pr-1.5 h-[14px] ml-1 rounded"></span>
          <span class="text-[14px] ml-[1px] text-[rgb(144,147,153)] ">{@task["card_type_name"]}</span>
        </div>
        <div class="flex justify-between mt-[5px] px-1">
          <p class="text-[14px] font-medium leading-snug text-gray-600 flex-grow font-normal overflow-hidden">
            {Phoenix.HTML.html_escape({:safe, @task["task_name"]})}
          </p>
        </div>

        <div class="flex justify-between items-baseline mb-[10px] px-2">
          <div class="mt-2 flex flex-row">
            {#for link_user_id <- String.split(@task["linked_users"])}
              {#if @board_data["board"] && @board_data["board"]["users"]}
              {#case linked_user_info = Enum.find(@board_data["board"]["users"], fn user_info -> user_info["id"] == link_user_id end)}
                {#match nil}
                  ""
                {#match %{"head_img_path" => ""}}
                  <button class="w-8 h-8 rounded-[4px] bg-[#ccc] cursor-pointer mr-[2px]">
                    <span title={linked_user_info["email"]} class="text-[12px] font-bold">{linked_user_info["head_img_letter"]}</span>
                  </button>
                {#match %{"head_img_path" => head_img_path}}
                  <button class="h-8 w-8 rounded mr-[2px]">
                    <img class="w-8 h-8 rounded" src={"http://dev.leangoo.com/kanban"<>head_img_path} alt=""/>
                  </button>
                {#match _}
              {/case}
              {/if}
            {/for}
          </div>
          <div :if={@task["chklstitem_total_amount"] != nil && @task["chklstitem_total_amount"] != "0"} class="flex flex-row items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-[rgb(140,140,140)]" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h6a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
            </svg>
            <span class="text-[rgb(140,140,140)] text-[12px] flex flex-row items-center ml-1">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 text-[rgb(140,140,140)]" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M3 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm0 4a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
              </svg>
              {@task["chklstitem_finished_amount"]}/{@task["chklstitem_total_amount"]}
            </span>
          </div>
        </div>
      </a>
      <span class="task-hover-icon">
        <svg :on-click="edit_card" xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 cursor-pointer absolute top-1 right-7 ml-1 text-gray-400 hover:text-gray-800 transform hover:scale-125" viewBox="0 0 20 20" fill="currentColor">
          <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
        </svg>
        <svg :on-click={"show_confirm_delete_popper", target: "#confirm_delete_popper_container"}
          :values={confirm_fun_name: "delete_card", target: "live_view", title: "确定删除该卡片吗？", position_id: @task["task_id"], business_id: @task["task_id"]}
          xmlns="http://www.w3.org/2000/svg"
          class="h-4 w-4 cursor-pointer absolute top-1 right-2 ml-1 text-gray-400 hover:text-gray-800 transform hover:scale-125" viewBox="0 0 20 20" fill="currentColor">
          <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
        </svg>
      </span>
    </li>
    """
  end

  def init_board_data(card_id, board_data) do
    send_update(__MODULE__, id: card_id, board_data: board_data)
  end

  def init_task_data(card_id, task_data) do
    send_update(__MODULE__, id: card_id, task: task_data)
  end

  def multiple_mode(card_id, mode) do
    send_update(__MODULE__, id: card_id, multiple_mode: mode)
  end

  def handle_event("edit_card", _, socket) do
    {:noreply, push_event(socket, "edit_card", %{task_id: socket.assigns.task["task_id"]})}
  end

  def handle_event("show_edit_card_modal", %{"offset" => offset} = _params, socket) do
    EditCardModal.show(offset, socket.assigns.task)
    {:noreply, socket}
  end

  def handle_event("show_card_modal", _params, socket) when socket.assigns.multiple_mode==false do
    CardModal.show(socket.assigns.task)
    # 请求数据
    send(self(), {:load_card_modal_data, %{"task" => socket.assigns.task}})
    {:noreply, socket}
  end

  def handle_event("show_card_modal", _params, socket) do
   {:noreply, socket}
  end
end
