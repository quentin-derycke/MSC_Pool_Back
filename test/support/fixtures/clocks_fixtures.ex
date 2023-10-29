defmodule GoThimeManager.ClocksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GoThimeManager.Clocks` context.
  """

  @doc """
  Generate a clock.
  """
  def clock_fixture(attrs \\ %{}) do
    {:ok, clock} =
      attrs
      |> Enum.into(%{
        status: true,
        time: ~N[2023-10-27 18:02:00]
      })
      |> GoThimeManager.Clocks.create_clock()

    clock
  end
end
