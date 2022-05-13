defmodule Mibli.Bookshelves do
  @moduledoc """
  The Bookshelves context.
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
