defmodule Ignitebody.Repo.Migrations.CreateTrainingsTable do
  use Ecto.Migration

  def change do
    create table(:trainings) do
      add :start_date, :date
      add :end_date, :date
      add :user_id, references(:users)
      # "add :user_id, references(:users)" referencia a tabela users

      timestamps()
    end
  end
end
