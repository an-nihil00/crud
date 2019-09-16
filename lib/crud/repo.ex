defmodule Crud.Repo do
  use Ecto.Repo,
    otp_app: :chan,
    adapter: Ecto.Adapters.Postgres
end
