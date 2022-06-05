defmodule Mibli.BookshelvesTest do
  use ExUnit.Case, async: true

  import Ecto.Query

  alias Mibli.Repo
  alias Mibli.Bookshelves
  alias Mibli.Bookshelves.Book
  alias Mibli.AccountsFixtures

  setup do
    Ecto.Adapters.SQL.Sandbox.checkout(Repo)
    user = AccountsFixtures.user_fixture()

    %{
      book: %{
        title: "Title",
        author: "Author",
        publisher: "Publisher",
        total_pages: 1,
        isbn: "1",
        user_id: user.id
      }
    }
  end

  describe "add_book/1" do
    test "adds the book to the user bookshelf", %{book: book} do
      {:ok, book_added} = Bookshelves.add_book(book)

      assert [1] == Repo.all(from b in Book, select: count())
      assert book_added == Repo.get_by!(Book, id: book_added.id)
    end

    test "book title is a required", %{book: book} do
      {:error, changeset} = Bookshelves.add_book(%{book | title: nil})

      assert [title: {"can't be blank", [validation: :required]}] == changeset.errors
    end

    test "book title can't be blank", %{book: book} do
      {:error, changeset} = Bookshelves.add_book(%{book | title: ""})

      assert [title: {"can't be blank", [validation: :required]}] == changeset.errors
    end

    test "book title can't be only white spaces", %{book: book} do
      {:error, changeset} = Bookshelves.add_book(%{book | title: " "})

      assert [title: {"can't be blank", [validation: :required]}] == changeset.errors
    end

    test "book should belongs to an user", %{book: book} do
      {:error, changeset} = Bookshelves.add_book(%{book | user_id: nil})

      assert [user_id: {"can't be blank", [validation: :required]}] == changeset.errors
    end
  end
end
