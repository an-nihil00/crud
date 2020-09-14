defmodule ChanWeb.Formatting do

  alias ChanWeb.Formatting.Parser
  alias Phoenix.HTML
  
  def as_html comment do
    case comment do
      nil ->
	comment
      _ ->
	comment
	|> Parser.parse
	|> Enum.map(&parse_to_html/1)
	|> Enum.join("\n")
	|> HTML.raw
    end
  end
  
  defp parse_to_html parse do
    case parse do
      {"*" , content } ->
	"<strong>#{parse_to_html content}</strong>"
      {">" , content } ->
	"<span class=\"greenText\">#{parse_to_html content}</span>"
      {"=" , content } ->
	"<strong class=\"redText\">#{parse_to_html content}</strong>"
      {">>" , id, content } ->
	"<a class = replyLink href=##{id}>#{content}</a>"
      [head | tail] ->
	parse
	|> Enum.map(&parse_to_html/1)
	|> Enum.join
      _ ->
	parse
    end
  end
  
end
