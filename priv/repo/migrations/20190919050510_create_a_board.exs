defmodule Chan.Repo.Migrations.CreateABoard do
  use Ecto.Migration
  import Ecto.Query

  
  def up do
    execute "CREATE SCHEMA a"
    create table(:threads, prefix: "a") do
      add :subject, :string

      timestamps()
    end

    create table(:posts, prefix: "a") do
      add :name, :string
      add :image, :string
      add :comment, :text
      add :thread_id, references(:threads)

      timestamps()
    end

    create table(:replies, prefix: "a") do
      add :post, references(:posts)
      add :reply, references(:posts)
    end

    create unique_index(:replies, [:post, :reply], prefix: "a")

    Chan.Repo.insert!(%Chan.Boards.Board{
      abb: "a",
      name: "anime",
      total_posts: 0
    })
  end
  
  def down do
    drop table(:threads, prefix: "a")
    drop table(:posts, prefix: "a")
    from(b in Chan.Boards.Board, where: b.abb == "a") |> Chan.Repo.delete_all
  end
end