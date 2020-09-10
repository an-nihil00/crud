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

  scope "/api", ChanWeb, as: :api do
    pipe_through :api

    get "/boards", BoardController, :index 
    resources "/", BoardController, only: [:show] do
      resources "/", ThreadController, only: [:show, :create] do
	resources "/", PostController, only: [:create]
      end
    end
  end

  scope "/", ChanWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/uploads/:id", UploadController, :show
    resources "/boards", BoardController, only: [:show] do
      get "/catalog", ThreadController, :index
      get "/:page", BoardController, :show
      post "/delete", PostController, :delete
      resources "/thread", ThreadController, only: [:show, :create] do
	post "/create", PostController, :create
      end
    end
  end
end
