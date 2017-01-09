defmodule Scrawler.Router do
  use Scrawler.Web, :router
  use Passport

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :current_user
  end

  pipeline :authenticated do
    plug Scrawler.Plug.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Scrawler do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/session", SessionController, :create
    get "/join", RegistrationController, :new
    post "/register", RegistrationController, :create
    get "/passwords/new", PasswordController, :new
    post "/passwords", PasswordController, :reset
  end

  scope "/", Scrawler do
    pipe_through [:browser, :authenticated]

    get "/", WelcomeController, :index
    get "/logout", SessionController, :delete

    resources "/users", UserController
    resources "/links", LinkController, only: [:index, :show, :new, :create, :delete]
  end

  # Other scopes may use custom stacks.
  # scope "/api", Scrawler do
  #   pipe_through :api
  # end
end
