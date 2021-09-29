defmodule CardUploadFile do
  use Surface.LiveComponent
  alias Surface.Components.Link

  prop(task_id, :string, required: true)
  prop(board_id, :string, required: true)
  data(card_upload_file_info, :map, default: %{})

  def render(assigns) do
    ~F"""
    <div id="card_upload_file_info_container">
      <div :if={Map.get(@card_upload_file_info, "files") && length(Map.get(@card_upload_file_info, "files"))>0} class="flex flex-col mt-1">
        <div class="flex items-center">
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 text-gray-500" viewBox="0 0 20 20" fill="currentColor">
            <path fill-rule="evenodd" d="M8 4a3 3 0 00-3 3v4a5 5 0 0010 0V7a1 1 0 112 0v4a7 7 0 11-14 0V7a5 5 0 0110 0v4a3 3 0 11-6 0V7a1 1 0 012 0v4a1 1 0 102 0V7a3 3 0 00-3-3z" clip-rule="evenodd" />
          </svg>
          <span class="text-gray-500 text-base font-bold">附件</span>
        </div>
        <div class="flex flex-col mt-1">
          {#for file <- Map.get(@card_upload_file_info, "files")}
          <div class="flex items-center justify-between p-2 bg-gray-100">
            <Link
              to={"#{Application.get_env(:live_board, :old_base_url)}/kanban/task/downloadFile/#{@board_id}/#{@task_id}/#{file["id"]}"}
              class="max-w-[500px] truncate text-sm text-[#428bca] hover:text-[#2a6496] hover:underline"
              opts={target: "_blank"}
            >{file["name"]}</Link>
            <div class="flex items-center lg-placeholder-text">
              <span class="mr-1 text-xs text-gray-500">{file["size"]/1000 |> Float.round(2)}KB</span>
              <span class="mr-2 text-xs text-gray-500">{file["time"]}</span>
              <Link
                to={"#{Application.get_env(:live_board, :old_base_url)}/kanban/task/downloadFile/#{@board_id}/#{@task_id}/#{file["id"]}/#{file["type"]}"}
                opts={title: "下载", download: file["name"]}
              >
                <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500 mx-1 hover:text-[#2a6496] cursor-pointer" viewBox="0 0 20 20" fill="currentColor">
                  <path fill-rule="evenodd" d="M3 17a1 1 0 011-1h12a1 1 0 110 2H4a1 1 0 01-1-1zm3.293-7.707a1 1 0 011.414 0L9 10.586V3a1 1 0 112 0v7.586l1.293-1.293a1 1 0 111.414 1.414l-3 3a1 1 0 01-1.414 0l-3-3a1 1 0 010-1.414z" clip-rule="evenodd" />
                </svg>
              </Link>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500 mx-1 hover:text-[#2a6496] cursor-pointer" viewBox="0 0 20 20" fill="currentColor">
                <path d="M13.586 3.586a2 2 0 112.828 2.828l-.793.793-2.828-2.828.793-.793zM11.379 5.793L3 14.172V17h2.828l8.38-8.379-2.83-2.828z" />
              </svg>
              <svg xmlns="http://www.w3.org/2000/svg" class="h-4 w-4 text-gray-500 mx-1 hover:text-[#2a6496] cursor-pointer" viewBox="0 0 20 20" fill="currentColor">
                <path fill-rule="evenodd" d="M9 2a1 1 0 00-.894.553L7.382 4H4a1 1 0 000 2v10a2 2 0 002 2h8a2 2 0 002-2V6a1 1 0 100-2h-3.382l-.724-1.447A1 1 0 0011 2H9zM7 8a1 1 0 012 0v6a1 1 0 11-2 0V8zm5-1a1 1 0 00-1 1v6a1 1 0 102 0V8a1 1 0 00-1-1z" clip-rule="evenodd" />
              </svg>
            </div>
          </div>
          {/for}
        </div>
      </div>
    </div>
    """
  end

  def init_data(id, data) do
    send_update(__MODULE__, id: id, card_upload_file_info: data)
  end
end
