defmodule RentTodayWeb.FilmController do
  use RentTodayWeb, :controller

  def view(conn, _params) do
    conn
    |> render("view.html")
  end

  def basket(conn, _params) do
    conn
    |> render("basket.html")
  end

  def detail(conn, _params) do
    conn
    |> render("detail.html")
  end
end
