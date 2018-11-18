defmodule Omitestee.Paginator.RepositoryTest do
  use ExUnit.Case, async: true
  use Omitestee.Fixtures, [:paginator]

  alias Omitestee.Paginator.Repository

  describe "changeset" do
    test "missed params" do
      assert %{valid?: false, errors: [full_name: _]} =
        Repository.changeset(%Repository{})
    end

    test "invalid types of params" do
      assert %{valid?: false, errors: [full_name: _, stars_count: _, ]} =
        Repository.changeset(%Repository{}, repository_fixture(:with_invalid_types))
    end

    test "valid params" do
      assert %{valid?: true} =
        Repository.changeset(%Repository{}, repository_fixture(:elixir))
    end
  end

  describe "new" do
    test "valid params" do
      elixir = repository_fixture(:elixir)
      github_elixir = repository_fixture(:github_elixir)

      assert elixir = Repository.new(github_elixir)
    end
  end
end
