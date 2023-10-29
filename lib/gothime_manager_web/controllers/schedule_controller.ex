defmodule GoThimeManagerWeb.ScheduleController do
  use GoThimeManagerWeb, :controller

  alias GoThimeManager.Schedules
  alias GoThimeManager.Schedules.Schedule

  action_fallback GoThimeManagerWeb.FallbackController

  def index(conn, _params) do
    schedules = Schedules.list_schedules()
    render(conn, :index, schedules: schedules)
  end

  def create(conn, %{"schedule" => schedule_params}) do
    with {:ok, %Schedule{} = schedule} <- Schedules.create_schedule(schedule_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/schedules/#{schedule}")
      |> render(:show, schedule: schedule)
    end
  end

  def show(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)
    render(conn, :show, schedule: schedule)
  end
#   def show_schedule_by_time(conn, %{ "user_id" => user_id, "start_time" => start_time, "end_time" => end_time })do
#     schedules = Schedules.get_schedule_by_time!(user_id, start_time, end_time)
#     render(conn, :index, schedules: schedules)
# end

 # Show All the Shcedules by one ID
def show_schedules_by_user(conn, %{ "user_id" => user_id }) do
  IO.puts("Inside show_schedules_by_user")
  schedules = Schedules.get_schedules_by_user!(user_id)
  IO.inspect(schedules)
  render(conn, :show_schedules_by_user, schedules: schedules)
end

# Show One Schedule by User ID
def show_schedule_by_user(conn, %{ "schedule_id" => schedule_id, "user_id" => user_id  }) do
  IO.puts("Inside show_schedule_by_user")

  schedule = Schedules.get_schedule_by_user!(user_id, schedule_id)
  IO.inspect(schedule)
  render(conn, :show_schedule_by_user, schedule: schedule)
end

  def update(conn, %{"id" => id, "schedule" => schedule_params}) do
    schedule = Schedules.get_schedule!(id)

    with {:ok, %Schedule{} = schedule} <- Schedules.update_schedule(schedule, schedule_params) do
      render(conn, :show, schedule: schedule)
    end
  end

  def delete(conn, %{"id" => id}) do
    schedule = Schedules.get_schedule!(id)

    with {:ok, %Schedule{}} <- Schedules.delete_schedule(schedule) do
      send_resp(conn, :no_content, "")
    end
  end
end
