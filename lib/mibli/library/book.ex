defmodule Mibli.Library.Book do
  use Ash.Resource,
    domain: Mibli.Library,
    data_layer: AshPostgres.DataLayer

  postgres do
    table "books"
    repo Mibli.Repo
  end

  actions do
    defaults [:read, :destroy]

    create :create do
      accept [:title, :owner_id]
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
