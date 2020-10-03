defmodule LiveBoard.Repo do
  use Ecto.Repo,
    otp_app: :live_board,
    adapter: Ecto.Adapters.Postgres
end
