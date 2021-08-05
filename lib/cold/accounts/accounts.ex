defmodule Cold.Accounts do
  alias Cold.Accounts.UserResolver

  defdelegate list_users, to: UserResolver
  defdelegate create_user(params), to: UserResolver
  defdelegate get_user(user_id), to: UserResolver
  defdelegate create_changeset(params \\ %{}), to: UserResolver
  defdelegate edit_changeset(user, params \\ %{}), to: UserResolver
  defdelegate update_user(user, params \\ %{}), to: UserResolver
end
