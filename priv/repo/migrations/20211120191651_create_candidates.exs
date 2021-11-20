defmodule ApplicationTracking.Repo.Migrations.CreateCandidates do
  use Ecto.Migration

  def change do
    create table(:candidates) do
      add :name, :string
      add :email, :string
      add :status, :string

      timestamps()
    end
  end
end
