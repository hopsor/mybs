defmodule Mybs.RaceFetcher do
  alias Mybs.Repo
  alias Mybs.Race

  def start do
    extrava_client = Extrava.Client.new(%{access_token: Application.get_env(:extrava, :secret_token)})
    process_page([], 0, extrava_client)
  end

  defp process_page([], page_number, extrava_client) do
    items = Extrava.Activity.list(extrava_client, page: page_number+1)
    unless items == [], do: process_page(items, page_number+1, extrava_client)
  end
  defp process_page([activity | tail], page_number, extrava_client) do
    if Repo.get_by(Race, strava_id: Integer.to_string(activity[:id])) == nil do
      persist_activity!(activity)
      process_page(tail, page_number, extrava_client)
    end
  end

  def persist_activity!(activity) do
    params = activity
    |> Map.put(:started_at, Ecto.DateTime.cast!(activity[:start_date]))
    |> Map.delete(:start_date)
    |> Map.put(:strava_id, Integer.to_string(activity[:id]))
    |> Map.delete(:id)

    Race.changeset(%Race{}, params)
    |> Repo.insert!
  end
end
