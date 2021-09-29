defmodule PersonalActionOptionDropdown do
  use Surface.LiveComponent

  data(is_show, :boolean, default: false)

  data(options, :list,
    default: [
      %{
        "options" => [
          %{
            "name" => "个人中心",
            "key" => "personal_center"
          },
          %{
            "name" => "设置背景",
            "key" => "setting_background"
          },
          %{
            "name" => "快捷键",
            "key" => "shortcut_keys"
          },
          %{
            "name" => "更改语言",
            "key" => "change_language"
          }
        ]
      },
      %{
        "options" => [
          %{
            "name" => "帮助",
            "key" => "help"
          },
          %{
            "name" => "意见反馈",
            "key" => "feedback"
          },
          %{
            "name" => "更新日志",
            "key" => "update_log"
          },
          %{
            "name" => "官网",
            "key" => "official_website"
          }
        ]
      },
      %{
        "options" => [
          %{
            "name" => "退出",
            "key" => "loginout"
          }
        ]
      }
    ]
  )

  def render(assigns) do
    ~F"""
    <div id="personal_action_option_dropdown_container" :hook="PersonalActionOptionDropdownHook"
      x-data @closepanel.window="PageLiveHook.pushEventTo('#personal_action_option_dropdown_container', 'close_personal_action_option')"
      class="z-20">
      <nav :if={@is_show} data-popper-arrow
        x-init="PersonalActionOptionDropdownHook.init()"
        class="flex flex-col z-20 max-h-[500px]">
        <div class="w-44 rounded-md shadow-lg bg-white ring-1 ring-black ring-opacity-5 divide-y divide-gray-100 focus:outline-none" role="menu" >
          {#for option <- @options}
          <div class="py-1" role="none">
            <!-- Active: "bg-gray-100 text-gray-900", Not Active: "text-gray-700" -->
            {#for item <- option["options"]}
            <span :values={key: item["key"]} :on-click="select_option" class="cursor-pointer text-gray-700 text-left hover:bg-gray-100 block px-4 py-2 text-sm">{item["name"]}</span>
            {/for}
          </div>
          {/for}
        </div>
      </nav>
    </div>
    """
  end

  def handle_event("show_personal_action_option", _params, socket) do
    {:noreply, assign(socket, :is_show, true)}
  end

  def handle_event("close_personal_action_option", _params, socket) do
    {:noreply, assign(socket, :is_show, false)}
  end

  def handle_event("select_option", %{"key" => "personal_center"} = _params, socket) do
    {:noreply,
     redirect(socket,
       external: "#{Application.get_env(:live_board, :old_base_url)}/kanban/profile/go#/"
     )}
  end

  def handle_event("select_option", %{"key" => "setting_background"} = _params, socket) do
    BackgoundSetting.show()
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "shortcut_keys"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "change_language"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "help"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "feedback"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "update_log"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "official_website"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end

  def handle_event("select_option", %{"key" => "loginout"} = params, socket) do
    IO.inspect(params, label: "oeoeoeoeoeo", pretty: true)
    {:noreply, socket}
  end
end
