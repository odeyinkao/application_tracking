defmodule ApplicationTracking.Operation.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "comments" do
    field :body, :string
    # field :candidate_id, :id
    # field :user_id, :id
    belongs_to :candidate, ApplicationTracking.Operation.Candidate
    belongs_to :user, ApplicationTracking.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(comment, attrs) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
