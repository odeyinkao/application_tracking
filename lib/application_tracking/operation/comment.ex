defmodule ApplicationTracking.Operation.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    # field :candidate_id, :id
    # field :user_id, :id
    belongs_to :candidate, ApplicationTracking.Operation.Candidate, foreign_key: :candidate_id
    belongs_to :user, ApplicationTracking.Accounts.User, foreign_key: :user_id

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body, :user_id, :candidate_id])
    |> validate_required([:body, :user_id, :candidate_id])
  end
end
