defmodule Chan.Board do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Chan.Repo

  @derive {Phoenix.Param, key: :abb}
  schema "boards" do
    field :abb, :string
    field :name, :string
    field :posts, :integer

    timestamps()
  end

  @doc false
  def changeset(board, attrs) do
    board
    |> cast(attrs, [:abb, :name, :posts])
    |> validate_required([:abb, :name, :posts])
    |> unique_constraint(:abb)
  end

  def fetch_ordered() do
    Chan.Board
    |> order_by(:abb)
    |> Repo.all()
  end
end
