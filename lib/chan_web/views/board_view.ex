defmodule ChanWeb.BoardView do
  use ChanWeb, :view
  alias ChanWeb.BoardView
  alias ChanWeb.ThreadView

  def render("index.json", %{boards: boards}) do
    %{data: render_many(boards, BoardView, "board.json")}
  end

  def render("show.json", %{board: board}) do
    %{data: render_one(board, BoardView, "board.json")}
  end

  def render("board.json", %{board: board}) do
    %{id: board.id,
      abb: board.abb,
      name: board.name,
      total_posts: board.total_posts,
      threads: render_many(Chan.Threads.list_threads(board.abb), ThreadView, "thread.json")}
  end
end
