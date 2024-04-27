defmodule Mibli.Books do
  @moduledoc """
  The Books context.
  """
  import Ecto.Query, warn: false
  require Logger
  alias Mibli.Repo
  alias Mibli.Books.Book

  @doc """
  Returns all books from a specific user matching the given `filter`.

  ## Examples

    Example filter:
    %{read: true}

    iex> get_all_by_user_id(1, filter_map)
    [%Book{}, ...]

    iex> get_all_by_user_id(2)
    []
  """
  def get_all_by_user_id(user_id, filter \\ %{}) do
    from(Book)
    |> filter_by_user(user_id)
    |> filter_by_read(filter)
    |> Repo.all()
  end

  defp filter_by_user(query, user_id) do
    where(query, user_id: ^user_id)
  end

  defp filter_by_read(query, %{read: read}) when is_boolean(read) do
    where(query, read: ^read)
  end

  defp filter_by_read(query, _filter), do: query

  @doc """
  Get a single book by id.

  ## Examples

    iex> get_by_id(1)
    %Book{}

    iex> get_by_id(2)
    nil
  """
  def get_by_id(book_id) do
    Book
    |> Repo.get(book_id)
  end

  @doc """
    Updates a book with the given attributes.

    ## Examples

    iex> update(1, %{title: "Foo"})
    {:ok, %Book{}}

    iex> update(2, %{title: "Bar"})
    {:error, message}

  """
  def update(id, attrs) do
    case Repo.get(Book, id) do
      nil ->
        {:error, "Book not found"}

      book ->
        book
        |> Book.book_changeset(attrs)
        |> Repo.update()
    end
  end

  @doc """
  Adds a new book with the given attributes.

  ## Examples

    iex> add(%{title: "Foo", user_id: 1})
    {:ok, %Book{}}

    iex> add(%{title: "Bar"})
    {:error, %Ecto.Changeset{}}
  """
  def add(attrs) do
    %Book{}
    |> Book.book_changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Deletes a book by id.

  ## Examples

    iex> delete(1, 1)
    {:ok, message}

    iex> delete(2, 1)
    {:error, message}
  """
  def delete(book_id, user_id) do
    case Repo.get(Book, book_id) do
      nil ->
        {:error, "Book not found"}

      book ->
        if book.user_id == user_id do
          Repo.delete(book)
          {:ok, "Book deleted"}
        else
          Logger.notice("Tried to delete a book that does not belong to the current user.")
          {:error, "Book does not belong to user"}
        end
    end
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking book changes.

  ## Examples

    iex> book_changeset(%Book{})
    %Ecto.Changeset{data: %Book{}}
  """
  def changeset(book, attrs \\ %{}) do
    book
    |> Book.book_changeset(attrs)
  end
end
