defmodule Cold.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :firstname, :string
      add :lastname, :string
      add :email, :string
      add :hashed_password, :string

      timestamps()
    end
  end
end
