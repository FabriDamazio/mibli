defmodule Mibli.Repo.Migrations.BookBelogsToUser do
  use Ecto.Migration

  def change do
    alter table(:books) do
      add :user_id, references(:users, on_delete: :delete_all)
    end
  end
end
