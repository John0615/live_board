defmodule CardFields do
  use Surface.LiveComponent

  data(card_fields_info, :map, default: %{})

  def render(assigns) do
    ~F"""
    <div id="card_fields_info_container">
      <div :if={is_display(@card_fields_info)} class="flex flex-col pl-4 mt-2">
        {#for field <- Map.get(@card_fields_info, "fields")}
        <div class="flex flex-row pb-2">
          <div class="flex flex-row items-center max-w-[130px] pr-3">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            <span class="text-gray-500 text-sm">{field["field_name"]}</span>
          </div>
          <div class="text-gray-500 text-sm">{field["value"]}</div>
        </div>
        {/for}
      </div>
    </div>
    """
  end

  def is_display(card_fields_info) do
    fields = Map.get(card_fields_info, "fields")
    fields && length(fields) > 0
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_fields_info: data)
  end
end
