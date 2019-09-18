defmodule ChanWeb.BoardView do
  use ChanWeb, :view

  def render("index.json", %{boards: page}), do: boards
end
