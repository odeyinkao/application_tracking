defmodule ApplicationTracking.OperationFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ApplicationTracking.Operation` context.
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
      |> ApplicationTracking.Operation.create_candidate()

    candidate
  end
end
