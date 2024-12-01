defmodule MibliWeb.PageController do
  use MibliWeb, :controller

  def home(conn, _params) do
    if(conn.assigns[:current_user]) do
      redirect(conn, to: ~p"/library")
    else
      render(conn, :home, layout: false)
    end
  end
end
