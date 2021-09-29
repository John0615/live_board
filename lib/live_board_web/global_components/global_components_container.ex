defmodule GlobalComponentsContainer do
  use Surface.LiveComponent

  def render(assigns) do
    ~F"""
    <div id="global_components_container">
       <!--删除卡片确认框-->
      <ConfirmDeletePopper id="component_confirm_delete_popper" />
    </div>
    """
  end
end
