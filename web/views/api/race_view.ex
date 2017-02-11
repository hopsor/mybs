defmodule Mybs.Api.RaceView do
  use Mybs.Web, :view

  def render("index.json", %{races: races}), do: races
end
