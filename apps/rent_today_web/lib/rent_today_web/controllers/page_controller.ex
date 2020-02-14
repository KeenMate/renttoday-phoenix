defmodule RentTodayWeb.PageController do
  use RentTodayWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
