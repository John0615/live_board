defmodule BoardNav do
  use Surface.LiveComponent
  alias Surface.Components.Link

  prop(board_data, :map, required: true)

  def render(assigns) do
    ~F"""
    <header class="px-2 bg-black bg-opacity-[0.15]">
      <div class="flex relative justify-between items-center py-1 border-gray-200">
        <div class="flex items-center">
          <div class="relative">
            <img class="h-[34px]" title="返回首页" alt="Leangoo" src="https://www.leangoo.com/kanban/application/views/images/leangoo_logo.png">
          </div>
          <div class="relative w-50 pt-1">
            <input type="text" class="transition duration-500  transform focus:bg-white focus:outline-none focus:w-72 rounded-xl bg-[rgba(255,255,255,0.3)] w-[200px] h-[28px] pl-2 pr-5 py-2 text-sm leading-tight text-gray-900 placeholder-gray-600" />
            <span class="absolute inset-y-0 right-2 pt-1 pl-3 flex items-center">
              <span class="leangoo icon-search text-sm text-white"></span>
            </span>
          </div>
        </div>
        <div class="absolute left-1/2 -ml-32 flex flex-shrink-0">
          <button class="flex flex-row items-center focus:outline-none">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
            </svg>
            <span class="text-white text-sm">领鸽软件开发 - Leangoo研发</span>
          </button>
        </div>
        <div class="flex items-center">
          <button class="h-8 px-1 focus:outline-none hover:bg-[rgba(255,255,255,.3)] bg-[rgba(255,255,255,.2)] rounded">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" viewBox="0 0 20 20" fill="currentColor">
              <path fill-rule="evenodd" d="M10 3a1 1 0 011 1v5h5a1 1 0 110 2h-5v5a1 1 0 11-2 0v-5H4a1 1 0 110-2h5V4a1 1 0 011-1z" clip-rule="evenodd" />
            </svg>
          </button>
          <div class="flex w-30 h-8 mx-1  bg-[rgba(255,255,255,.2)] rounded">
            <button class="h-8 px-1 focus:outline-none px-1  rounded hover:bg-[rgba(255,255,255,.3)]">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" viewBox="0 0 20 20" fill="currentColor">
                <path d="M5 3a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2V5a2 2 0 00-2-2H5zM5 11a2 2 0 00-2 2v2a2 2 0 002 2h2a2 2 0 002-2v-2a2 2 0 00-2-2H5zM11 5a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V5zM11 13a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
              </svg>
            </button>
            <button class="flex flex-row items-center px-1 border-l focus:outline-none flex-shrink-0 hover:bg-[rgba(255,255,255,.3)]">
              <span class="text-sm text-white">看板导航</span>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M5.293 7.293a1 1 0 011.414 0L10 10.586l3.293-3.293a1 1 0 111.414 1.414l-4 4a1 1 0 01-1.414 0l-4-4a1 1 0 010-1.414z" clip-rule="evenodd" />
              </svg>
            </button>
          </div>
          <button :on-click={"show_personal_action_option", target: "#personal_action_option_dropdown_container"}
            class="personal_action w-20 h-8 hover:bg-[rgba(255,255,255,.3)]
            bg-[rgba(255,255,255,.2)] flex flex-row items-center rounded mr-1 focus:outline-none">
            {#if @board_data["board"] && @board_data["board"]["users"]}
            {#case Enum.find(@board_data["board"]["users"], fn user_info -> user_info["id"] == @board_data["current_user"]["current_user_id"] end)}
              {#match nil}
                ""
              {#match %{"head_img_path" => ""} = linked_user_info}
                <span title={linked_user_info["email"]} class="w-8 h-8 text-[12px] leading-8 font-bold rounded-[4px] bg-[#ccc] cursor-pointer">{linked_user_info["head_img_letter"]}</span>
              {#match %{"head_img_path" => head_img_path}}
                <img class="w-8 h-8 rounded-l" src={"#{Application.get_env(:live_board, :live_base_url)}/kanban"<>head_img_path} alt="">
              {#match _}
            {/case}
            {/if}
            <span class="text-white m-auto">{@board_data["current_user"]["current_user_name"]}</span>
          </button>
          <button class="h-8 px-1 rounded mr-1 focus:outline-none hover:bg-[rgba(255,255,255,.3)] bg-[rgba(255,255,255,.2)]">
            <Link to="https://www.leangoo.com/help.html">
              <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8.228 9c.549-1.165 2.03-2 3.772-2 2.21 0 4 1.343 4 3 0 1.4-1.278 2.575-3.006 2.907-.542.104-.994.54-.994 1.093m0 3h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </Link>
          </button>
          <button class="h-8 px-1 rounded focus:outline-none hover:bg-[rgba(255,255,255,.3)] bg-[rgba(255,255,255,.2)]">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
            </svg>
          </button>
        </div>
      </div>
      <!--导航栏用户头像功能下拉框-->
      <PersonalActionOptionDropdown id="component_personal_action_option_dropdown" />
      <!--背景设置下拉框-->
      <BackgoundSetting id="component_background_setting" />
    </header>
    """
  end
end
