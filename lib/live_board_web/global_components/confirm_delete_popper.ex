defmodule ConfirmDeletePopper do
  use Surface.LiveComponent

  data(business_id, :string, default: nil)
  data(position_id, :string, default: nil)
  data(target, :string, default: :live_view)
  data(confirm_fun_name, :string, default: nil)
  data(title, :string, default: nil)
  data(is_show, :boolean, default: false)

  def render(assigns) do
    ~F"""
    <div :hook="ConfirmDeletePopperHook" data-position_id={@position_id}
      class="z-20"
      id="confirm_delete_popper_container"
      x-data="{is_show: false}"
      @closepanel.window="BoardLiveHook.pushEventTo('#confirm_delete_popper_container', 'cancel_delete')"
      @showconfirmdeletepopper.window="is_show=true">
      <div :if={@is_show}
        x-show="is_show"
        x-transition:enter="transition ease-out duration-300"
        x-transition:enter-start="opacity-0"
        x-transition:enter-end="opacity-100"
        x-transition:leave="transition ease-in duration-300"
        x-transition:leave-start="opacity-100"
        x-transition:leave-end="opacity-0"
        class="max-w-sm w-72 bg-white
        shadow-lg rounded-lg pointer-events-auto ring-1 ring-black ring-opacity-5">
        <div class="p-4">
          <div class="flex items-start">
            <div class="w-0 flex-1">
              <p class="text-sm font-medium text-gray-900">{@title}</p>
              <div class="mt-4 flex">
                <button type="button" :on-click={@confirm_fun_name, target: @target} :values={id: @business_id}
                  class="items-center px-3 py-2 border border-transparent
                  shadow-sm text-sm leading-4 font-medium rounded-md w-full
                  text-white bg-red-600 hover:bg-red-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
                  删除
                </button>
              </div>
            </div>
          </div>

          <div class="absolute right-[15px] top-[15px] flex">
            <button :on-click="cancel_delete"
              class="bg-white rounded-md inline-flex text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
              <!-- Heroicon name: solid/x -->
              <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
                <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
              </svg>
            </button>
          </div>
        </div>
      </div>
    </div>

    """
  end

  def handle_event(
        "show_confirm_delete_popper",
        %{
          "business_id" => business_id,
          "position_id" => position_id,
          "confirm_fun_name" => confirm_fun_name,
          "title" => title,
          "target" => target
        } = _params,
        socket
      ) do
    target =
      case target do
        "live_view" -> :live_view
        _ -> target
      end

    send_update(__MODULE__,
      id: "component_confirm_delete_popper",
      is_show: true,
      business_id: business_id,
      position_id: position_id,
      confirm_fun_name: confirm_fun_name,
      title: title,
      target: target
    )

    {:noreply, socket}
  end

  def handle_event("cancel_delete", _, socket) do
    {:noreply, assign(socket, :is_show, false)}
  end

  def close do
    send_update(__MODULE__, id: "component_confirm_delete_popper", is_show: false)
  end
end
