defmodule MibliWeb.Books.BooksLive do
  use MibliWeb, :live_view
  alias Mibli.Books

  @impl true
  def mount(_params, _session, socket) do
    socket = assign(socket, books: Books.get_all_by_user_id(socket.assigns.current_user.id))

    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <h1 class="text-slate-600 text-5xl mb-12">My Books</h1>
    <button class="mt-6 bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded">
      <.link patch={~p"/books/new"}>
        Add Book
      </.link>
    </button>
    <div>
      <ul class="flex flex-row flex-wrap">
        <li :for={book <- @books} class="min-w-80">
          <section class="max-w-sm rounded overflow-hidden shadow-lg m-4 ">
            <article class="px-6 py-4">
              <div class="flex flex-row">
                <h3 class="text-slate-600 font-bold text-xl mb-2 basis-11/12">
                  <%= book.title %>
                </h3>
                <div phx-click="delete_book" phx-value-id={book.id}>
                  <.icon name="hero-x-circle" class="h-6 w-6 text-slate-500" />
                </div>
              </div>
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

  @impl true
  def handle_event("delete_book", %{"id" => id}, socket) do
    Books.delete(id, socket.assigns.current_user.id)
    {:noreply, assign(socket, books: Books.get_all_by_user_id(socket.assigns.current_user.id))}
  end
end
