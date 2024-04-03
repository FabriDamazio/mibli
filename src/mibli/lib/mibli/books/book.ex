defmodule Mibli.Books.Book do
  use Ecto.Schema
  import Ecto.Changeset

  schema "books" do
    field :author, :string
    field :description, :string
    field :title, :string
    field :read, :boolean, default: false
    belongs_to :user, Mibli.Accounts.User

    timestamps()
  end

  def book_changeset(book, params \\ %{}) do
    book
    |> cast(params, [:title, :author, :description, :user_id, :read])
    |> validate_length(:title, min: 1, max: 256)
    |> validate_length(:author, min: 1, max: 256)
    |> validate_length(:description, min: 1, max: 2048)
    |> validate_required([:title, :user_id])
  end
end
