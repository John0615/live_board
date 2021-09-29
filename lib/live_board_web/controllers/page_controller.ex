defmodule LiveBoardWeb.PageController do
  use LiveBoardWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
