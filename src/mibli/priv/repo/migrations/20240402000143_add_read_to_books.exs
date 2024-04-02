defmodule Mibli.Repo.Migrations.AddReadToBooks do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :read, :boolean, default: false
    end
  end
end
