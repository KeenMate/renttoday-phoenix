defmodule RentToday.Rental do
  use Ecto.Schema
  import Ecto.Changeset
  import RentToday.Helpers.Timestamps

  @primary_key {:rental_id, :integer, []}
  @schema_prefix "public"

  schema "rental" do
    field :rental_date, :utc_datetime
    field :inventory_id, :integer
    field :film_title, :string
    field :customer_id, :integer
    field :customer_name, :string
    field :return_date, :utc_datetime
    field :staff_id, :integer
    field :staff_name, :string

    RentToday.Helpers.Timestamps.timestamps()
  end

  def changeset(rental, attrs) do
    rental
    |> cast(attrs, [:rental_date, :inventory_id, :film_title, :customer_id, :customer_name, :return_date, :staff_id, :staff_name, :created_by, :modified_by])
    |> validate_required([:rental_date, :inventory_id, :film_title, :customer_id, :customer_name, :return_date, :staff_id, :staff_name, :created_by, :modified_by])
  end
end
