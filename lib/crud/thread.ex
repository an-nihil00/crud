defmodule Crud.Thread do
  use Ecto.Schema
  import Ecto.Changeset

  schema "threads" do
    field :comment, :string
    field :file, :string
    field :name, :string
    field :posts, {:array, :integer}
    field :subject, :string

    timestamps()
  end

  @doc false
  def changeset(thread, attrs) do
    thread
    |> cast(attrs, [:name, :subject, :comment, :file, :posts])
    |> validate_required([:name, :subject, :comment, :file, :posts])
  end
end
