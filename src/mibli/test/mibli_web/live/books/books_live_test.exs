defmodule MibliWeb.BooksLiveTest do
  use MibliWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  alias Mibli.AccountsFixtures
  alias Mibli.BooksFixtures

  describe "Books page" do
    test "renders books page", %{conn: conn} do
      {:ok, lv, html} =
        conn
        |> log_in_user(AccountsFixtures.user_fixture())
        |> live(~p"/books")

      assert %{module: MibliWeb.Books.BooksLive} = lv
      assert html =~ "My Books"
    end

    test "redirects if user is not logged in", %{conn: conn} do
      assert {:error, redirect} = live(conn, ~p"/books")

      assert {:redirect, %{to: path, flash: flash}} = redirect
      assert path == ~p"/users/log_in"
      assert %{"error" => "You must log in to access this page."} = flash
    end
  end

  describe "edit book modal" do
    test "renders edit book modal", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      {:ok, lv, html} =
        conn
        |> log_in_user(user)
        |> live(~p"/books/edit/#{book.id}")

      assert %{module: MibliWeb.Books.BooksLive} = lv
      assert html =~ "Edit Book"
    end

    test "redirects if user is not logged in", %{conn: conn} do
      assert {:error, redirect} = live(conn, ~p"/books/edit/1")

      assert {:redirect, %{to: path, flash: flash}} = redirect
      assert path == ~p"/users/log_in"
      assert %{"error" => "You must log in to access this page."} = flash
    end

    test "renders edit book modal when book card is clicked", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      {:ok, lv, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/books")

      assert lv
        |> element("section#bookcard-#{book.id}")
        |> render_click() =~ "Edit Book"
    end

    test "redirects to edit path when book card is clicked", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      {:ok, lv, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/books")

        lv
        |> element("section#bookcard-#{book.id}")
        |> render_click()

        assert_patch(lv, "/books/edit/#{book.id}")
    end

    test "redirects to books list if book does not exists", %{conn: conn} do
      assert {:error, redirect} =
               conn
               |> log_in_user(AccountsFixtures.user_fixture())
               |> live(~p"/books/edit/1")

      assert {:live_redirect, %{to: path, flash: flash}} = redirect
      assert path == ~p"/books"
      assert %{} = flash
    end

    test "shows flash message when save an edited book", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      {:ok, lv, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/books/edit/#{book.id}")

      assert lv
             |> element("form#modal-form")
             |> render_submit(%{title: "title"}) =~ "Book saved."

      assert %{module: MibliWeb.Books.BooksLive} = lv
    end

    test "redirects to book list after saving", %{conn: conn} do
      user = AccountsFixtures.user_fixture()
      book = BooksFixtures.book_fixture(%{user_id: user.id})

      {:ok, lv, _html} =
        conn
        |> log_in_user(user)
        |> live(~p"/books/edit/#{book.id}")

      lv
      |> element("form#modal-form")
      |> render_submit(%{title: "title"})

      assert_patch(lv, "/books", 30)
    end
  end
end
