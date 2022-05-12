defmodule Mibli.Bookshelves.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :title, :string
    field :author, :string
    field :publisher, :string
    field :total_pages, :integer
    field :isbn, :string

    timestamps()
  end

  def changeset(book, attrs, opts \\ []) do
    book
    |> cast(attrs, [:title, :author, :publisher, :total_pages, :isbn])
  end
end
