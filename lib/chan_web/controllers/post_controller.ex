defmodule ChanWeb.PostController do
  use ChanWeb, :controller

  alias Chan.Posts
  alias Chan.Posts.Post
  alias Chan.Threads
  alias Chan.Posts.Passwords

  action_fallback ChanWeb.FallbackController

  def index(conn, _params) do
    posts = Posts.list_posts()
    render(conn, "index.json", posts: posts)
  end

  def create(conn, %{"post" => post_params, "thread_id" => thread_id, "board_id" => board_id, "options" => options}) do
    thread = Threads.get_thread!(thread_id,board_id)
    with {:ok, %Post{}} <- Posts.create_post(post_params, thread, board_id, String.contains?(options, "sage")) do
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

  
  
  def delete(conn, %{"board_id" => board_id, "delete" => delete}) do
    %{"threads" => threads, "posts" => posts, "password" => password} = Map.merge(%{"threads" => %{}, "posts" => %{}},delete)
    thread_ids = threads
    |> Map.keys
    |> Enum.filter(fn t -> threads[t]=="true" end)
    |> Enum.map(&String.to_integer/1) 

    post_ids = posts
    |> Map.keys
    |> Enum.filter(fn t -> posts[t]=="true" end)
    |> Enum.map(&String.to_integer/1)
    
    for id <- thread_ids do
      thread = Threads.get_thread!(id, board_id)
      op = Enum.at(thread.posts,0)
      case Passwords.validate_password(op, password) do
	{:ok, _ } ->
	  Threads.delete_thread(thread, board_id)
	{:error, errors} ->
	  IO.inspect(errors)
      end
    end
    for id <- post_ids do
      post = Posts.get_post!(id, board_id)
      case Passwords.validate_password(post, password) do
	{:ok, _ } ->
	  Posts.delete_post(post, board_id)
	{:error, errors} ->
	  IO.inspect(errors)
      end
    end

    conn
    |> put_status(302)
    |> redirect(to: Routes.board_path(conn, :show, board_id))
  end
end
