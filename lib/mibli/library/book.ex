defmodule Mibli.Library.Book do
  use Ash.Resource,
    domain: Mibli.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "books"
    repo Mibli.Repo
  end

  code_interface do
    define :my_books, args: [:user_id]
  end

  actions do
    defaults [:destroy]

    create :create do
      accept [:title, :owner_id]
    end

    read :my_books do
      argument :user_id, :uuid do
        allow_nil? false
      end

      filter expr(owner_id == ^arg(:user_id))
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :title, :string do
      allow_nil? false
      public? true
    end
  end

  relationships do
    belongs_to :owner, Mibli.Accounts.User
  end
end
