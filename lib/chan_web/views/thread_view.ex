defmodule ChanWeb.ThreadView do
  use ChanWeb, :view
  alias ChanWeb.ThreadView
  alias ChanWeb.PostView

  def render("index.json", %{threads: threads}) do
    %{data: render_many(threads, ThreadView, "thread.json")}
  end

  def render("show.json", %{thread: thread}) do
    %{data: render_one(thread, ThreadView, "thread.json")}
  end

  def render("thread.json", %{thread: thread}) do
    %{id: thread.id,
      subject: thread.subject,
      posts: render_many(thread.posts, PostView, "post.json")}
  end
end
