defmodule Chan.Posts.Post do
  use Ecto.Schema
  import Ecto.Changeset

  alias Chan.Posts.Passwords

  schema "posts" do
    field :comment, :string
    field :image, :string
    field :name, :string, default: "Anonymous"
    field :password_hash, :string 

    field :password, :string, virtual: true
    
    belongs_to :thread, Chan.Threads.Thread
    has_one :upload, Chan.Posts.Upload
    
    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:name, :image, :comment, :password])
    |> validate_required([:name, :password])
    |> hash_password
  end

  defp hash_password(changeset) do
    password = get_change(changeset, :password)
    if password do
      hashed_password = Passwords.hash_password(password)
      put_change(changeset, :password_hash, hashed_password)
    else
      changeset
    end
  end
end
