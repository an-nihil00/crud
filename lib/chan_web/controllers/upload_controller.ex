defmodule ChanWeb.UploadController do
  use ChanWeb, :controller

  alias Chan.Repo
  alias Chan.Posts
  alias Chan.Posts.Upload

  def show(conn, %{"id" => id}) do
    case Repo.get(Upload, id) do
      nil ->
	text conn, "not found!"
      upload ->
	send_file conn, 200, Upload.local_path(id, upload.filename)
    end
  end
end
