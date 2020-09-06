defmodule Chan.Threads.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :subject, :string
    has_many :posts, Chan.Posts.Post

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:subject])
    |> cast_assoc(:posts)
    |> validate_required([:subject])
  end
end
