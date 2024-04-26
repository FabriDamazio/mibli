defmodule MibliWeb.Books.BooksLive do
  use MibliWeb, :live_view
  import MibliWeb.Books.BookCardComponent
  alias Mibli.Books
  alias Mibli.Books.Book

  @impl true
  def mount(_params, _session, socket) do
    socket =
      assign(socket,
        books: Books.get_all_by_user_id(socket.assigns.current_user.id),
        form: to_form(Books.changeset(%Book{})),
        page_title: "My Books"
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _uri, socket) do
    case Books.get_by_id(id) do
      %Book{} = book ->
        socket =
          socket
          |> push_event("show-modal", %{
            to: "#modal-show",
            attr: "data-show"
          })
          |> assign(:form, to_form(Books.changeset(book)))
          |> assign(:page_title, "Editing #{book.title}")

        {:noreply, socket}

      _ ->
        {:noreply, push_patch(socket, to: ~p"/books")}
    end
  end

  @impl true
  def handle_params(_params, _uri, socket) do
    {:noreply, assign(socket, page_title: "My Books")}
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
          <.book_card book={book} phx-click="edit_book" phx-value-id={book.id} class="cursor-pointer" />
        </li>
      </ul>
    </div>
    <div id="modal-show" data-show={show_modal("edit_book_modal")}>
      <.modal id="edit_book_modal" on_cancel={JS.navigate(~p"/books")}>
        <div class="bg-white p-6 rounded-lg">
          <h2 class="text-2xl text-slate-600">Edit Book</h2>
          <p class="text-slate-600">
            <.form for={@form} id="modal-form" phx-submit="save_edit" phx-change="validate">
              <.input type="hidden" field={@form[:id]} />
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
              <button
                id="save-button"
                class="mt-6 bg-sky-600 hover:bg-sky-700 text-white px-4 py-2 rounded"
                phx-submit="save_edit"
                phx-click={hide_modal("edit_book_modal")}
              >
                Save
              </button>
            </.form>
          </p>
        </div>
      </.modal>
    </div>
    """
  end

  @impl true
  def handle_event("edit_book", %{"id" => id}, socket) do
    socket = push_patch(socket, to: ~p"/books/edit/#{id}")
    {:noreply, socket}
  end

  @impl true
  def handle_event("delete_book", %{"id" => id}, socket) do
    Books.delete(id, socket.assigns.current_user.id)

    socket =
      socket
      |> assign(:books, Books.get_all_by_user_id(socket.assigns.current_user.id))
      |> put_flash(:info, "Book removed successfully")

    {:noreply, socket}
  end

  @impl true
  def handle_event("save_edit", %{"book" => book}, socket) do
    case Books.update(book["id"], book) do
      {:ok, _book} ->
        socket =
          socket
          |> push_patch(to: ~p"/books")
          |> put_flash(:info, "Book saved.")

        socket =
          update(socket, :books, fn _ ->
            Books.get_all_by_user_id(socket.assigns.current_user.id)
          end)

        {:noreply, socket}

      {:error, _reason} ->
        {:noreply, socket}
    end
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
end
