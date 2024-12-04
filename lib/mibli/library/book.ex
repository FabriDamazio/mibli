defmodule Mibli.Library.Book do
  use Ash.Resource,
    domain: Mibli.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "books"
    repo Mibli.Repo
  end

  actions do
    defaults [:destroy]

    create :create do
      accept [:title, :owner_id]
    end

    read :all_books do
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

    attribute :author, :string do
      allow_nil? true
      public? true
    end

    attribute :publication_year, :integer do
      allow_nil? false
      public? true
      constraints min: 0, max: 9999
    end
  end

  relationships do
    belongs_to :owner, Mibli.Accounts.User
  end
end
