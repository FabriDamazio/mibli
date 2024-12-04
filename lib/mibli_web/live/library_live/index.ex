defmodule MibliWeb.LibraryLive.Index do
  use MibliWeb, :live_view

  alias Mibli.Library

  on_mount {MibliWeb.LiveUserAuth, :live_user_required}

  def mount(_params, _session, socket) do
    {:ok, books} = Library.all_books(socket.assigns.current_user.id)
    {:ok, assign(socket, :books, books)}
  end

  def render(assigns) do
    ~H"""
    <div class="container mx-auto p-8">
      <div class="flex justify-between items-center mb-6">
        <h1 class="text-3xl font-bold">My Library</h1>
        <.link
          href={~p"/library/books/add"}
          class="bg-blue-500 hover:bg-blue-600 text-white font-semibold py-2 px-4 rounded transition-colors duration-300"
        >
          Add book
        </.link>
      </div>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-6">
        <%= for book <- @books do %>
          <div class="bg-white shadow-lg rounded-lg p-6 hover:shadow-2xl transition-shadow duration-300">
            <h2 class="text-xl font-semibold mb-2"><%= book.title %></h2>
            <p class="text-gray-700 mb-1"><strong>Author:</strong> <%= book.author %></p>
            <p class="text-gray-600">
              <strong>Year:</strong> <%= book.publication_year %>
            </p>
          </div>
        <% end %>
      </div>
    </div>
    """
  end
end
