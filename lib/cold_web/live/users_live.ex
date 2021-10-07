defmodule ColdWeb.UsersLive do
  use ColdWeb, :live_view
  alias Cold.Accounts

  def mount(_params, _session, socket) do
    users = Accounts.list_users
    {:ok, assign(socket, users: users, keyword: "")}
  end

  def render(assigns) do
    Phoenix.View.render(ColdWeb.UserView, "index.html", assigns)
  end

  def handle_event("search", %{"value" => keyword}, socket) do
    filtered_users = Accounts.find_user(keyword)
    {:noreply, assign(socket, users: filtered_users, keyword: keyword)}
  end
end
