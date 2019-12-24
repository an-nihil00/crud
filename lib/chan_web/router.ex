defmodule ChanWeb.Router do
  use ChanWeb, :router

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

  scope "/api", ChanWeb do
    pipe_through :api

    resources "/", BoardController, only: [:index, :show] do
      resources "/", ThreadController, only: [:show, :create, :delete] do
	resources "/", PostController, only: [:create, :delete]
      end
    end
  end

  scope "/", ChanWeb do
    pipe_through :browser

    get "/*path", PageController, :index
  end
end
