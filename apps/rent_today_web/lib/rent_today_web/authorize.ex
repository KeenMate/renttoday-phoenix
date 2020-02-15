defmodule RentTodayWeb.Authorize do
  use Timex
  import Plug.Conn
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def restrict_roles(conn, allowed_roles: allowed_roles) do
    roles = get_claims_key(conn, :roles, [])

    resolve(conn, role_allowed(roles, allowed_roles))
  end

  def restrict_age(conn, min_age: min_age) do
    date_of_birth = get_claims_key(conn, :age, Timex.today)

    resolve(conn, age_restriction(date_of_birth, min_age))
  end

  def document_permissions(conn, permissions: permissions) do
    user = get_claims_key(conn, :user)

    %{path_params: %{"id" => document_id_string}} = conn
    document_id = String.to_integer(document_id_string)
    %{^document_id => document_permissions} = permissions

    IO.inspect user, label: "User"
    IO.inspect document_permissions, label: "Document users"

    resolve(conn, Enum.member?(document_permissions, user))
  end

  def authenticated(conn, _opts) do
    is_authenticated(conn, get_session(conn, :authenticated))
  end

  defp resolve(conn, true) do
    IO.puts "Resolve success"
    conn
  end

  defp resolve(conn, false) do
    IO.puts "Resolve fail"
    conn
    |> put_flash(:error, "Unauthorized")
    |> redirect(to: RentTodayWeb.Router.Helpers.login_path(conn, :new))
    |> halt()
  end

  defp role_allowed(roles, allowed_roles) do
    allowed_roles_count = Enum.count(allowed_roles)

    Enum.count(allowed_roles -- roles) < allowed_roles_count
  end

  defp age_restriction(date_of_birth, min_age) do
    max_date = Timex.shift(Timex.today, years: -min_age)

    Timex.before?(date_of_birth, max_date)
  end

  defp is_authenticated(conn, true) do
    assign(conn, :current_user, get_session(conn, :user))
  end

  defp is_authenticated(conn, nil) do
    conn
    |> put_flash(:error, "You're not authorized to view this page")
    |> redirect(to: RentTodayWeb.Router.Helpers.login_path(conn, :new))
  end

  defp get_claims(conn) do
    get_session(conn, :claims)
  end

  defp get_claims_key(conn, key, default \\ nil) do
    get_claims(conn) |> Map.get(key, default)
  end
end
