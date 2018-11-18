defmodule Omitestee.Paginator.Search.Mock do
  @moduledoc """
  Module to mock `Search` behaviour.
  """

  use Omitestee.Fixtures, [:paginator]

  alias Omitestee.Paginator.Search

  @behaviour Search

  @impl Search
  def repositories("empty", _) do
    {:ok, %{items: [], total_count: 0}}
  end
  def repositories("elixir", _) do
    {:ok, %{items: [repository_fixture(:github_elixir),
                    repository_fixture(:github_phoenix)],
            total_count: 2}}
  end
  def repositories(_, _) do
    repositories("empty", %{})
  end

  @impl Search
  def per_page() do
    Application.get_env(:omitestee, :paginator)
    |> get_in([:per_page])
  end

  @impl Search
  def items_limit(), do: 1_000
end
