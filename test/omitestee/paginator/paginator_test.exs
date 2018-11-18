defmodule Omitestee.PaginatorTest do
  use ExUnit.Case, async: true
  use Omitestee.Fixtures, [:paginator]

  alias Omitestee.Paginator

  describe "paginate" do
    test "empty" do
      assert {:ok, %Scrivener.Page{entries: [], page_number: 1,
                                   total_entries: 0, total_pages: 1}} =
        Paginator.paginate("empty", %{page_number: 1})
    end

    test "elixir" do
      entries = [repository_fixture(:github_elixir), repository_fixture(:github_phoenix)]

      assert {:ok, %Scrivener.Page{entries: entries, page_number: 1,
                                   total_entries: 2, total_pages: 1}} =
        Paginator.paginate("elixir", %{page_number: 1})
    end
  end
end
