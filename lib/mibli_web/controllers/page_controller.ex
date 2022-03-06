defmodule MibliWeb.PageController do
  use MibliWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
