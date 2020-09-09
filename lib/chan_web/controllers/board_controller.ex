defmodule ChanWeb.BoardController do
  use ChanWeb, :controller

  alias Chan.Boards
  alias Chan.Boards.Board
  alias Chan.Threads
  alias Chan.Threads.Thread
  alias Chan.Posts.Post

  action_fallback ChanWeb.FallbackController

  def index(conn, _params) do
    boards = Boards.list_boards()
    render(conn, "index.json", boards: boards)
  end

  def create(conn, %{"board" => board_params}) do
    with {:ok, %Board{} = board} <- Boards.create_board(board_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.board_path(conn, :show, board))
      |> render("show.json", board: board)
    end
  end

  def show(conn, %{"id" => id}) do
    IO.puts "got here"
    show(conn, %{"board_id" => id, "page" => "1"})
  end

  def show(%{private: %{phoenix_format: format}} = conn, %{"board_id" => id, "page" => page}) do
    case Integer.parse(page) do
      :error ->
	show(conn, %{"board_id" => id, "page" => "1"})
      {number, _} ->
	board = Boards.get_board!(id)
	pages = Threads.list_threads(board.abb) |>
	  Enum.chunk_every(10)
	page_count = max(Enum.count(pages),1)
	number = min(number,page_count)
	threads = case pages do
		    [] ->
		      []
		    [ _ | _ ] ->
		      Enum.at(pages,number-1)
		  end
	changeset = %Thread{} |> Thread.changeset(%{posts: [%{name: ""}]})
	render(conn, "show.#{format}", board: board, page: number, pages: page_count, threads: threads, changeset: changeset)
    end
    
  end

  def update(conn, %{"id" => id, "board" => board_params}) do
    board = Boards.get_board!(id)

    with {:ok, %Board{} = board} <- Boards.update_board(board, board_params) do
      render(conn, "show.json", board: board)
    end
  end

  def delete(conn, %{"id" => id}) do
    board = Boards.get_board!(id)

    with {:ok, %Board{}} <- Boards.delete_board(board) do
      send_resp(conn, :no_content, "")
    end
  end
end
