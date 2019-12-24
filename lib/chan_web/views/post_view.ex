defmodule ChanWeb.PostView do
  use ChanWeb, :view
  alias ChanWeb.PostView

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, PostView, "post.json")}
  end

  def render("show.json", %{post: post}) do
    %{data: render_one(post, PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{id: post.id,
      name: post.name,
      image: post.image,
      comment: post.comment}
  end
end
