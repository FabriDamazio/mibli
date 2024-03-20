defmodule Mibli.Repo.Migrations.AddBook do
  use Ecto.Migration

  def change do
    create table("books") do
      add :author, :string, size: 256
      add :description, :string, size: 2048
      add :title, :string, size: 256

      timestamps()
    end
  end
end
