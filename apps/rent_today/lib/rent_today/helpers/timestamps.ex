defmodule RentToday.Helpers.Timestamps do
  defmacro timestamps(opts \\ []) do
    quote bind_quoted: binding() do
      Ecto.Schema.field(:created, :utc_datetime, opts)
      Ecto.Schema.field(:created_by, :string, opts)
      Ecto.Schema.field(:modified, :utc_datetime, opts)
      Ecto.Schema.field(:modified_by, :string, opts)
    end
  end
end
