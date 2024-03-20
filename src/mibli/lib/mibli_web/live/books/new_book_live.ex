defmodule MibliWeb.Books.NewBookLive do
  use MibliWeb, :live_view
  alias Mibli.Books

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, errors: [], valid?: true)}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-slate-600 text-5xl mb-12">Add Book</h1>
      <div class="flex flex-col">
        <form phx-submit="submit_book">
          <div class="flex flex-col">
            <label for="title" class="text-slate-600 text-lg mb-2">Title</label>
            <input
              id="title"
              name="title"
              type="text"
              class="border border-slate-300 rounded px-4 py-2 mb-4"
            />
          </div>
          <div :if={not @valid?}>
            <span class="text-red-500">Title
            <%= {error_msg, _} = Keyword.get(@errors, :title)
            error_msg %>
            </span>
          </div>
          <div class="flex flex-col">
            <label for="author" class="text-slate-600 text-lg mb-2">Author</label>
            <input
              id="author"
              name="author"
              type="text"
              class="border border-slate-300 rounded px-4 py-2 mb-4"
            />
          </div>
          <div class="flex flex-col">
            <label for="description" class="text-slate-600 text-lg mb-2">Description</label>
            <textarea
              id="description"
              name="description"
              class="border border-slate-300 rounded px-4 py-2 mb-4"
            ></textarea>
          </div>
          <button class="bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded">
            Add Book
          </button>
        </form>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("submit_book", params, socket) do
    case Books.add(params) do
      {:ok, _book} ->
        {:noreply,
         socket
         |> put_flash(:info, "Book added successfully")
         |> push_redirect(to: "/books")}

      {:error, changeset} ->
        IO.inspect(changeset.errors)
        {:noreply, assign(socket, errors: changeset.errors, valid?: changeset.valid?)}
    end
  end
end
