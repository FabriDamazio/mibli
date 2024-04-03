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

  def get_by_id(book_id) do
    Book
    |> Repo.get(book_id)
  end

  def update(id, attrs) do
    case Repo.get(Book, id) do
      nil ->
        {:error, "Book not found"}

      book ->
        book
        |> Book.book_changeset(attrs)
        |> Repo.update()
    end
  end

  def add(attrs) do
    %Book{}
    |> Book.book_changeset(attrs)
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

  def changeset_book(book, attrs \\ %{}) do
    book
    |> Book.book_changeset(attrs)
  end
end
