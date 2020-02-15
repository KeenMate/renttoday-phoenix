defmodule RentTodayWeb.Router do
  use RentTodayWeb, :router
  import RentTodayWeb.Authorize, only: [authenticated: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authorized do
    plug :authenticated
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", RentTodayWeb do
    pipe_through :browser

    get "/", PageController, :index

    get "/login", LoginController, :new
    post "/login", LoginController, :create
    get "/logout", LoginController, :delete

    get "/film", FilmController, :view
    get "/film/detail", FilmController, :detail
    get "/basket", FilmController, :basket
  end

  scope "/user", RentTodayWeb do
    pipe_through [:browser, :authorized]

    get "/", UserController, :view
    get "/profile", UserController, :profile
    get "/noob", UserController, :noob
    get "/master", UserController, :master
    get "/adult", UserController, :adult
    get "/adult-master", UserController, :adult_master
    get "/document/:id", UserController, :document
  end

  # Other scopes may use custom stacks.
  # scope "/api", RentTodayWeb do
  #   pipe_through :api
  # end
end
