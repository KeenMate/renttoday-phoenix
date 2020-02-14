defmodule RentToday.Actor.Schema do
  use Ecto.Schema
  import Ecto.Changeset
  require RentToday.Helpers.Timestamps

  @primary_key {:actor_id, :integer, []}
  @schema_prefix "public"

  schema "actor" do
    field :first_name, :string
    field :last_name, :string
    many_to_many :films, RentToday.Film.Schema, join_through: "film_actor", join_keys: [actor_id: :actor_id, film_id: :film_id]

    RentToday.Helpers.Timestamps.timestamps()
  end
end
