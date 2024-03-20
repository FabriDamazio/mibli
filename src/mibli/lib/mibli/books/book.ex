defmodule Mibli.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :author, :string
    field :description, :string
    field :title, :string

    timestamps()
  end

  def add_book_changeset(book, params \\ %{}) do
    book
    |> cast(params, [:title, :author, :description])
    |> validate_required([:title])
  end
end
