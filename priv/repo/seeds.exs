# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GoThimeManager.Repo.insert!(%GoThimeManager.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GoThimeManager.Repo
alias GoThimeManager.Users.User
alias GoThimeManager.Schedules.Schedule
alias GoThimeManager.Clocks.Clock
import Ecto.Query


#  User seed

for i <- 0..99 do
  %User{
    username: "user#{i}",
    email: "user#{i}@example.com"
  }
  |> Repo.insert!()
end


#Schedules Seed

for _ <- 1..500 do
  # Randomly select a user_id from the users table
  user = Repo.one(from u in User, order_by: fragment("RANDOM()"), limit: 1)

  # Generate a random start_time within the last 30 days
  days_ago = :rand.uniform(30) - 1
  start_time = DateTime.add(DateTime.utc_now(), -days_ago * 86400)

  # Calculate an end_time that's between 1 to 8 hours after the start_time
  hours = :rand.uniform(8)
  end_time = DateTime.add(start_time, hours * 3600)

  # Convert DateTime to NaiveDateTime and truncate microseconds
  start_time_naive = DateTime.to_naive(start_time) |> NaiveDateTime.truncate(:second)
  end_time_naive = DateTime.to_naive(end_time) |> NaiveDateTime.truncate(:second)

  %Schedule{
    start_time: start_time_naive,
    end_time: end_time_naive,
    user_id: user.id
  }
  |> Repo.insert!()
end


 #Clocks Seed

for _ <- 1..1000 do
  # Randomly select a user_id from the users table
  user = Repo.one(from u in User, order_by: fragment("RANDOM()"), limit: 1)

  # Generate a random time within the last 7 days
  days_ago = :rand.uniform(7) - 1
  random_time = DateTime.add(DateTime.utc_now(), -days_ago * 86400)

  # Convert DateTime to NaiveDateTime and truncate microseconds
  random_time_naive = DateTime.to_naive(random_time) |> NaiveDateTime.truncate(:second)

  # Generate a random status (true or false)
  status = :rand.uniform(2) == 1

  %Clock{
    time: random_time_naive,
    status: status,
    user_id: user.id
  }
  |> Repo.insert!()
end
