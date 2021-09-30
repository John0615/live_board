defmodule CardModal do
  use Surface.LiveComponent

  prop(board_data, :map, required: true)
  prop(board_tags, :list, required: true)
  data(is_show, :boolean, default: false)
  data(task_detail, :map, default: %{})

  def render(assigns) do
    ~F"""
    <div id="task_modal_container">
      <div :if={@is_show} class="h-screen w-full fixed left-0 top-0 flex justify-center items-start overflow-y-scroll bg-[rgba(0,0,0,0.5)] z-10">
        <div class="md:w-[600px] lg:w-[900px] px-4 py-3 bg-white rounded-lg shadow-lg mt-[80px] mx-auto flex-grow-0">
          <!--顶部功能条-->
          <NavAction id="component_nav_action" task_detail={@task_detail} />
          <div class="border-b pb-2 flex justify-between">
            <!--左侧内容区域-->
            <div class="flex-auto mr-3 mt-2 w-full">
              <div class="min-h-[500px]">
                <!--卡片标题-->
                <CardName id="component_card_name" task_id={@task_detail["task_id"]} task_name={@task_detail["task_name"]} />
                <!--引用信息-->
                <CardShortcutInfo id="component_card_shortcut_info" />
                <!--成员，标签，开始时间，工作量-->
                <CardBaseInfo id="component_card_base_info" task_detail={@task_detail} board_tags={@board_tags} board_data={@board_data} />
                <!-- 自定义字段 -->
                <CardFields id="component_card_fields" />
                <!--描述-->
                <CardDesc id="component_card_desc" />
                <!-- 附件 -->
                <CardUploadFile id="component_card_upload_file" task_id={@task_detail["task_id"]} board_id={@board_data["board"]["board_id"]} />
                <!-- 关联 -->
                <CardConnection id="component_card_connection" />
                <!--检查项-->
                <CardCheckList task_id={@task_detail["task_id"]} id="component_card_check_list" />
                <!--评论-->
                <CardComment task_detail={@task_detail} id="component_card_comment" />
              </div>
            </div>
            <!--右侧按钮组-->
            <div class="w-48 flex flex-col">
              <CardAction id="component_card_action" />
            </div>

          </div>
        </div>
      </div>
    </div>
    """
  end

  def show(task_detail) do
    send_update(__MODULE__, id: "component_task_modal", is_show: true, task_detail: task_detail)
  end

  def handle_event("close_card_modal", _params, socket) do
    {:noreply, assign(socket, is_show: false, task_detail: %{})}
  end
end
