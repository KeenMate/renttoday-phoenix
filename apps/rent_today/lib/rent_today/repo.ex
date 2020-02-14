defmodule RentToday.Repo do
  use Ecto.Repo,
    otp_app: :rent_today,
    adapter: Ecto.Adapters.Postgres
end
