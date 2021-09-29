defmodule LiveBoard.Plug.Session do
  import Plug.Conn, only: [put_session: 3]

  def put_session(conn, _opts) do
    cookie =
      Enum.filter(conn.cookies, fn {key, _value} -> key != "_live_board_key" end)
      |> Enum.map(fn {key, value} -> "#{key}=#{value}" end)
      |> Enum.join("; ")

    conn =
      conn
      |> put_session(:cookie, cookie)

    conn
  end
end
