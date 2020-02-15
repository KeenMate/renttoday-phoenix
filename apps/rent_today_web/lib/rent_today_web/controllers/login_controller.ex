defmodule RentTodayWeb.LoginController do
  use RentTodayWeb, :controller

  def new(conn, _params) do
    conn
    |> put_layout("login.html")
    |> render("new.html")
  end

  def create(conn, %{"user" => %{"email" => username, "password" => password, "remember" => remember}}) do
    conn
    |> put_session(:authenticated, true)
    |> put_session(:user, username)
    |> put_session(:claims, build_claims(username))
    |> put_flash(:info, "Logged-in succesfully")
    |> redirect(to: Routes.user_path(conn, :view))
  end

  def delete(conn, _params) do
    conn
    |> clear_session()
    |> configure_session(drop: true)
    |> put_flash(:info, "Logged out")
    |> redirect(to: Routes.page_path(conn, :index))
  end

  defp build_claims(user = "ondra") do
    %{user: user, roles: ["master"], age: Date.from_iso8601!("1980-01-01")}
  end

  defp build_claims(user = "albert") do
    %{user: user, roles: ["noob"], age: Date.from_iso8601!("2005-01-01")}
  end

  defp build_claims(user) do
    %{user: user}
  end
end
