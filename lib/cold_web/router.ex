defmodule ColdWeb.Router do
  use ColdWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug(:put_root_layout, {ColdWeb.LayoutView, :root})
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ColdWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/users", UserController, :index
    # live "/users", UsersLive
    get "/users/new", UserController, :new
    post "/users/create", UserController, :create
    get "/users/:user_id/edit", UserController, :edit
    put "/users/:user_id/update", UserController, :update
  end

  # Other scopes may use custom stacks.
  # scope "/api", ColdWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: ColdWeb.Telemetry
    end
  end
end
