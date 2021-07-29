defmodule Cold.Accounts.User do
  use Ecto.Schema
  schema "users" do
    field(:firstname, :string)
    field(:lastname, :string)
    field(:email, :string)
    field(:hashed_password, :string)

    timestamps()
  end
end
