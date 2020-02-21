import Config

config :rent_today, RentToday.Repo,
  # ssl: true,
  url: System.fetch_env!("DATABASE_URL"),
  pool_size: String.to_integer(System.fetch_env!("POOL_SIZE"))

config :rent_today_web, RentTodayWeb.Endpoint,
  server: true,
  http: [:inet6, port: String.to_integer(System.fetch_env!("PORT"))],
  secret_key_base: System.fetch_env!("SECRET_KEY_BASE")
