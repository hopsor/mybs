defmodule Mybs.RaceTest do
  use Mybs.ModelCase

  alias Mybs.Race

  @valid_attrs %{average_heartrate: "120.5", average_speed: "120.5", distance: "120.5", elapsed_time: 42, max_heartrate: "120.5", max_speed: "120.5", moving_time: 42, started_at: %{day: 17, hour: 14, min: 0, month: 4, sec: 0, year: 2010}}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Race.changeset(%Race{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Race.changeset(%Race{}, @invalid_attrs)
    refute changeset.valid?
  end
end
