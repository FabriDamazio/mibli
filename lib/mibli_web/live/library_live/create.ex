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
    </.form>
    """
  end

  def handle_event("save", params, socket) do
    IO.inspect(params)
    {:noreply, socket}
  end

  def handle_event("validate", params, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)
    IO.inspect(form)
    {:noreply, assign(socket, form: form)}
  end
end
