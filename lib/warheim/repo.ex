defmodule Warheim.Repo do
  use Ecto.Repo,
    otp_app: :warheim,
    adapter: Ecto.Adapters.Postgres
end
