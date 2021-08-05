defmodule Cold.Accounts.UserResolver do
  alias Cold.Accounts.User
  alias Cold.Repo
  import Ecto.Changeset

  def list_users do
    Repo.all(User)
  end

  def create_changeset(params) do
    cast(%User{}, params, [:firstname, :lastname, :email, :hashed_password])
  end

  def get_user(user_id) do
    Repo.get_by(User, id: user_id)
  end

  def create_user(params) do
    params
    |> create_changeset()
    |> Repo.insert()
  end

  def edit_changeset(user, params) do
    cast(user, params, [:firstname, :lastname, :email, :hashed_password])
  end

  def update_user(user, params) do
    user
    |> edit_changeset(params)
    |> Repo.update()
  end
end
