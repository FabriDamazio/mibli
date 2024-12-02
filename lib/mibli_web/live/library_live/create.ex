defmodule MibliWeb.LibraryLive.Create do
  use MibliWeb, :live_view

  on_mount {MibliWeb.LiveUserAuth, :live_user_required}

  alias Mibli.Library.Book

  def mount(_params, _session, socket) do
    form =
      Book
      |> AshPhoenix.Form.for_create(:create)
      |> to_form()

    {:ok, assign(socket, :form, form)}
  end

  def render(assigns) do
    ~H"""
    <.form for={@form} phx-change="validate" phx-submit="save">
      <.input type="text" label="Title" field={@form[:title]} name="title" />
      <.button type="submit">Save</.button>
    </.form>
    """
  end

  def handle_event("save", params, socket) do
    params = Map.put(params, :owner_id, socket.assigns[:current_user].id)
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, book} ->
        IO.inspect(book)
        {:noreply,
          socket
          |> put_flash(:info, "Book saved!")
          |> push_navigate(to: ~p"/library")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end

  def handle_event("validate", params, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)
    {:noreply, assign(socket, form: form)}
  end
end
