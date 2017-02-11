defmodule Mybs.Api.RaceController do
  use Mybs.Web, :controller
  alias Mybs.Race

  def index(conn, _params) do
    races = from(r in Race, order_by: r.started_at) |> Repo.all
    render(conn, races: races)
  end
end
