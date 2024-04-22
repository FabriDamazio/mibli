defmodule MibliWeb.BooksLiveTest do
  use MibliWeb.ConnCase, async: true

  import Phoenix.LiveViewTest
  import Mibli.AccountsFixtures

  describe "Books page" do
    test "renders books page", %{conn: conn} do
      {:ok, lv, html} =
        conn
        |> log_in_user(user_fixture())
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
end
