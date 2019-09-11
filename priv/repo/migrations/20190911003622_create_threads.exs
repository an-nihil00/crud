defmodule Crud.Repo.Migrations.CreateThreads do
  use Ecto.Migration

  def change do
    create table(:threads) do
      add :name, :string
      add :subject, :string
      add :comment, :text
      add :file, :string
      add :posts, {:array, :integer}

      timestamps()
    end

  end
end
