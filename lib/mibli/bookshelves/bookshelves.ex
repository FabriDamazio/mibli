defmodule Mibli.Bookshelves do
  @moduledoc """
  The Bookshelves context.

  A bookshelf is only a collection of a user books.
  """

  alias Mibli.Repo
  alias Mibli.Bookshelves.Book

  @spec add_book(Book.t()) :: {atom(), Book.t()}
  @doc """
  Add a book.
  """
  def add_book(%Book{} = book) do
    Repo.insert(book)
  end
end
