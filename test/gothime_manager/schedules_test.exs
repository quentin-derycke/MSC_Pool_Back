defmodule GoThimeManager.SchedulesTest do
  use GoThimeManager.DataCase

  alias GoThimeManager.Schedules

  describe "schedules" do
    alias GoThimeManager.Schedules.Schedule

    import GoThimeManager.SchedulesFixtures

    @invalid_attrs %{start_time: nil, end_time: nil}

    test "list_schedules/0 returns all schedules" do
      schedule = schedule_fixture()
      assert Schedules.list_schedules() == [schedule]
    end

    test "get_schedule!/1 returns the schedule with given id" do
      schedule = schedule_fixture()
      assert Schedules.get_schedule!(schedule.id) == schedule
    end

    test "create_schedule/1 with valid data creates a schedule" do
      valid_attrs = %{start_time: ~N[2023-10-27 18:02:00], end_time: ~N[2023-10-27 18:02:00]}

      assert {:ok, %Schedule{} = schedule} = Schedules.create_schedule(valid_attrs)
      assert schedule.start_time == ~N[2023-10-27 18:02:00]
      assert schedule.end_time == ~N[2023-10-27 18:02:00]
    end

    test "create_schedule/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedules.create_schedule(@invalid_attrs)
    end

    test "update_schedule/2 with valid data updates the schedule" do
      schedule = schedule_fixture()
      update_attrs = %{start_time: ~N[2023-10-28 18:02:00], end_time: ~N[2023-10-28 18:02:00]}

      assert {:ok, %Schedule{} = schedule} = Schedules.update_schedule(schedule, update_attrs)
      assert schedule.start_time == ~N[2023-10-28 18:02:00]
      assert schedule.end_time == ~N[2023-10-28 18:02:00]
    end

    test "update_schedule/2 with invalid data returns error changeset" do
      schedule = schedule_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedules.update_schedule(schedule, @invalid_attrs)
      assert schedule == Schedules.get_schedule!(schedule.id)
    end

    test "delete_schedule/1 deletes the schedule" do
      schedule = schedule_fixture()
      assert {:ok, %Schedule{}} = Schedules.delete_schedule(schedule)
      assert_raise Ecto.NoResultsError, fn -> Schedules.get_schedule!(schedule.id) end
    end

    test "change_schedule/1 returns a schedule changeset" do
      schedule = schedule_fixture()
      assert %Ecto.Changeset{} = Schedules.change_schedule(schedule)
    end
  end
end
