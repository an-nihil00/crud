defmodule ChanWeb.BoardController do
  use ChanWeb, :controller

  alias Chan.Board
  
  def index(conn, params) do
    boards = Board.fetch_ordered()
    render conn, boards: boards
  end
end
