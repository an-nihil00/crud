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

  scope "/", ChanWeb do
    pipe_through :browser

    get "/", PageController, :index
    #get "/:board", PageController, :board
    #get "/:board/:id", PageController, :thread
    
  end

  scope "/api", ChanWeb do
    pipe_through :api

    resources "/", BoardController, only: [:index] do
      resources "/", ThreadController, only: [:index, :show, :create, :delete] do
	resources "/", PostController, only: [:create, :delete]
      end
    end
  end
end
