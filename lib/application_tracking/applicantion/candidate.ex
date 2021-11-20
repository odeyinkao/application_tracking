defmodule ApplicationTracking.Applicantion.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :email, :string
    field :name, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :email, :status])
    |> validate_required([:name, :email, :status])
  end
end
