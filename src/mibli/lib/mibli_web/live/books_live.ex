defmodule MibliWeb.BooksLive do
  use MibliWeb, :live_view

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~H"""
      <p>Books Live</p>
    """
  end
end
