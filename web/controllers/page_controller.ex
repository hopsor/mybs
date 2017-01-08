defmodule Mybs.PageController do
  use Mybs.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
