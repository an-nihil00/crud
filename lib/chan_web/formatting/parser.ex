defmodule ChanWeb.Formatting.Parser do

  alias Phoenix.HTML
  
  def parse message do
    message
    |> String.split("\n")
    |> Enum.map(&String.trim_trailing/1)
    |> Enum.map(&scan_line/1)
  end

  defp scan_line line do
    case String.first(line) do
      ">" ->
	{">",scan(line, %{parsed: [], fragment: ""})}
      _   ->
	scan(line, %{parsed: [], fragment: ""})
    end
  end
  
  defp scan string, %{parsed: parsed, fragment: fragment} do
    if String.length(string) == 0 do
      [ safe_string(fragment) | parsed]
      |> Enum.reverse
    else
      with {head,tail} <- String.split_at string,1 do
	case head do
	  "*" ->
	    match_delim tail, "*", %{parsed: parsed, fragment: fragment}
	  "=" ->
	    match_delim tail, "=", %{parsed: parsed, fragment: fragment}
	  _ ->
	    scan tail, %{parsed: parsed, fragment: fragment <> head}
	end
      end
    end 
  end
  
  defp match_delim string, delim, %{parsed: parsed, fragment: fragment} do
    case String.split string, delim, parts: 2 do
      [ head ] ->
	scan head, %{parsed: parsed, fragment: fragment <> delim}
      [ head, next | _ ] ->
	scan next, %{parsed: [{delim, scan(head, %{parsed: [], fragment: ""})}, safe_string(fragment) | parsed], fragment: ""}
    end
  end

  defp safe_string string do
    string
    |> HTML.html_escape
    |> HTML.safe_to_string
  end
end
