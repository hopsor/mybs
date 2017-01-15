defmodule Mybs.PageController do
  use Mybs.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def design(conn, _params) do
    conn
    |> put_layout("design.html")
    |> render("design.html")
  end
end
