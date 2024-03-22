defmodule Mibli.BooksTest do
  use Mibli.DataCase

  alias Mibli.Books
  alias Mibli.Books.Book
  alias Mibli.BooksFixtures

  describe "get_all/0" do
    test "returns an empty list if no books are found" do
      assert([] == Books.get_all())
    end

    test "does return list of registered books" do
      book_one = BooksFixtures.book_fixture()
      book_two = BooksFixtures.book_fixture()

      assert([book_one, book_two] == Books.get_all())
    end
  end

  describe "add_1" do
    test "Title is required" do
      assert {:error, changeset} = Books.add(%{})
      assert("can't be blank" in errors_on(changeset).title)
    end

    test "register book only with title" do
      book = %Book{title: "Title"}
      {:ok, registered_book} = Books.add(%{title: "Title"})
      assert book.title == registered_book.title
    end
  end

end
