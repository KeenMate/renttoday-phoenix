defmodule RentToday.Inventory do
  use Ecto.Schema
  import Ecto.Changeset
  import RentToday.Helpers.Timestamps

  @primary_key {:inventory_id, :integer, []}
  @schema_prefix "public"

  schema "inventory" do
    field :film_id, :integer
    field :store_id, :integer

    RentToday.Helpers.Timestamps.timestamps()
  end

  @doc false
  def changeset(inventory, attrs) do
    inventory
    |> cast(attrs, [:created_by, :modified_by, :film_id, :store_id])
    |> validate_required([:created_by, :modified_by, :film_id, :store_id])
  end
end
