defmodule Mibli.Bookshelves do
  @moduledoc """
  The Bookshelves context.

  A bookshelf is only a collection of a user books.
  """

  alias Mibli.Repo
  alias Mibli.Bookshelves.Book

  @spec add_book(map()) :: {atom(), Ecto.Changeset.t()}
  @doc """
  Add a book.
  """
  def add_book(attrs) do
    %Book{}
    |> Book.changeset(attrs)
    |> Repo.insert()
  end
end
