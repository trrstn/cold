defmodule ColdWeb.UserController do
  use ColdWeb, :controller

  alias Cold.Accounts

  def index(conn, _params) do
    users = Accounts.list_users
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.create_changeset()
    render(
      conn, 
      "new.html",
      changeset: changeset,
      action: Routes.user_path(conn, :create)
    )
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
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
    user = Accounts.get_user(user_id)
    changeset = Accounts.edit_changeset(user, params)
    render(
      conn, 
      "edit.html",
      changeset: changeset,
      action: Routes.user_path(conn, :update, user),
      user: user
    )
  end

  def update(conn, %{"user" => user_params, "user_id" => user_id} = params) do
    user = Accounts.get_user(user_id)
    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        redirect(conn, to: Routes.user_path(conn, :index))
      {:error, changeset} ->
        render(
          conn, 
          "edit.html",
          changeset: changeset,
          action: Routes.user_path(conn, :update, user),
          user: user
        )
    end
  end
end
