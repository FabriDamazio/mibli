defmodule MibliWeb.LibraryLive do
  use MibliWeb, :live_view
  alias Mibli.Library.Book

  on_mount {MibliWeb.LiveUserAuth, :live_user_required}

  def mount(_params, _session, socket) do
    {:ok, books} = Book.my_books(socket.assigns.current_user.id)
    {:ok, assign(socket, :books, books)}
  end

  def render(assigns) do
    ~H"""
    <h1>HELLO FROM LIBRARY!</h1>
    <%= for book <- @books do %>
      <%= book.title %>
    <% end %>
    """
  end
end
