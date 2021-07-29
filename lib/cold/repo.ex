defmodule Cold.Repo do
  use Ecto.Repo,
    otp_app: :cold,
    adapter: Ecto.Adapters.Postgres
end
