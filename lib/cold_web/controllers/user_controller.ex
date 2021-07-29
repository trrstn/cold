defmodule ColdWeb.UserController do
  use ColdWeb, :controller

  def index(conn, _params) do
    users = Cold.Repo.all(Cold.Accounts.User)
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Ecto.Changeset.cast(%Cold.Accounts.User{}, %{}, [:firstname, :lastname, :email, :hashed_password])
    render(
      conn, 
      "new.html",
      changeset: changeset,
      action: Routes.user_path(conn, :create)
    )
  end

  def create(conn, %{"user" => user_params}) do
    changeset = 
      Ecto.Changeset.cast(
        %Cold.Accounts.User{},
        user_params,
        [:firstname, :lastname, :email, :hashed_password]
      )
    case Cold.Repo.insert(changeset) do
      {:ok, user} ->
        redirect(conn, to: Routes.user_path(conn, :index))
      {:error, changeset} ->
        render(
          conn, 
          "new.html",
          changeset: changeset,
          action: Routes.user_path(conn, :create)
        )
    end
  end

  def edit(conn, %{"user_id" => user_id} = params) do
    user = Cold.Repo.get(Cold.Accounts.User, user_id)
    changeset = Ecto.Changeset.cast(user, %{}, [:firstname, :lastname, :email, :hashed_password])
    render(
      conn, 
      "edit.html",
      changeset: changeset,
      action: Routes.user_path(conn, :update, user),
      user: user
    )
  end

  def update(conn, %{"user" => user_params, "user_id" => user_id} = params) do
    user = Cold.Repo.get(Cold.Accounts.User, user_id)
    changeset = Ecto.Changeset.cast(user, user_params, [:firstname, :lastname, :email, :hashed_password])
    Cold.Repo.update!(changeset)
    redirect(conn, to: Routes.user_path(conn, :index))
  end
end
