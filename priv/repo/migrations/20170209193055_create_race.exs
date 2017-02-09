defmodule Mybs.Repo.Migrations.CreateRace do
  use Ecto.Migration

  def change do
    create table(:races) do
      add :distance, :float
      add :elapsed_time, :integer
      add :moving_time, :integer
      add :started_at, :utc_datetime
      add :average_speed, :float
      add :max_speed, :float
      add :average_heartrate, :float
      add :max_heartrate, :float

      timestamps()
    end

  end
end
