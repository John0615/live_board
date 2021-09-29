defmodule ListHeader do
  use Surface.Component

  @doc "Someone to say hello to"
  prop(list, :map, required: true)

  def render(assigns) do
    ~F"""
    <div id={@list["list_id"]} class="draggable_list flex flex-col">
      <div class="flex flex-row flex-shrink-0 w-64 px-2 py-1 mr-2 items-center justify-between bg-[#eee] rounded-t">
        <div class="flex items-center">
          <h3 class="text-sm text-[#4d4d4d] font-medium">{@list["list_name"]}</h3>
          <!-- <span class="text-gray-500 ml-1 text-sm">8</span> -->
        </div>
        <div class="flex items-center">
          <!-- <span class="text-white text-xs bg-red-300 px-1 rounded-2xl">12</span> -->
          <button class="ml-1">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500 hover:text-gray-900" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M3 5a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 10a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zM3 15a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1z" clip-rule="evenodd" />
            </svg>
          </button>
        </div>
      </div>
    </div>
    """
  end
end
