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
  defp process_page([head | tail], page_number, extrava_client) do
    case Repo.get_by(Race, strava_id: head["strava_id"]) do
      nil ->
        store(head)
        process_page(tail, page_number, client)
      _ ->
        nil
    end
  end

  def store(activity) do
    activity
    |> Map.put("started_at", Ecto.DateTime.cast!(activity["start_date"]))
    |> Map.delete("start_date")
    |> Race.changeset
    |> Repo.insert!
  end
end
