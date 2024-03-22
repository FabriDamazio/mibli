defmodule Mibli.Books do
  import Ecto.Query, warn: false
  alias Mibli.Repo
  alias Mibli.Books.Book

  def get_all() do
    Book |> Repo.all()
  end

  def add(attrs) do
    %Book{}
    |> Book.add_book_changeset(attrs)
    |> Repo.insert()
  end

  def delete(id) do
    case Repo.get(Book, id) do
      nil -> {:error, "Book not found"}
      book ->
        Repo.delete(book)
        {:ok, "Book deleted"}
    end
  end
end
