defmodule MibliWeb.Books.NewBookLive do
  use MibliWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-slate-600 text-5xl mb-12">Add Book</h1>
      <div class="flex flex-col">
        <.form phx-submit="submit_book">
          <div class="flex flex-col">
            <label for="title" class="text-slate-600 text-lg mb-2">Title</label>
            <input id="title" name="title" type="text" class="border border-slate-300 rounded px-4 py-2 mb-4">
          </div>
          <div class="flex flex-col">
            <label for="author" class="text-slate-600 text-lg mb-2">Author</label>
            <input id="author" name="author" type="text" class="border border-slate-300 rounded px-4 py-2 mb-4">
          </div>
          <div class="flex flex-col">
            <label for="description" class="text-slate-600 text-lg mb-2">Description</label>
            <textarea id="description" name="description" class="border border-slate-300 rounded px-4 py-2 mb-4"></textarea>
          </div>
          <button class="bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded">
            Add Book
          </button>
        </.form>
      </div>
    </div>
    """
  end

  def handle_event("submit_book", %{"title" => title, "author" => author, "description" => description}, socket) do
    IO.inspect({title, author, description})

    {:noreply, socket
    |> put_flash(:info, "Book added successfully")
    |> push_redirect(to: "/books")}
  end

end
