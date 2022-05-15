defmodule Mibli.BookshelvesTest do
  use ExUnit.Case

  alias Mibli.Repo
  alias Mibli.Bookshelves
  alias Mibli.Bookshelves.Book
  alias Mibli.AccountsFixtures

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "add_book/1" do
    test "adds the book to the user bookshelf on success" do
      user = AccountsFixtures.user_fixture()

      valid_book = %Book{
        title: "Title",
        author: "Author",
        publisher: "Publisher",
        total_pages: 1,
        isbn: "1",
        user: user
      }

      {:ok, %Book{} = book}  = Bookshelves.add_book(valid_book)

      assert Mibli.Repo.get_by!(Book, [id: book.id, title: valid_book.title, user_id: user.id])
    end
  end
end
