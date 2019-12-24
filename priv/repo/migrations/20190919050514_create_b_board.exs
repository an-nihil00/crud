defmodule Chan.Repo.Migrations.CreateBBoard do
  use Ecto.Migration
  import Ecto.Query

  
  def up do
    execute "CREATE SCHEMA b"
    create table(:threads, prefix: "b") do
      add :subject, :string

      timestamps()
    end

    create table(:posts, prefix: "b") do
      add :name, :string
      add :image, :string
      add :comment, :text
      add :thread_id, references(:threads)

      timestamps()
    end

    create table(:replies, prefix: "b") do
      add :post, references(:posts)
      add :reply, references(:posts)
    end

    create unique_index(:replies, [:post, :reply], prefix: "b")

    Chan.Repo.insert!(%Chan.Boards.Board{
      abb: "b",
      name: "random",
      total_posts: 0
    })
  end
  
  def down do
    drop table(:threads, prefix: "b")
    drop table(:posts, prefix: "b")
    from(b in Chan.Boards.Board, where: b.abb == "b") |> Chan.Repo.delete_all
  end
end