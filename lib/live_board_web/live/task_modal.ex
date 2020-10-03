defmodule TaskModal do
  use Phoenix.LiveComponent

  @impl true
  def mount(socket) do
    {:ok, socket}
  end

  @impl true
  def update(params, socket) do
    socket =
      socket
      |> assign(:open_modal, params.open_modal)
      |> assign(:click_task, params.click_task)

    {:ok, socket}
  end
end
