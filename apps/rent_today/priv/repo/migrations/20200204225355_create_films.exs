defmodule RentToday.Repo.Migrations.CreateFilms do
  use Ecto.Migration

  def change do
    create table(:films) do
      add :created, :utc_datetime
      add :created_by, :string
      add :modified, :utc_datetime
      add :modified_by, :string
      add :film_id, :integer
      add :title, :string
      add :description, :string
      add :release_year, :integer
      add :language_id, :integer
      add :original_language_id, :integer
      add :rental_duration, :integer
      add :rental_rate, :decimal
      add :length, :integer
      add :replacement_cost, :decimal
      add :rating, :string
      add :special_features, :string

      timestamps()
    end

  end
end
