defmodule Mybs.Router do
  use Mybs.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Mybs do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/design", PageController, :design
    get "/race_chart", PageController, :race_chart
  end

  # Other scopes may use custom stacks.
  scope "/api", Mybs.Api, as: :api do
    pipe_through :api
    resources "/races", RaceController, only: [:index]
  end
end
