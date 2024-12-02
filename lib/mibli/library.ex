defmodule Mibli.Library do
  use Ash.Domain

  resources do
    resource Mibli.Library.Book do
      define :all_books, args: [:user_id]
    end
  end
end
