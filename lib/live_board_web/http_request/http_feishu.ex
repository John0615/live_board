defmodule HttpFeishu do
  def get_app_ticket(client) do
    Tesla.post(client, "/app_ticket/resend/",
      app_id: "cli_a0e7f313f5b8900c",
      app_secret: "LhDGUTn9QolBeN927QebCcJFOhS2N3Ke"
    )
  end

  def client() do
    middleware = [
      {Tesla.Middleware.BaseUrl, "https://open.feishu.cn/open-apis/auth/v3"},
      Tesla.Middleware.EncodeFormUrlencoded,
      Tesla.Middleware.JSON
      # {Tesla.Middleware.Headers, [{"cookie", cookie}]}
    ]

    adapter = {Tesla.Adapter.Hackney, [recv_timeout: 60_000]}
    Tesla.client(middleware, adapter)
  end
end
