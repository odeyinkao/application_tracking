defmodule ApplicationTracking.Applicantion.Candidate do
  use Ecto.Schema
  import Ecto.Changeset

  schema "candidates" do
    field :email, :string
    field :name, :string
    field :status, :string, default: "Applied"

    timestamps()
  end

  @doc false
  def changeset(candidate, attrs) do
    candidate
    |> cast(attrs, [:name, :email, :status])
    |> validate_required([:name, :email])
    |> validate_email()
  end

  defp validate_email(changeset) do
    changeset
    |> validate_format(:email, ~r/^[^\s]+@[^\s]+$/, message: "must have the @ sign and no spaces")
    |> validate_length(:email, max: 160)
    |> unsafe_validate_unique(:email, ApplicationTracking.Repo)
    |> unique_constraint(:email)
  end
end
