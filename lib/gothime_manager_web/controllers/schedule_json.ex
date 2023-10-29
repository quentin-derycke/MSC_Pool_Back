defmodule GoThimeManagerWeb.ScheduleJSON do
  alias GoThimeManager.Schedules.Schedule

  @doc """
  Renders a list of schedules.
  """
  def index(%{schedules: schedules}) do
    %{data: for(schedule <- schedules, do: data(schedule))}
  end

  @doc """
  Renders a single schedule.
  """
  def show(%{schedule: schedule}) do
    %{data: data(schedule)}
  end

  def show_schedules_by_user(%{schedules: schedules})  when is_list(schedules) do
    %{data: for(schedule <- schedules, do: data(schedule))}
  end


  def show_schedule_by_user(%{schedule: schedule})   do
    %{data: data(schedule)}
  end

  defp data(%Schedule{} = schedule) do
    %{
      id: schedule.id,
      start_time: schedule.start_time,
      end_time: schedule.end_time,
      user_id: schedule.user_id
    }
  end

  defp data(%{id: id, start_time: start_time, end_time: end_time, user_id: user_id}) do
    %{
      id: id,
      start_time: start_time,
      end_time: end_time,
      user_id: user_id
    }
  end

  defp data([schedule_map | _rest]) when is_map(schedule_map) do
    %{
      id: schedule_map.id,
      start_time: schedule_map.start_time,
      end_time: schedule_map.end_time,
      user_id: schedule_map.user_id
    }
  end
 end
