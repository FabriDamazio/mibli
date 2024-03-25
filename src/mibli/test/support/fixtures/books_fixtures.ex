defmodule Mibli.BooksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Mibli.Books` context.
  """

  alias Mibli.Books

  def book_fixture(attrs \\ %{}) do
    {:ok, book} =
      attrs
      |> add_book_attributes()
      |> Books.add()

    book
  end

  defp add_book_attributes(attrs) do
    Enum.into(attrs, %{
      title: unique_title(),
      author: unique_author(),
      description: unique_description()
    })
  end

  defp unique_title, do: "Title-#{System.unique_integer()}"
  defp unique_author, do: "Author-#{System.unique_integer()}"
  defp unique_description, do: "Description-#{System.unique_integer()}"
end
