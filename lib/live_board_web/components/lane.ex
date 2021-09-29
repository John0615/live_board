defmodule Lane do
  use Surface.LiveComponent

  @doc "Someone to say hello to"
  prop(lane, :map, required: true)

  def render(assigns) do
    ~F"""
    <div id={@lane["lane_id"]} class="lanes_container flex flex-row mb-2">
      <!--block-->
      {#for block <- @lane["blocks"]}
      <Block block={block} id={"component"<>block["block_id"]}/>
      {/for}
    </div>
    """
  end
end
