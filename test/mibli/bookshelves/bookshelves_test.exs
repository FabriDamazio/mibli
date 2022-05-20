defmodule Mibli.BookshelvesTest do
  use ExUnit.Case

  import Ecto.Query

  alias Mibli.Repo
  alias Mibli.Bookshelves
  alias Mibli.Bookshelves.Book
  alias Mibli.AccountsFixtures

  @book_params %{
    title: "Title",
    author: "Author",
    publisher: "Publisher",
    total_pages: 1,
    isbn: "1",
    user_id: nil
  }

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Repo)
  end

  describe "add_book/1" do
    test "adds the book to the user bookshelf on success" do
      user = AccountsFixtures.user_fixture()
      valid_book = %{@book_params | user_id: user.id}

      {:ok, %Book{} = book} = Bookshelves.add_book(valid_book)

      assert [1] == Repo.all(from b in Book, select: count())
      assert book == Repo.get_by!(Book, id: book.id, title: valid_book.title, user_id: user.id)
    end

    test "book title is a required" do
      user = AccountsFixtures.user_fixture()
      nil_title_book = %{@book_params | title: nil, user_id: user.id}

      {:error, changeset} = Bookshelves.add_book(nil_title_book)

      assert [title: {"can't be blank", [validation: :required]}] == changeset.errors
    end

    test "book title can't be blank" do
      user = AccountsFixtures.user_fixture()
      blank_title_book = %{@book_params | title: "", user_id: user.id}

      {:error, changeset} = Bookshelves.add_book(blank_title_book)

      assert [title: {"can't be blank", [validation: :required]}] == changeset.errors
    end

    test "book title can't be only white space" do
      user = AccountsFixtures.user_fixture()
      whitespace_title_book = %{@book_params | title: " ", user_id: user.id}

      {:error, changeset} = Bookshelves.add_book(whitespace_title_book)

      assert [title: {"can't be blank", [validation: :required]}] == changeset.errors
    end

    test "book should belongs to an user" do
      book_without_user = %{@book_params | user_id: nil}

      {:error, changeset} = Bookshelves.add_book(book_without_user)

      assert [user_id: {"can't be blank", [validation: :required]}] == changeset.errors
    end
  end
end
