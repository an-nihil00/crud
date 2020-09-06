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
    boards = Boards.list_boards()
    threads = Threads.list_threads(board_id)
    changeset = %Thread{} |> Thread.changeset(%{posts: [%{}]})
    render(conn, "catalog.html", board: board, threads: threads, boards: boards, changeset: changeset)
  end

  def create(conn, %{"thread" => thread_params, "board_id" => board_id}) do
    with {:ok, %Thread{} = thread} <- Threads.create_thread(thread_params, board_id) do
      conn
      |> put_status(302)
      |> redirect(to: Routes.board_thread_path(conn, :show, board_id,thread.id))
    end
  end

  def show(%{private: %{phoenix_format: format}} = conn, %{"id" => id, "board_id" => board_id}) do
    board = Boards.get_board!(board_id)
    boards = Boards.list_boards()
    thread = Threads.get_thread!(id,board_id)
    changeset = %Post{} |> Post.changeset(%{})
    render(conn, "show.#{format}", board: board, boards: boards, thread: thread, changeset: changeset)
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
