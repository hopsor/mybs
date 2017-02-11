defmodule Mybs.Race do
  use Mybs.Web, :model

  schema "races" do
    field :distance, :float
    field :elapsed_time, :integer
    field :moving_time, :integer
    field :started_at, Ecto.DateTime
    field :average_speed, :float
    field :max_speed, :float
    field :average_heartrate, :float
    field :max_heartrate, :float
    field :strava_id, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:distance, :elapsed_time, :moving_time, :started_at, :average_speed, :max_speed, :average_heartrate, :max_heartrate, :strava_id])
    |> validate_required([:distance, :elapsed_time, :moving_time, :started_at, :average_speed, :max_speed])
  end
end
