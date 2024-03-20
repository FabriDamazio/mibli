defmodule Mibli.Books do
  import Ecto.Query, warn: false
  alias Mibli.Repo
  alias Mibli.Books.Book

  def get_all() do
    Book |> Repo.all()
  end

  def add(attrs) do
    %Book{}
    |> Book.add_book_changeset(attrs)
    |> Repo.insert()
  end
end
