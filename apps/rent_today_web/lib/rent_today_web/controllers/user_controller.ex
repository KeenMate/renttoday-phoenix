defmodule RentTodayWeb.UserController do
  import RentTodayWeb.Authorize
  use RentTodayWeb, :controller

  @document_permissions %{1 => ["albert", "ondra"], 2 => ["ondra"]}

  plug :restrict_age, [min_age: 18] when action in [:adult, :adult_master]
  plug :restrict_roles, [allowed_roles: ["master"]] when action in [:master, :adult_master]
  plug :restrict_roles, [allowed_roles: ["master", "noob"]] when action in [:noob]
  plug :document_permissions, [permissions: @document_permissions] when action in [:document]

  def profile(conn, _params) do
    conn
    |> render("profile.html")
  end

  def view(conn, _params) do
    render conn, "view.html"
  end

  def noob(conn, _params) do
    render conn, "noob.html"
  end

  def master(conn, _params) do
    render conn, "master.html"
  end

  def adult(conn, _params) do
    render conn, "adult.html"
  end

  def adult_master(conn, _params) do
    render conn, "adult-master.html"
  end

  def document(conn, %{"id" => id}) do
    render conn, "view.html"
  end
end
