defmodule GoThimeManager.SchedulesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GoThimeManager.Schedules` context.
  """

  @doc """
  Generate a schedule.
  """
  def schedule_fixture(attrs \\ %{}) do
    {:ok, schedule} =
      attrs
      |> Enum.into(%{
        end_time: ~N[2023-10-27 18:02:00],
        start_time: ~N[2023-10-27 18:02:00]
      })
      |> GoThimeManager.Schedules.create_schedule()

    schedule
  end
end
