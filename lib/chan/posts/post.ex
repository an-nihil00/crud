defmodule Chan.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :comment, :string
    field :image, :string
    field :name, :string
    belongs_to :thread, Chan.Threads.Thread

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :image, :comment])
    |> validate_required([:name, :comment])
  end
end
