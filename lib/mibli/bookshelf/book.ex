defmodule Mibli.Bookshelf.Book do
  use Ecto.Schema

  schema "books" do
    field :title, :string
    field :author, :string
    field :publisher, :string
    field :total_pages, :integer
    field :isbn, :string

    timestamps()
  end
end
