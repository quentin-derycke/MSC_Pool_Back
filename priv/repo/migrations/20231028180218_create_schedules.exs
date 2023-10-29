defmodule GoThimeManager.Repo.Migrations.CreateSchedules do
  use Ecto.Migration

  def change do
    create table(:schedules) do
      add :start_time, :naive_datetime, null: false
      add :end_time, :naive_datetime, null: false
      add :user_id, references(:users, on_delete: :nothing)

      timestamps(type: :utc_datetime)
    end

    create index(:schedules, [:user_id])
  end
end
