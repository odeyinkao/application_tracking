defmodule ApplicationTracking.ApplicantionFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApplicationTracking.Applicantion` context.
  """

  @doc """
  Generate a candidate.
  """
  def candidate_fixture(attrs \\ %{}) do
    {:ok, candidate} =
      attrs
      |> Enum.into(%{
        email: "some@email.com",
        name: "some name",
        status: "some status"
      })
      |> ApplicationTracking.Applicantion.create_candidate()

    candidate
  end
end
