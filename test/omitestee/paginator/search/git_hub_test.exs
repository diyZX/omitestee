defmodule Omitestee.Paginator.Search.GitHubTest do
  use ExUnit.Case, async: true

  alias Omitestee.Paginator.Search.GitHub, as: Search

  describe "repositories" do
    test "returns items" do
      assert {:ok, %{items: _}} = Search.repositories("elixir")
    end

    test "returns items with per_page" do
      {:ok, %{items: items}} = Search.repositories("elixir", %{per_page: 1})

      assert 1 = items |> length
    end

    test "returns message when request goes beyond search results limit" do
      assert {:ok, %{message: _}} = Search.repositories("elixir", %{page: 1_000})
    end
  end
end

