defmodule Mibli.BooksTest do
  use Mibli.DataCase

  alias Mibli.Books
  alias Mibli.Books.Book
  alias Mibli.BooksFixtures
  alias Mibli.AccountsFixtures

  describe "get_all_by_user_id/2" do
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

    test "returns list of registered books filtered by read property" do
      user = AccountsFixtures.user_fixture()
      book_one = BooksFixtures.book_fixture(%{user_id: user.id, read: true})
      book_two = BooksFixtures.book_fixture(%{user_id: user.id, read: false})

      assert([book_one] == Books.get_all_by_user_id(user.id, %{read: true}))
      assert([book_two] == Books.get_all_by_user_id(user.id, %{read: false}))
    end

    test "returns an empty list if the user id is not valid" do
      user = AccountsFixtures.user_fixture()
      invalid_user_id = user.id + 1
      assert([] == Books.get_all_by_user_id(invalid_user_id))
    end
  end

  describe "add/1" do
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
      assert {:ok, _} = Books.delete(book.id, user.id)
      assert [] == Books.get_all_by_user_id(user.id)
    end

    test "cannot delete book that does not exist" do
      assert {:error, _} = Books.delete(0, 1)
    end

    test "cannot delete book that belongs to another user" do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      invalid_user_id = user.id + 1

      assert {:error, _} = Books.delete(book.id, invalid_user_id)
    end
  end

  describe "update/2" do
    test "updates book data." do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      updated_book_data = %{
        title: "updated title",
        description: "updated description",
        read: true
      }

      assert {:ok, book_schema} = Books.update(book.id, updated_book_data)
      assert book_schema.title == updated_book_data.title
      assert book_schema.description == updated_book_data.description
      assert book_schema.read == updated_book_data.read
    end

    test "returns :error if book not found" do
      invalid_id = 1

      assert {:error, _} = Books.update(invalid_id, %{})
    end
  end
end
