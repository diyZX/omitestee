defmodule Omitestee.Paginator.GitHubSearchTest do
  use ExUnit.Case, async: true

  alias Omitestee.Paginator.GitHubSearch

  describe "repositories" do
    test "returns items" do
      assert {:ok, %{items: _}} =
        GitHubSearch.repositories("elixir")
    end

    test "returns items with per_page" do
      {:ok, %{items: items}} =
        GitHubSearch.repositories("elixir", %{per_page: 1})
      assert 1 = items |> length
    end

    test "returns message when request goes beyond search results limit" do
      assert {:ok, %{message: _}} =
        GitHubSearch.repositories("elixir", %{page: 1_000})
    end
  end
end

