defmodule Omitestee.Paginator.Search do
  @moduledoc """
  Behaviour defines API for search.
  """

  @doc "Finds all the repositories that match a query."
  @callback repositories(query :: String.t(), params :: map()) ::
    {:ok, map()} | {:error, atom()}

  @doc "Returns count of items per page."
  @callback per_page() :: integer()

  @doc "Returns limit of items."
  @callback items_limit() :: integer()
end
