defmodule Mibli.BookshelvesTest do
  use ExUnit.Case

  alias Mibli.Repo
  alias Mibli.Bookshelves
  alias Mibli.Bookshelves.Book

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "add_book/1" do
    test "returns the book added to bookshelf on success" do
      valid_book = %Book{
        title: "Title",
        author: "Author",
        publisher: "Publisher",
        total_pages: 1,
        isbn: "1"
      }

      result = Bookshelves.add_book(valid_book)

      assert {:ok, %Book{} = book} = result
    end
  end
end
