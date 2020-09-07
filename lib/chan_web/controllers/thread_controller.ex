defmodule ChanWeb.ThreadController do
  use ChanWeb, :controller

  alias Chan.Threads
  alias Chan.Threads.Thread
  alias Chan.Posts
  alias Chan.Posts.Post
  alias Chan.Boards
  alias Chan.Repo

  action_fallback ChanWeb.FallbackController

  def index(conn, %{"board_id" => board_id}) do
    board = Boards.get_board!(board_id)
    threads = Threads.list_threads(board_id)
    changeset = %Thread{} |> Thread.changeset(%{posts: [%{name: "Anonymous"}]})
    render(conn, "catalog.html", board: board, threads: threads, changeset: changeset)
  end

  def create(conn, %{"thread" => thread_params, "board_id" => board_id, "options" => options}) do
    case Threads.create_thread(thread_params, board_id) do
      {:ok, thread} ->
	if String.contains? options, "nonoko" do
	  conn
	  |> put_status(302)
	  |> redirect(to: Routes.board_path(conn, :show, board_id))
	else
	  conn
	  |> put_status(302)
	  |> redirect(to: Routes.board_thread_path(conn, :show, board_id,thread.id))
	end
      {:error, errors} ->
	board = Boards.get_board!(board_id)
	threads = Threads.list_threads(board_id)
	render(conn, ChanWeb.BoardView, "show.html", board: board, threads: threads, changeset: errors)
    end
  end

  def show(%{private: %{phoenix_format: format}} = conn, %{"id" => id, "board_id" => board_id}) do
    board = Boards.get_board!(board_id)
    thread = Threads.get_thread!(id,board_id)
    changeset = %Post{} |> Post.changeset(%{name: "Anonymous"})
    render(conn, "show.#{format}", board: board, thread: thread, changeset: changeset)
  end

  def update(conn, %{"id" => id, "thread" => thread_params}) do
    thread = Threads.get_thread!(id)

    with {:ok, %Thread{} = thread} <- Threads.update_thread(thread, thread_params) do
      render(conn, "show.json", thread: thread)
    end
  end

  def delete(conn, %{"id" => id}) do
    thread = Threads.get_thread!(id)

    with {:ok, %Thread{}} <- Threads.delete_thread(thread) do
      send_resp(conn, :no_content, "")
    end
  end
end
