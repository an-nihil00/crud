defmodule Chan.Chan.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :comment, :string
    field :image, :string
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :comment, :image])
    |> validate_required([:name, :comment, :image])
  end
end
