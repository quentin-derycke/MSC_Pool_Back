defmodule GoThimeManagerWeb.Router do
  use GoThimeManagerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug CORSPlug, origin: ["http://localhost:3000/myTeam"]
  end

  scope "/api", GoThimeManagerWeb do
    pipe_through :api


    resources "/users", UserController
    options "/users", UserController, :options
    options "/users/:id", UserController, :options

    get "/schedules", ScheduleController, :index
    # Show One Schedule By User
    get "/schedules/:user_id/:schedule_id", ScheduleController, :show_schedule_by_user
    # Show All Schedules By User
    get "/schedules/:user_id", ScheduleController, :show_schedules_by_user


      resources "/clocks", ClockController


  end
end
