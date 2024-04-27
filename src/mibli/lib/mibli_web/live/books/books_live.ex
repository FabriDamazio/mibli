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
        filters: %{read: ""},
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

  def handle_params(params, _uri, socket) do
    filters = extract_filters(params)

    socket =
      assign(socket,
        books: Books.get_all_by_user_id(socket.assigns.current_user.id, filters),
        filters: filters
      )

    {:noreply, assign(socket, page_title: "My Books")}
  end

  @impl true
  def handle_event("filter", %{"read_filter" => read}, socket) do
    if read === "" do
      {:noreply, push_patch(socket, to: ~p"/books")}
    else
      params = %{read: read}
      {:noreply, push_patch(socket, to: ~p"/books?#{params}")}
    end
  end

  def handle_event("edit_book", %{"id" => id}, socket) do
    socket = push_patch(socket, to: ~p"/books/edit/#{id}")
    {:noreply, socket}
  end

  def handle_event("delete_book", %{"id" => id}, socket) do
    Books.delete(id, socket.assigns.current_user.id)

    socket =
      socket
      |> assign(:books, Books.get_all_by_user_id(socket.assigns.current_user.id))
      |> put_flash(:info, "Book removed successfully")

    {:noreply, socket}
  end

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

  def handle_event("validate", %{"book" => params}, socket) do
    form =
      %Book{}
      |> Book.book_changeset(params)
      |> Map.put(:action, :insert)
      |> to_form()

    {:noreply, assign(socket, form: form)}
  end

  defp extract_filters(params) when is_map(params) do
    read_param =
      case params["read"] do
        "true" -> true
        "false" -> false
        _ -> ""
      end

    %{read: read_param}
  end
end
