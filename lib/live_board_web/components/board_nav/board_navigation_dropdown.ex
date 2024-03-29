defmodule BoardNavigationDropdown do
  use Surface.LiveComponent
  alias Surface.Components.LivePatch
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, TextInput}

  prop project_id, :string, required: true
  data is_show, :boolean, default: false

  def render(assigns) do
    ~F"""
    <div x-data id="board_navgation_dropdown_container" class="z-20" :hook="BoardNavigationDropdownHook">
      <nav :if={@is_show} x-init="BoardNavigationDropdownHook.init()"
        class="flex flex-col max-h-[500px]">
        <div class="w-72 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none" role="menu" >
          <div class="px-4 py-3" role="none">
            <p class="text-sm font-medium text-gray-900 truncate" role="none">看板导航</p>
          </div>
          <Form for={:filter_form} change="change" opts={autocomplete: "off", class: "mx-1"}>
            <Field name="content">
              <div class="mt-1">
                <TextInput opts={placeholder: "输入看板名称进行过滤..."} class="block w-full shadow-sm sm:text-sm border-blue-300 focus:outline-none focus:ring-0 rounded-md" />
              </div>
            </Field>
          </Form>
          <div class="py-1" role="none">
            <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
            <span class="text-[#428bca] text-left font-bold block px-4 py-2 text-sm">555665656</span>
              <span :on-click="close_board_switch_dropdown">
              <LivePatch class="text-gray-700 text-left hover:bg-gray-100 block px-4 py-2 text-sm"
                to="5555">
              456666555
              </LivePatch>
              </span>
          </div>
        </div>
      </nav>
    </div>
    """
  end

  def handle_event("show_board_navigation_dropdown", _params, socket) do
    send(self(), {:get_all_board_list, %{"project_id" => socket.assigns.project_id}})
    {:noreply, assign(socket, :is_show, true)}
  end
end
