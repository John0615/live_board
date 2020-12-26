defmodule LiveBoardWeb.ModalComponent do
  use LiveBoardWeb, :live_component

  @impl true
  def render(assigns) do
    ~L"""
    <div id="<%= @id %>" class="modal h-screen w-full fixed left-0 top-0 flex justify-center items-center"
      style='z-index: 100000;background-color: rgba(0, 0, 0, 0.7);display: block;'
      phx-capture-click="close"
      phx-window-keydown="close"
      phx-key="escape"
      phx-target="#<%= @id %>"
      phx-page-loading>

      <div class="bg-white rounded shadow-lg w-1/2 mt-20 mx-auto" style="height: 80%;">
        <div class="border-b px-4 py-2 flex justify-between items-center">
          <h3 class="font-semibold text-lg"><%= @opts[:title] %></h3>
          <%= live_patch raw("&times;"), to: @return_to, class: "text-black close-modal" %>
        </div>
        <%= live_component @socket, @component, @opts %>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("close", _, socket) do
    {:noreply, push_patch(socket, to: socket.assigns.return_to)}
  end
end
