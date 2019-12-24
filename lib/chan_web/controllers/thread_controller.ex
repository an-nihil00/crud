defmodule ChanWeb.ThreadController do
  use ChanWeb, :controller

  alias Chan.Threads
  alias Chan.Threads.Thread

  action_fallback ChanWeb.FallbackController

  def index(conn, _params) do
    threads = Threads.list_threads()
    render(conn, "index.json", threads: threads)
  end

  def create(conn, %{"thread" => thread_params}) do
    with {:ok, %Thread{} = thread} <- Threads.create_thread(thread_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.thread_path(conn, :show, thread))
      |> render("show.json", thread: thread)
    end
  end

  def show(conn, %{"id" => id, "board_id" => board_id}) do
    thread = Threads.get_thread!(id,board_id)
    render(conn, "show.json", thread: thread)
  end

  def update(conn, %{"id" => id, "thread" => thread_params}) do
    thread = Threads.get_thread!(id)

    with {:ok, %Thread{} = thread} <- Threads.update_thread(thread, thread_params) do
      render(conn, "show.json", thread: thread)
    end
  end

  def delete(conn, %{"id" => id}) do
    thread = Threads.get_thread!(id)

    with {:ok, %Thread{}} <- Threads.delete_thread(thread) do
      send_resp(conn, :no_content, "")
    end
  end
end
