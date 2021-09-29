defmodule BackgoundSetting do
  use Surface.LiveComponent

  data(is_show, :boolean, default: false)

  data(arr_color, :list,
    default: [
      %{
        "group" => [
          %{"color" => "#CE7822"},
          %{"color" => "#FF8C00"},
          %{"color" => "#E81123"},
          %{"color" => "#BF4040"},
          %{"color" => "#C30052"},
          %{"color" => "#BF0077"},
          %{"color" => "#9A0089"},
          %{"color" => "#881798"}
        ]
      },
      %{
        "group" => [
          %{"color" => "#379E5A"},
          %{"color" => "#10893E"},
          %{"color" => "#107C10"},
          %{"color" => "#018574"},
          %{"color" => "#2D7D9A"},
          %{"color" => "#0E74AF"},
          %{"color" => "#0063B1"},
          %{"color" => "#8D5C99"}
        ]
      },
      %{
        "group" => [
          %{"color" => "#8E8CD8"},
          %{"color" => "#6B69D6"},
          %{"color" => "#486860"},
          %{"color" => "#808080"},
          %{"color" => "#7E736F"},
          %{"color" => "#515C6B"},
          %{"color" => "#4C4A48"},
          %{"color" => "#000000"}
        ]
      }
    ]
  )

  data(arr_img, :list,
    default: [
      "30.jpg",
      "31.jpg",
      "33.jpg",
      "10.jpg",
      "32.jpg",
      "34.jpg",
      "星空.jpg",
      "37.jpg",
      "38.jpg",
      "7.jpg",
      "40.jpg",
      "41.jpg",
      "42.jpg",
      "43.jpg",
      "44.jpg",
      "45.jpg",
      "46.jpg",
      "47.jpg",
      "48.jpg",
      "1.jpg",
      "50.jpg",
      "51.jpg",
      "52.jpg",
      "53.jpg",
      "54.jpg",
      "55.jpg",
      "56.jpg",
      "57.jpg",
      "58.jpg",
      "59.jpg",
      "60.jpg",
      "61.jpg",
      "62.jpg",
      "63.jpg",
      "64.jpg",
      "65.jpg",
      "66.jpg",
      "67.jpg",
      "3.jpg",
      "69.jpg",
      "70.jpg",
      "12.jpg",
      "4.jpg",
      "73.jpg",
      "74.jpg",
      "75.jpg",
      "76.jpg",
      "77.jpg",
      "78.jpg",
      "79.jpg",
      "80.jpg",
      "81.jpg",
      "82.jpg",
      "83.jpg",
      "84.jpg",
      "85.jpg",
      "86.jpg",
      "87.jpg",
      "88.jpg",
      "89.jpg",
      "90.jpg",
      "91.jpg",
      "92.jpg",
      "纽约.jpg",
      "94.jpg",
      "95.jpg",
      "96.jpg",
      "21.jpg",
      "2.jpg",
      "帆船酒店.jpg",
      "100.jpg",
      "101.jpg",
      "小萝莉.jpg",
      "103.jpg",
      "104.jpg",
      "105.jpg",
      "106.jpg",
      "107.jpg",
      "108.jpg",
      "109.jpg",
      "110.jpg",
      "111.jpg",
      "112.jpg",
      "113.jpg",
      "114.jpg",
      "115.jpg",
      "116.jpg",
      "117.jpg",
      "17.jpg",
      "19.jpg"
    ]
  )

  def render(assigns) do
    ~F"""
    <nav id="background_setting_container" :hook="BackgroundSetting" data-popper-arrow class="flex flex-col z-20 max-h-[500px]">
      <div :if={@is_show} x-data x-init="BackgroundSetting.init()"
        class="w-96 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none" role="menu" >
        <div class="px-4 py-3" role="none">
          <p class="text-sm font-medium text-gray-900 truncate" role="none">设置背景</p>
        </div>
        <div class="absolute right-[15px] top-[10px] flex">
          <button :on-click="close"
            class="bg-white rounded-md inline-flex text-gray-400 hover:text-gray-500 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500">
            <!-- Heroicon name: solid/x -->
            <svg class="h-5 w-5" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 20 20" fill="currentColor" aria-hidden="true">
              <path fill-rule="evenodd" d="M4.293 4.293a1 1 0 011.414 0L10 8.586l4.293-4.293a1 1 0 111.414 1.414L11.414 10l4.293 4.293a1 1 0 01-1.414 1.414L10 11.414l-4.293 4.293a1 1 0 01-1.414-1.414L8.586 10 4.293 5.707a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
          </button>
        </div>
        <div class="py-1 overflow-y-auto max-h-[850px]">
          <div class="bg-color-area">
            {#for group <- @arr_color}
            <div class="background-color-row flex flex-row justify-center mt-[5px]">
              {#for item <- group["group"]}
              <button :on-click={"setting_background", target: :live_view} :values={color: item["color"]} class="w-10 h-10 rounded cursor-pointer mx-[2px]" style={"background-color: #{item["color"]}"}></button>
              {/for}
            </div>
            {/for}
          </div>
          <hr class="my-6 w-11/12 mx-auto">
          <div class="bg-image-area flex flex-wrap justify-center">
            {#for img_name <- @arr_img }
            <div :on-click={"setting_background", target: :live_view} :values={img_name: img_name} class="board-background-wrapper w-[29%] mx-[6px] h-[74px] mb-[8px]">
              <span class="board-background inline-block w-full h-full cursor-pointer rounded bg-cover" style={"background-image: url('#{Application.get_env(:live_board, :old_base_url)}/kanban/application/views/images/background/min/#{img_name}')"}></span>
            </div>
            {/for}
          </div>
        </div>
      </div>
    </nav>
    """
  end

  def show() do
    send_update(__MODULE__, id: "component_background_setting", is_show: true)
  end

  def handle_event("close", _params, socket) do
    {:noreply, assign(socket, :is_show, false)}
  end
end
