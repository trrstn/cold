defmodule ColdWeb.UsersLive do
  use ColdWeb, :live_view
  alias Cold.Accounts

  def mount(_params, _session, socket) do
    users = Accounts.list_users
    {:ok, assign(socket, users: users)}
  end

  def render(assigns) do
    Phoenix.View.render(ColdWeb.UserView, "index.html", assigns)
  end

  def handle_event("search", %{"value" => keyword}, socket) do
    filtered_users = Accounts.find_user(keyword)
    {:noreply, assign(socket, users: filtered_users)}
  end

  def handle_event("sort", %{"order" => order}, socket) do
    sorted_users = Accounts.sort_name(order)
    {:noreply, assign(socket, users: sorted_users)}
  end
end
