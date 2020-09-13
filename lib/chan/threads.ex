defmodule Chan.Threads do
  @moduledoc """
  The Threads context.
  """

  import Ecto.Query, warn: false
  alias Chan.Repo

  alias Chan.Threads.Thread
  alias Chan.Posts.Post

  @doc """
  Returns the list of threads.

  ## Examples

      iex> list_threads()
      [%Thread{}, ...]

  """
  def list_threads(board_id) do
    Repo.all((from t in Thread, preload: [posts: ^from(p in Post, order_by: [asc: :id]), posts: :upload], order_by: [desc: :updated_at]), prefix: board_id)
  end

  @doc """
  Gets a single thread.

  Raises `Ecto.NoResultsError` if the Thread does not exist.

  ## Examples

      iex> get_thread!(123)
      %Thread{}

      iex> get_thread!(456)
      ** (Ecto.NoResultsError)

  """
  def get_thread!(id,board_id) do
    Repo.get!(Thread, id, prefix: board_id)
    |> Repo.preload([posts: :upload])
  end
  @doc """
  Creates a thread.

  ## Examples

      iex> create_thread(%{field: value})
      {:ok, %Thread{}}

      iex> create_thread(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_thread(attrs \\ %{}, board_id) do
    %Thread{}
    |> Thread.changeset(attrs)
    |> Repo.insert(prefix: board_id)
  end

  @doc """
  Updates a thread.

  ## Examples

      iex> update_thread(thread, %{field: new_value})
      {:ok, %Thread{}}

      iex> update_thread(thread, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_thread(%Thread{} = thread, attrs) do
    thread
    |> Thread.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Thread.

  ## Examples

      iex> delete_thread(thread)
      {:ok, %Thread{}}

      iex> delete_thread(thread)
      {:error, %Ecto.Changeset{}}

  """
  def delete_thread(%Thread{} = thread, board_id) do
    Repo.delete(thread, prefix: board_id)
  end

  def delete_thread_id(thread_id, board_id) do
    delete_thread(get_thread!(thread_id, board_id),board_id)
  end
  
  @doc """
  Returns an `%Ecto.Changeset{}` for tracking thread changes.

  ## Examples

      iex> change_thread(thread)
      %Ecto.Changeset{source: %Thread{}}

  """
  def change_thread(%Thread{} = thread) do
    Thread.changeset(thread, %{})
  end
end
