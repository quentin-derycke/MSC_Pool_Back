defmodule GoThimeManager.Schedules do
  @moduledoc """
  The Schedules context.
  """

  import Ecto.Query, warn: false
  alias GoThimeManager.Repo

  alias GoThimeManager.Schedules.Schedule

  @doc """
  Returns the list of schedules.

  ## Examples

      iex> list_schedules()
      [%Schedule{}, ...]

  """
  def list_schedules do
    Repo.all(Schedule)
  end

  @doc """
  Gets a single schedule.

  Raises `Ecto.NoResultsError` if the Schedule does not exist.

  ## Examples

      iex> get_schedule!(123)
      %Schedule{}

      iex> get_schedule!(456)
      ** (Ecto.NoResultsError)

  """
  def get_schedule!(id), do: Repo.get!(Schedule, id)

  @doc """
  Creates a schedule.

  ## Examples

      iex> create_schedule(%{field: value})
      {:ok, %Schedule{}}

      iex> create_schedule(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def get_schedule_by_time!(user_id, start_time, end_time) do
    query = from s in Schedule,
            where: s.user_id == ^user_id and s.start_time > ^start_time and s.end_time < ^end_time,
            select: %{
              id: s.id,
              start_time: s.start_time,
              end_time: s.end_time,
              user_id: s.user_id,
            }

    Repo.all(query)
  end
 #Get All Schedule by user
  def get_schedules_by_user!(user_id) do

    query = from s in Schedule,
            where: s.user_id == ^user_id,
            select: %{
              id: s.id,
              start_time: s.start_time,
              end_time: s.end_time,
              user_id: s.user_id,
            }

    Repo.all(query)
end

# Get One Schedule by user
def get_schedule_by_user!(user_id, id) do

  query = from s in Schedule,
          where: s.user_id == ^user_id and s.id == ^id,
          select: %{
            id: s.id,
            start_time: s.start_time,
            end_time: s.end_time,
            user_id: s.user_id,
          }

  Repo.all(query)
end


  def create_schedule(attrs \\ %{}) do
    %Schedule{}
    |> Schedule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a schedule.

  ## Examples

      iex> update_schedule(schedule, %{field: new_value})
      {:ok, %Schedule{}}

      iex> update_schedule(schedule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_schedule(%Schedule{} = schedule, attrs) do
    schedule
    |> Schedule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a schedule.

  ## Examples

      iex> delete_schedule(schedule)
      {:ok, %Schedule{}}

      iex> delete_schedule(schedule)
      {:error, %Ecto.Changeset{}}

  """
  def delete_schedule(%Schedule{} = schedule) do
    Repo.delete(schedule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking schedule changes.

  ## Examples

      iex> change_schedule(schedule)
      %Ecto.Changeset{data: %Schedule{}}

  """
  def change_schedule(%Schedule{} = schedule, attrs \\ %{}) do
    Schedule.changeset(schedule, attrs)
  end
end
