defmodule CardBaseInfo do
  use Surface.LiveComponent

  prop(board_data, :map, required: true)
  prop(board_tags, :list, required: true)
  prop(task_detail, :map, required: true)

  def render(assigns) do
    ~F"""
    <div id="card_base_info_container">
      <div :if={is_display(@task_detail)} class="flex flex-row pl-4 mt-2 flex-wrap">
        <div :if={@task_detail["linked_users"] && @task_detail["linked_users"] != ""} class="flex flex-col mr-4">
          <h3 class="text-sm text-gray-500 font-bold">成员</h3>
          <div class="flex flex-row">
            {#for link_user_id <- String.split(@task_detail["linked_users"], ",")}
              {#if @board_data["board"] && @board_data["board"]["users"]}
              {#case linked_user_info = Enum.find(@board_data["board"]["users"], fn user_info -> user_info["id"] == link_user_id end)}
                {#match nil}
                  ""
                {#match %{"head_img_path" => ""}}
                  <button class="w-7 h-7 rounded-[4px] bg-[#ccc] cursor-pointer text-[12px] font-bold mr-1 mb-1">
                    {linked_user_info["head_img_letter"]}
                  </button>
                {#match %{"head_img_path" => head_img_path}}
                  <button class="h-8 w-8 rounded mr-[2px]">
                    <img class="w-8 h-8 rounded" src={"http://dev.leangoo.com/kanban"<>head_img_path} alt=""/>
                  </button>
                {#match _}
              {/case}
              {/if}
            {/for}
            <button class="w-7 h-7 rounded-md border-2 border-gray-300 bg-white font-bold mr-1 mb-1">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-300 m-auto" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
              </svg>
            </button>
          </div>
        </div>
        <div :if={@task_detail["tag_codes"] && @task_detail["tag_codes"] != ""} class="flex flex-col mr-4">
          <h3 class="text-sm text-gray-500 font-bold">标签</h3>
          <div class="flex flex-row">
            {#for task_tag_code <- String.split(@task_detail["tag_codes"], ",") }
              {#for board_tag <- @board_tags}
                <button :if={board_tag["tag_code"] == task_tag_code} style={"background-color: ##{board_tag["tag_color"]}"}
                  class="min-w-[32px] max-w-[110px] h-5 rounded border-none text-gray-700 font-bold mr-1 mb-1"></button>
              {/for}
            {/for}
            <button class="w-5 h-5 rounded-md border-2 border-gray-300 bg-white font-bold mr-1 mb-1">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-3 w-3 text-gray-300 m-auto" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
              </svg>
            </button>
          </div>
        </div>
        <div :if={@task_detail["start_time"] && @task_detail["start_time"] != ""} class="flex flex-col mr-5">
          <h3 class="text-sm text-gray-500 font-bold">开始时间</h3>
          <span class="text-sm">{String.split(@task_detail["start_time"], " ")|>Enum.at(0)}</span>
        </div>
        <div :if={@task_detail["deadline"] && @task_detail["deadline"] != ""} class="flex flex-col mr-5">
          <h3 class="text-sm text-gray-500 font-bold">截止时间</h3>
          <span class="text-sm">{String.split(@task_detail["deadline"], " ")|>Enum.at(0)}</span>
        </div>
        <div :if={@task_detail["estimate"] && @task_detail["estimate"] != ""} class="flex flex-col mr-5">
          <h3 class="text-sm text-gray-500 font-bold">工作量</h3>
          <button class="border-none bg-[#909399] flex items-center justify-center rounded-xl text-white text-xs w-5 h-5">
            {@task_detail["estimate"]}
          </button>
        </div>
        <!--
        <div class="flex flex-col mr-5">
          <h3 class="text-sm text-gray-500 font-bold">实际工时</h3>
          <button class="border-none bg-[#909399] flex items-center justify-center rounded-xl text-xs text-white w-5 h-5">
            10
          </button>
        </div>
        <div class="flex flex-col mr-5">
          <h3 class="text-sm text-gray-500 font-bold">进度</h3>
          <span class="text-sm text-gray-500">100%</span>
        </div>
        -->
      </div>
    </div>
    """
  end

  def is_display(task_detail) do
    (task_detail["linked_users"] && task_detail["linked_users"] != "") ||
      (task_detail["tag_codes"] && task_detail["tag_codes"] != "") ||
      (task_detail["start_time"] && task_detail["start_time"] != "") ||
      (task_detail["deadline"] && task_detail["deadline"] != "") ||
      (task_detail["estimate"] && task_detail["estimate"] != "")
  end
end
