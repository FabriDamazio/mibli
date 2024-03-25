defmodule Mibli.Books do
  import Ecto.Query, warn: false
  require Logger
  alias Mibli.Repo
  alias Mibli.Books.Book

  def get_all_by_user_id(user_id) do
    Book
    |> where([b], b.user_id == ^user_id)
    |> Repo.all()
  end

  def add(attrs) do
    %Book{}
    |> Book.add_book_changeset(attrs)
    |> Repo.insert()
  end

  def delete(id, user_id) do
    case Repo.get(Book, id) do
      nil ->
        {:error, "Book not found"}

      book ->
        if book.user_id == user_id do
          Repo.delete(book)
          {:ok, "Book deleted"}
        else
          Logger.warning("Tried to delete a book that does not belong to the current user.")
          {:error, "Book does not belong to user"}
        end
    end
  end
end
