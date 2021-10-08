defmodule BoardAsideMenuContentFilter do
  use Surface.LiveComponent
  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextInput}

  prop(board_tags, :list, required: true)
  prop(board_data, :map, required: true)
  data(is_show_more_tags, :boolean, default: false)
  data(hidden_more_tag_from_index, :integer, default: 6)
  data filter_form, :form, default: %{}

  def render(assigns) do
    ~F"""
    <Form for={:filter_form} change="change" opts={autocomplete: "off"}
      class="h-full divide-y divide-gray-200 flex flex-col shadow-xl">
      <div class="flex-1 h-0 overflow-y-auto">
        <div class="flex-1 flex flex-col justify-between">
          <div class="px-4 divide-y divide-gray-200 sm:px-6">
            <div class="space-y-6 pt-6 pb-5">
              <Field name="content">
                <Label class="block text-sm font-medium text-gray-900">按内容</Label>
                <div class="mt-1">
                  <TextInput value={@filter_form["content"]} class="block w-full shadow-sm sm:text-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300 rounded-md" />
                </div>
              </Field>
              <Field name="label">
                <Label class="block text-sm font-medium text-gray-900">按标签</Label>
                <div class="mt-1">
                  <TextInput value={@filter_form["label"]} class="block w-full shadow-sm sm:text-sm focus:ring-indigo-500 focus:border-indigo-500 border-gray-300 rounded-md" />
                </div>
                <ul class="mt-2">
                  {#for {tag, index} <- @board_data["board"]["tags"] |> Enum.with_index()}
                    {#for board_tag <- @board_tags}
                    {#if tag["tag_code"] == board_tag["tag_code"]}
                    <li class={"text-gray-700", "group", "flex", "items-center", "px-4", "py-2", "text-sm", "hover:bg-gray-100", "hover:text-gray-900", hidden: index>@hidden_more_tag_from_index && !@is_show_more_tags}>
                      <span class="w-6 h-6 rounded" style={"background-color: ##{board_tag["tag_color"]};"}></span>
                      <span class="ml-2">{board_tag["tag_name"]}</span>
                    </li>
                    {/if}
                    {/for}
                  {/for}
                </ul>
                <div :if={!@is_show_more_tags && length(@board_data["board"]["tags"])>@hidden_more_tag_from_index+1} class="flex mt-1">
                  <button type="button" :on-click="show_more_tag"
                  class="flex-1 bg-indigo-600 py-2 px-4 border border-transparent rounded-md shadow-sm
                  text-sm font-medium text-white hover:bg-indigo-700 focus:outline-none focus:ring-2
                  focus:ring-offset-2 focus:ring-indigo-500">
                    加载更多
                  </button>
                </div>
              </Field>
              <div>
                <label for="project-name" class="block text-sm font-medium text-gray-900">
                  按成员
                </label>
                <ul class="mt-2">
                  {#for user <- @board_data["board"]["users"]}
                  <li class="text-gray-700 group flex items-center px-4 py-2 text-sm hover:bg-gray-100 hover:text-gray-900">
                    {#case user}
                      {#match nil}
                        ""
                      {#match %{"head_img_path" => ""} = user}
                        <span title={user["email"]}
                        class="w-8 h-8 text-[12px] leading-8 text-center font-bold rounded-[4px]
                         bg-[#ccc] cursor-pointer">{user["head_img_letter"]}</span>
                      {#match %{"head_img_path" => head_img_path}}
                        <img class="w-8 h-8 rounded-l" src={"#{Application.get_env(:live_board, :old_base_url)}/kanban"<>head_img_path} alt="">
                      {#match _}
                    {/case}
                    <span class="ml-2">{user["nick_name"]}</span>
                  </li>
                  {/for}
                </ul>
              </div>

            </div>

          </div>
        </div>
      </div>
    </Form>
    """
  end

  def handle_event("show_more_tag", _, socket) do
    {:noreply, assign(socket, :is_show_more_tags, true)}
  end

  def handle_event("change", %{"filter_form" => %{"content" => content, "label" => _label}} = _params, socket) do
    send(self(), {:filter_card_by_content, %{"content" => content}})
    {:noreply, socket}
  end
end
