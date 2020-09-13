defmodule Chan.Repo.Migrations.CreateHrtBoard do
  use Ecto.Migration
  import Ecto.Query

  
  def up do
    execute "CREATE SCHEMA hrt"
    create table(:threads, prefix: "hrt") do
      add :subject, :string

      timestamps()
    end

    create table(:posts, prefix: "hrt") do
      add :name, :string
      add :image, :string
      add :comment, :text
      add :password_hash, :string
      add :trip, :string
      add :thread_id, references(:threads, on_delete: :delete_all)

      timestamps()
    end

    create table(:uploads, prefix: "hrt") do
      add :filename, :string
      add :size, :integer
      add :content_type, :string
      add :hash, :string, size: 64
      add :post_id, references(:posts, on_delete: :delete_all)

      timestamps()
    end

    create table(:replies, prefix: "hrt") do
      add :post, references(:posts)
      add :reply, references(:posts)
    end

    create unique_index(:replies, [:post, :reply], prefix: "hrt")

    Chan.Repo.insert!(%Chan.Boards.Board{
      abb: "hrt",
      name: "Transgender",
      total_posts: 0
    })
  end
  
  def down do
    drop table(:threads, prefix: "hrt")
    drop table(:posts, prefix: "hrt")
    from(b in Chan.Boards.Board, where: b.abb == "hrt") |> Chan.Repo.delete_all
  end
end