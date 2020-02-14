defmodule RentToday.Film.Schema do
  use Ecto.Schema
  import Ecto.Changeset
  require RentToday.Helpers.Timestamps

  @primary_key {:film_id, :integer, []}
  @schema_prefix "public"

  schema "film" do
    field :description, :string
    field :language_id, :integer
    field :length, :integer
    field :original_language_id, :integer
    field :rating, :string
    field :release_year, :integer
    field :rental_duration, :integer
    field :rental_rate, :decimal
    field :replacement_cost, :decimal
    field :special_features, {:array, :string}
    field :title, :string
    many_to_many :actors, RentToday.Actor.Schema, join_through: "film_actor", join_keys: [film_id: :film_id, actor_id: :actor_id]

    RentToday.Helpers.Timestamps.timestamps()
  end

  @doc false
  def changeset(film, attrs) do
    film
    |> cast(attrs, [:created_by, :modified_by, :film_id, :title, :description, :release_year, :language_id, :original_language_id, :rental_duration, :rental_rate, :length, :replacement_cost, :rating, :special_features])
    |> validate_required([:created_by, :modified_by, :film_id, :title, :description, :release_year, :language_id, :original_language_id, :rental_duration, :rental_rate, :length, :replacement_cost, :rating, :special_features])
  end
end

defmodule RentToday.Film do
  alias RentToday.Film.{Schema}
  alias RentToday.Repo

  def get_by_id(id) do
    Repo.get(Schema, id) |> Repo.preload(:actors)
  end

  def delete_by_id(id) do
    Repo.delete(get_by_id(id))
  end
end
