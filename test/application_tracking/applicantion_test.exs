defmodule ApplicationTracking.ApplicantionTest do
  use ApplicationTracking.DataCase

  alias ApplicationTracking.Applicantion

  describe "candidates" do
    alias ApplicationTracking.Applicantion.Candidate

    import ApplicationTracking.ApplicantionFixtures

    @invalid_attrs %{email: nil, name: nil, status: nil}

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Applicantion.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Applicantion.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      valid_attrs = %{email: "some@email.com", name: "some name", status: "some status"}

      assert {:ok, %Candidate{} = candidate} = Applicantion.create_candidate(valid_attrs)
      assert candidate.email == "some@email.com"
      assert candidate.name == "some name"
      assert candidate.status == "some status"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Applicantion.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      update_attrs = %{email: "someupdated@email.com", name: "some updated name", status: "some updated status"}

      assert {:ok, %Candidate{} = candidate} = Applicantion.update_candidate(candidate, update_attrs)
      assert candidate.email == "someupdated@email.com"
      assert candidate.name == "some updated name"
      assert candidate.status == "some updated status"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Applicantion.update_candidate(candidate, @invalid_attrs)
      assert candidate == Applicantion.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Applicantion.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Applicantion.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Applicantion.change_candidate(candidate)
    end
  end
end
