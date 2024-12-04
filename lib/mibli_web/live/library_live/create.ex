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
    <div class="max-w-md mx-auto mt-10 bg-white shadow-md rounded-lg p-8">
      <h2 class="text-2xl font-bold text-gray-800 mb-6">Add Book</h2>
      <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-6">
        <div>
          <.input
            type="text"
            label="Title"
            field={@form[:title]}
            name="title"
            class="w-full mt-1 px-4 py-2 border rounded-md focus:ring focus:ring-blue-300"
          />
        </div>

        <div>
          <.input
            type="text"
            label="Author"
            field={@form[:author]}
            name="author"
            class="w-full mt-1 px-4 py-2 border rounded-md focus:ring focus:ring-blue-300"
          />
        </div>

        <div>
          <.input
            type="number"
            label="Publication Year"
            field={@form[:publication_year]}
            name="publication_year"
            class="w-full mt-1 px-4 py-2 border rounded-md focus:ring focus:ring-blue-300"
          />
        </div>

        <div class="flex justify-end">
          <button
            type="submit"
            class="bg-blue-600 text-white px-6 py-2 rounded-md hover:bg-blue-700 focus:outline-none focus:ring focus:ring-blue-300"
          >
            Save
          </button>
        </div>
      </.form>
    </div>
    """
  end

  def handle_event("save", params, socket) do
    params = Map.put(params, :owner_id, socket.assigns[:current_user].id)
    IO.inspect(params)

    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, _book} ->
        {:noreply,
         socket
         |> put_flash(:info, "Book saved!")
         |> push_navigate(to: ~p"/library")}

      {:error, form} ->
        IO.inspect(form)
        {:noreply, assign(socket, form: form)}
    end
  end

  def handle_event("validate", params, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)
    {:noreply, assign(socket, form: form)}
  end
end
