defmodule Ignitebody.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :name, :string
      add :password, :string

      timestamps()
    end

    create unique_index(:users, [:email])
  end

  # def up do
  #   create table("users") do
  #     add :email,     :string
  #     add :name,      :string
  #     add :password,  :string

  #     timestamps()
  #   end

  #   create unique_index(:users, [:email])
  # end

  # def down do
  #   drop table(:users)
  # end
end
