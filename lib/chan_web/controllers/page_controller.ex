defmodule ChanWeb.PageController do
  use ChanWeb, :controller

  def index(conn, _params) do
    posts = Chan.Posts.list_posts |> Enum.take 15
    images = Chan.Posts.list_uploads |> Enum.take 5
    total_posts = Chan.Posts.list_posts |> Enum.count
    total_images = Chan.Posts.list_uploads |> Enum.count
    render(conn, "index.html",
      recent_posts: posts,
      recent_images: images,
      total_posts: total_posts,
      total_images: total_images)
  end
end
