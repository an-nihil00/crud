defmodule Chan.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :op, :integer
    field :replies, {:array, :integer}
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:subject, :op, :replies])
    |> validate_required([:subject, :op, :replies])
  end
end
