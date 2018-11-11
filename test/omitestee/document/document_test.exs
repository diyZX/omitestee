defmodule Omitestee.DocumentTest do
  use ExUnit.Case, async: true
  use Omitestee.Fixtures, [:document]

  alias Omitestee.Document

  describe "transform" do
    test "invalid format" do
      assert {:error, :invalid_format} =
        Document.transform("test")
      assert {:error, :invalid_format} =
        Document.transform(%{"test" => "test"})
    end

    test "invalid document" do
      assert {:error, :invalid_params} =
        Document.transform(%{"1" => [node_fixture(:with_invalid_types)]})
    end

    test "valid document" do
      assert {:ok, _} =
        Document.transform(document_fixture(:valid))
    end
  end
end

