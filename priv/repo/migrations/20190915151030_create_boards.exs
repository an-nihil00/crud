defmodule Crud.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :lang, :string
      add :board, :string
      add :title, :string
      add :posts, :integer
      add :tags, {:array, :string}

      timestamps()
    end

  end
end
