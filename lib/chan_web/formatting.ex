defmodule ChanWeb.Formatting do

  import Ecto.Query, only: [from: 2]
  alias Chan.Repo
  
  alias ChanWeb.Formatting.Parser
  alias Chan.Posts
  alias Phoenix.HTML
  
  def as_html comment, post_id, board_id do
    case comment do
      nil ->
	comment
      _ ->
	comment
	|> Parser.parse
	|> Enum.map(fn parse -> parse_to_html(parse, post_id, board_id) end)
	|> Enum.join("\n")
	|> HTML.raw
    end
  end
  
  defp parse_to_html parse, post_id, board_id do
    case parse do
      {"*" , content } ->
	"<strong>#{parse_to_html content, post_id, board_id}</strong>"
      {">" , content } ->
	"<span class=\"greenText\">#{parse_to_html content, post_id, board_id}</span>"
      {"=" , content } ->
	"<strong class=\"redText\">#{parse_to_html content, post_id, board_id}</strong>"
      {">>" , id, content } ->
	with query <- from r in "replies",
	     where: r.post_id==^id and r.reply_id==^post_id,
	       select: {r.post_id, r.reply_id} do
	  case Repo.all(query, prefix: board_id) do
	    [] ->
	      content
	    _ ->
	      "<a class = replyLink href=##{id}>#{content}</a>"
	  end
	end
      [head | tail] ->
	parse
	|> Enum.map(fn parse -> parse_to_html(parse, post_id, board_id) end)
	|> Enum.join
      _ ->
	parse
    end
  end
  
end
