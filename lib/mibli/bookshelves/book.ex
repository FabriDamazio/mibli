defmodule Mibli.Bookshelves.Book do
  use Ecto.Schema
  import Ecto.Changeset

  @type t() :: %__MODULE__{
          title: String.t(),
          author: String.t(),
          publisher: String.t(),
          total_pages: integer(),
          isbn: String.t(),
          user: Mibli.Accounts.User
        }

  schema "books" do
    field :title, :string
    field :author, :string
    field :publisher, :string
    field :total_pages, :integer
    field :isbn, :string

    belongs_to :user, Mibli.Accounts.User
    timestamps()
  end

  def changeset(book, attrs, opts \\ []) do
    book
    |> cast(attrs, [:title, :author, :publisher, :total_pages, :isbn])
  end
end
