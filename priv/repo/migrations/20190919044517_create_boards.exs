defmodule Chan.Repo.Migrations.CreateBoards do
  use Ecto.Migration

  def change do
    create table(:boards) do
      add :abb, :string
      add :name, :string
      add :total_posts, :integer

      timestamps()
    end
    
    create unique_index(:boards, [:abb])
  end
end
