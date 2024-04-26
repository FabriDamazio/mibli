defmodule MibliWeb.Books.BookCardComponent do
  use MibliWeb, :html

  attr :book, :map, required: true
  attr :rest, :global, include: ~w(disabled form name value)

  def book_card(assigns) do
    ~H"""
    <section
      id={"bookcard-#{@book.id }"}
      class="max-w-sm rounded overflow-hidden shadow-lg m-4"
      {@rest}
    >
      <article class="px-6 py-4">
        <div class="flex flex-row">
          <h3 class="text-slate-600 font-bold text-xl mb-2 basis-11/12">
            <%= assigns.book.title %>
          </h3>
          <div
            phx-click="delete_book"
            phx-value-id={assigns.book.id}
            data-confirm="Are you sure?"
            class="cursor-pointer"
          >
            <.icon name="hero-x-circle" class="h-6 w-6 text-slate-500" />
          </div>
        </div>
        <p class="text-slate-400 text-sm">
          <%= assigns.book.author || "Unknown" %>
        </p>
        <p class="text-slate-500 text-base">
          <%= assigns.book.description %>
        </p>
        <div class="flex flex-row flex-wrap mt-2">
          <.tag :if={assigns.book.read} text="Read" color="bg-green-100 text-green-800" />
          <.tag :if={!assigns.book.read} text="Not Read" color="bg-red-100 text-red-800" />
        </div>
      </article>
    </section>
    """
  end
end
