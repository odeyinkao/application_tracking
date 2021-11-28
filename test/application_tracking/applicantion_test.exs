defmodule ApplicationTracking.OperationTest do
  use ApplicationTracking.DataCase

  alias ApplicationTracking.Operation

  describe "candidates" do
    alias ApplicationTracking.Operation.Candidate

    import ApplicationTracking.OperationFixtures

    @invalid_attrs %{email: nil, name: nil, status: nil}

    test "list_candidates/0 returns all candidates" do
      candidate = candidate_fixture()
      assert Operation.list_candidates() == [candidate]
    end

    test "get_candidate!/1 returns the candidate with given id" do
      candidate = candidate_fixture()
      assert Operation.get_candidate!(candidate.id) == candidate
    end

    test "create_candidate/1 with valid data creates a candidate" do
      valid_attrs = %{email: "some@email.com", name: "some name", status: "some status"}

      assert {:ok, %Candidate{} = candidate} = Operation.create_candidate(valid_attrs)
      assert candidate.email == "some@email.com"
      assert candidate.name == "some name"
      assert candidate.status == "some status"
    end

    test "create_candidate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Operation.create_candidate(@invalid_attrs)
    end

    test "update_candidate/2 with valid data updates the candidate" do
      candidate = candidate_fixture()
      update_attrs = %{email: "someupdated@email.com", name: "some updated name", status: "some updated status"}

      assert {:ok, %Candidate{} = candidate} = Operation.update_candidate(candidate, update_attrs)
      assert candidate.email == "someupdated@email.com"
      assert candidate.name == "some updated name"
      assert candidate.status == "some updated status"
    end

    test "update_candidate/2 with invalid data returns error changeset" do
      candidate = candidate_fixture()
      assert {:error, %Ecto.Changeset{}} = Operation.update_candidate(candidate, @invalid_attrs)
      assert candidate == Operation.get_candidate!(candidate.id)
    end

    test "delete_candidate/1 deletes the candidate" do
      candidate = candidate_fixture()
      assert {:ok, %Candidate{}} = Operation.delete_candidate(candidate)
      assert_raise Ecto.NoResultsError, fn -> Operation.get_candidate!(candidate.id) end
    end

    test "change_candidate/1 returns a candidate changeset" do
      candidate = candidate_fixture()
      assert %Ecto.Changeset{} = Operation.change_candidate(candidate)
    end
  end

  describe "comments" do
    alias ApplicationTracking.Operation.Comment

    @valid_attrs %{body: "some body"}
    @update_attrs %{body: "some updated body"}
    @invalid_attrs %{body: nil}

    def comment_fixture(attrs \\ %{}) do
      {:ok, comment} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Operation.create_comment()

      comment
    end

    test "list_comments/0 returns all comments" do
      comment = comment_fixture()
      assert Operation.list_comments() == [comment]
    end

    test "get_comment!/1 returns the comment with given id" do
      comment = comment_fixture()
      assert Operation.get_comment!(comment.id) == comment
    end

    test "create_comment/1 with valid data creates a comment" do
      assert {:ok, %Comment{} = comment} = Operation.create_comment(@valid_attrs)
      assert comment.body == "some body"
    end

    test "create_comment/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Operation.create_comment(@invalid_attrs)
    end

    test "update_comment/2 with valid data updates the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{} = comment} = Operation.update_comment(comment, @update_attrs)
      assert comment.body == "some updated body"
    end

    test "update_comment/2 with invalid data returns error changeset" do
      comment = comment_fixture()
      assert {:error, %Ecto.Changeset{}} = Operation.update_comment(comment, @invalid_attrs)
      assert comment == Operation.get_comment!(comment.id)
    end

    test "delete_comment/1 deletes the comment" do
      comment = comment_fixture()
      assert {:ok, %Comment{}} = Operation.delete_comment(comment)
      assert_raise Ecto.NoResultsError, fn -> Operation.get_comment!(comment.id) end
    end

    test "change_comment/1 returns a comment changeset" do
      comment = comment_fixture()
      assert %Ecto.Changeset{} = Operation.change_comment(comment)
    end
  end
end
