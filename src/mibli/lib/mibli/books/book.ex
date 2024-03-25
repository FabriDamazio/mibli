defmodule Mibli.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :author, :string
    field :description, :string
    field :title, :string
    belongs_to :user, Mibli.Accounts.User

    timestamps()
  end

  def add_book_changeset(book, params \\ %{}) do
    book
    |> cast(params, [:title, :author, :description, :user_id])
    |> validate_required([:title, :user_id])
  end
end
