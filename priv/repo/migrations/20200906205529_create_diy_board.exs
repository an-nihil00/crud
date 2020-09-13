defmodule Chan.Repo.Migrations.CreateDiyBoard do
  use Ecto.Migration
  import Ecto.Query

  
  def up do
    execute "CREATE SCHEMA diy"
    create table(:threads, prefix: "diy") do
      add :subject, :string

      timestamps()
    end

    create table(:posts, prefix: "diy") do
      add :name, :string
      add :image, :string
      add :comment, :text
      add :password_hash, :string
      add :thread_id, references(:threads, on_delete: :delete_all)

      timestamps()
    end

    create table(:uploads, prefix: "diy") do
      add :filename, :string
      add :size, :integer
      add :content_type, :string
      add :hash, :string, size: 64
      add :post_id, references(:posts)

      timestamps()
    end

    create table(:replies, prefix: "diy") do
      add :post, references(:posts)
      add :reply, references(:posts)
    end

    create unique_index(:replies, [:post, :reply], prefix: "diy")

    Chan.Repo.insert!(%Chan.Boards.Board{
      abb: "diy",
      name: "Do It Yourself",
      total_posts: 0
    })
  end
  
  def down do
    drop table(:threads, prefix: "diy")
    drop table(:posts, prefix: "diy")
    drop table(:uploads, prefix: "diy")
    from(b in Chan.Boards.Board, where: b.abb == "diy") |> Chan.Repo.delete_all
  end
end
