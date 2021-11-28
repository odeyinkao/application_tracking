defmodule ApplicationTracking.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :candidate_id, references(:candidates, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:comments, [:candidate_id])
    create index(:comments, [:user_id])
  end
end
