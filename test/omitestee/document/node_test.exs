defmodule Omitestee.Document.NodeTest do
  use ExUnit.Case, async: true
  use Omitestee.Fixtures, [:document]

  alias Omitestee.Document.Node

  describe "changeset" do
    test "missed params" do
      assert %{valid?: false, errors: [id: _, title: _, level: _]} =
        Node.changeset(%Node{})
    end

    test "invalid types of params" do
      assert %{valid?: false, errors:
               [id: _, title: _, level: _, children: _, parent_id: _]} =
        Node.changeset(%Node{}, node_fixture(:with_invalid_types))
    end

    test "valid params" do
      assert %{valid?: true} =
        Node.changeset(%Node{}, node_fixture(10))
    end
  end

  describe "new" do
    test "missed params" do
      assert {:error, :invalid_params} = Node.new(%{})
    end

    test "invalid types of params" do
      assert {:error, :invalid_params} =
        Node.new(node_fixture(:with_invalid_types))
    end

    test "valid params" do
      assert {:ok, %Node{}} =
        Node.new(node_fixture(10))
    end

    test "unnecessary params" do
      assert {:ok, %Node{}} =
        Node.new(node_fixture(:with_extra_params))
    end
  end
end
