defmodule MibliWeb.Books.BooksLive do
  use MibliWeb, :live_view
  alias Mibli.Books

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, books: Books.get_books())

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="text-slate-600 text-5xl mb-12">My Books</h1>
    <button class="mt-6 bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded">
      <.link href={~p"/books/new"}>
        Add Book
      </.link>
    </button>
    <div>
      <ul class="flex flex-row flex-wrap">
        <li :for={book <- @books} class="min-w-80">
          <section class="max-w-sm rounded overflow-hidden shadow-lg m-4 ">
            <article class="px-6 py-4">
              <h3 class="text-slate-600 font-bold text-xl mb-2">
                <%= book.title %>
              </h3>
              <p class="text-slate-500 text-base">
                <%= book.description %>
              </p>
            </article>
          </section>
        </li>
      </ul>
    </div>
    """
  end
end
