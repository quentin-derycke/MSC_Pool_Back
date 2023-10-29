defmodule GoThimeManager.Schedules.Schedule do
  use Ecto.Schema
  import Ecto.Changeset

  schema "schedules" do
    field :start_time, :naive_datetime
    field :end_time, :naive_datetime
    field :user_id, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(schedule, attrs) do
    schedule
    |> cast(attrs, [:start_time, :end_time, :user_id])
    |> validate_required([:start_time, :end_time])
  end
end
