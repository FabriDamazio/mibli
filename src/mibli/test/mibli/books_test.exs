defmodule Mibli.BooksTest do
  use Mibli.DataCase

  alias Mibli.Books
  alias Mibli.Books.Book
  alias Mibli.BooksFixtures
  alias Mibli.AccountsFixtures

  describe "get_all/0" do
    test "returns an empty list if no books are found" do
      user = AccountsFixtures.user_fixture()
      assert([] == Books.get_all_by_user_id(user.id))
    end

    test "does return list of registered books" do
      user = AccountsFixtures.user_fixture()
      book_one = BooksFixtures.book_fixture(%{user_id: user.id})
      book_two = BooksFixtures.book_fixture(%{user_id: user.id})

      assert([book_one, book_two] == Books.get_all_by_user_id(user.id))
    end
  end

  describe "add_1" do
    test "Title is required" do
      user = AccountsFixtures.user_fixture()

      assert {:error, changeset} = Books.add(%{user_id: user.id})
      assert("can't be blank" in errors_on(changeset).title)
    end

    test "register book only with title" do
      user = AccountsFixtures.user_fixture()
      book = %Book{title: "Title"}
      {:ok, registered_book} = Books.add(%{title: "Title", user_id: user.id})

      assert book.title == registered_book.title
    end
  end

  describe "delete/1" do
    test "delete book" do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      assert [book] == Books.get_all_by_user_id(user.id)
      Books.delete(book.id, user.id)
      assert [] == Books.get_all_by_user_id(user.id)
    end

    test "delete book that does not exist" do
      Books.delete(0, 1)
    end
  end
end
