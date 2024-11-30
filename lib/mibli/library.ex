defmodule Mibli.Library do
  use Ash.Domain

  resources do
    resource Mibli.Library.Book
  end
end
