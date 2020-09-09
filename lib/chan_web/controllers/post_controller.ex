defmodule ChanWeb.PostController do
  use ChanWeb, :controller

  alias Chan.Posts
  alias Chan.Posts.Post
  alias Chan.Threads

  action_fallback ChanWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params, "thread_id" => thread_id, "board_id" => board_id, "options" => options}) do
    thread = Threads.get_thread!(thread_id,board_id)
    with {:ok, %Post{} = post} <- Posts.create_post(post_params, thread, board_id, String.contains?(options, "sage")) do
      if String.contains? options, "nonoko" do
	conn
	|> put_status(302)
	|> redirect(to: Routes.board_path(conn, :show, board_id))
      else
	conn
	|> put_status(302)
	|> redirect(to: Routes.board_thread_path(conn, :show, board_id,thread.id))
      end
    end
  end

  def show(conn, %{"id" => id}) do
    post = Posts.get_post!(id)
    render(conn, "show.json", post: post)
  end

  def update(conn, %{"id" => id, "post" => post_params}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{} = post} <- Posts.update_post(post, post_params) do
      render(conn, "show.json", post: post)
    end
  end

  def delete(conn, %{"id" => id}) do
    post = Posts.get_post!(id)

    with {:ok, %Post{}} <- Posts.delete_post(post) do
      send_resp(conn, :no_content, "")
    end
  end
end
