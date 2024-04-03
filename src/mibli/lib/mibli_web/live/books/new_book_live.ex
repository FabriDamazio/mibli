defmodule MibliWeb.Books.NewBookLive do
  alias Mibli.Books.Book
  use MibliWeb, :live_view
  alias Mibli.Books

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, form: to_form(Book.book_changeset(%Book{})))}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <h1 class="text-slate-600 text-5xl mb-12">Add Book</h1>
      <div class="flex flex-col">
        <.form for={@form} phx-change="validate" phx-submit="submit_book">
          <div class="mb-2">
            <.label for="title">Title</.label>
            <.input type="text" field={@form[:title]} />
          </div>
          <div class="mb-2">
            <.label for="author">Author</.label>
            <.input type="text" field={@form[:author]} />
          </div>
          <div class="mb-2">
            <.label for="description">Description</.label>
            <.input type="text" field={@form[:description]} />
          </div>
          <div class="mb-2">
            <.label for="read">Read</.label>
            <.input type="checkbox" field={@form[:read]} />
          </div>
          <button class="bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded">
            Add Book
          </button>
        </.form>
      </div>
    </div>
    """
  end

  @impl true
  def handle_event("validate", %{"book" => params}, socket) do
    form =
      %Book{}
      |> Book.book_changeset(params)
      |> Map.put(:action, :insert)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  @impl true
  def handle_event("submit_book", %{"book" => params}, socket) do
    params = Map.put(params, "user_id", socket.assigns.current_user.id)
    IO.inspect(params)

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
