defmodule ChanWeb.ThreadController do
  use ChanWeb, :controller

  alias Chan.Threads
  alias Chan.Threads.Thread
  alias Chan.Posts
  alias Chan.Posts.Post
  alias Chan.Boards
  alias Chan.Repo
  alias Chan.Posts.Upload

  action_fallback ChanWeb.FallbackController

  def index(conn, %{"board_id" => board_id}) do
    board = Boards.get_board!(board_id)
    threads = Threads.list_threads(board_id)
    changeset = %Thread{} |> Thread.changeset(%{posts: [%{}]})
    render(conn, "catalog.html", board: board, threads: threads, changeset: changeset)
  end

  def create(conn, %{"thread" => thread_params,
		     "board_id" => board_id,
		     "options" => options,
		     "file" => file}) do
    case Threads.create_thread(thread_params, board_id) do
      {:ok, thread} ->
	IO.inspect(thread)
	with {:ok, %Upload{}} <- Posts.create_upload_from_plug_upload(file, board_id, Enum.at(thread.posts,0).id) do
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
      {:error, errors} ->
	IO.inspect(errors)
	board = Boards.get_board!(board_id)
	pages = Threads.list_threads(board_id) |>
	  Enum.chunk_every(10)
	page_count = max(Enum.count(pages),1)
	threads = case pages do
		    [] ->
		      []
		    [ _ | _ ] ->
		      Enum.at(pages,0)
		  end
	render(conn, ChanWeb.BoardView, "show.html", board: board, threads: threads, page: 1, pages: page_count, changeset: errors)
    end
  end
  
  def create(conn, %{"thread" => thread_params,
		     "board_id" => board_id,
		     "options" => options}) do
    IO.inspect(thread_params)
    board = Boards.get_board!(board_id)
    pages = Threads.list_threads(board_id) |>
      Enum.chunk_every(10)
    page_count = max(Enum.count(pages),1)
    threads = case pages do
		[] ->
		  []
		[ _ | _ ] ->
		  Enum.at(pages,0)
	      end
    { _ , changeset }=
      %Thread{}
      |> Thread.changeset(thread_params)
      |> Ecto.Changeset.add_error(:file, "no file selected")
      |> Ecto.Changeset.apply_action(:insert)
    render(conn, ChanWeb.BoardView,
      "show.html",
      board: board,
      threads: threads,
      page: 1,
      pages: page_count,
      changeset: changeset)
  end

  def show(%{private: %{phoenix_format: format}} = conn, %{"id" => id, "board_id" => board_id}) do
    board = Boards.get_board!(board_id)
    thread = Threads.get_thread!(id,board_id)
    changeset = %Post{} |> Post.changeset(%{name: ""})
    render(conn, "show.#{format}", board: board, thread: thread, changeset: changeset)
  end
end
