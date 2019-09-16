defmodule Crud.Crud.Board do
  use Ecto.Schema
  import Ecto.Changeset

  schema "boards" do
    field :board, :string
    field :lang, :string
    field :posts, :integer
    field :tags, {:array, :string}
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:lang, :board, :title, :posts, :tags])
    |> validate_required([:lang, :board, :title, :posts, :tags])
  end
end
