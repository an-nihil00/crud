defmodule Crud.Repo.Migrations.CreateBBoard do
  use Ecto.Migration

  def change do
    create table(:b_threads) do
      add :subject, :string
      add :op, :integer
      add :posts, {:array, :integer}

      timestamps()
    end
    create table(:b_posts) do
      add :name, :string
      add :comment, :text
      add :image, :string

      timestamps()
    end
  end
end