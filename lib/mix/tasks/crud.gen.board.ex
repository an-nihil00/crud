defmodule Mix.Tasks.Crud.Gen.Board do
  @shortdoc "Generates a migration for creating a new board"

  @moduledoc """
  Generates a migration for creating a new board

      mix crud.gen.board b "random" en

  The arguments in order are the abbreviation of the board, its unabbreviated name, 
  and its language. 
  The migration will create:

    * a table for storing threads on the board
    * a table for storing posts on the board
  """
  use Mix.Task

  def run(args) do
    [abb, name, lang] = args
    migration_path = "priv/repo/migrations/#{timestamp()}_create_#{abb}_board.exs"

    Mix.Generator.copy_template("priv/templates/crud.gen.board", migration_path,
      abb: abb,
      name: name,
      lang: lang
    )
  end

  defp timestamp do
    {{y, m, d}, {hh, mm, ss}} = :calendar.universal_time()
    "#{y}#{pad(m)}#{pad(d)}#{pad(hh)}#{pad(mm)}#{pad(ss)}"
  end
  defp pad(i) when i < 10, do: << ?0, ?0 + i >>
  defp pad(i), do: to_string(i)
end
