defmodule Mibli.Repo.Migrations.CreateBooks do
  use Ecto.Migration

  def change do
    create table(:books) do
      add :title, :string, null: false
      add :author, :string
      add :publisher, :string
      add :total_pages, :integer
      add :isbn, :string
      timestamps()
    end
  end
end
