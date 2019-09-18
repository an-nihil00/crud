defmodule Chan.Repo do
  use Ecto.Repo,
    otp_app: :chan,
    adapter: Ecto.Adapters.Postgres
  use Scrivener,
    page_size: 16
end
