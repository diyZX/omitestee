defmodule Omitestee.Paginator.GitHubSearch do
  @moduledoc """
  Wrapper module to fetch data from
  [GitHub Search API](https://developer.github.com/v3/guides/traversing-with-pagination)
  with pagination.
  """

  @endpoint "https://api.github.com/search"

  @doc """
  Finds all the repositories that match a query.
  """
  @spec repositories(String.t(), map()) :: {:ok, map()} | {:error, atom()}
  def repositories(query, params \\ %{}) do
    request(:repositories, query,
      %{per_page: per_page()} |> Map.merge(params))
  end

  ## Private and auxiliary functions

  @doc "Returns `per_page` value from configuration."
  def per_page() do
    Application.get_env(:omitestee, :paginator) |> get_in([:per_page])
  end

  @doc "Returns GitHub hard limit for items."
  def items_limit(), do: 1_000

  defp request(item, query, params) do
    url = url(item, query, params)

    with {:ok, %{body: body}} <- HTTPoison.get(URI.encode(url), [],
              hackhey: [pool: :default]),
         {:ok, payload} <- Jason.decode(body, keys: :atoms) do
      {:ok, payload}
    else
      {:error, _} -> {:error, :failed_request}
    end
  end

  defp url(item, query, params) do
    "#{@endpoint}/#{item}?q=#{query}#{params(params)}"
  end

  defp params(params) when is_map(params) do
    params
    |> Map.to_list
    |> Enum.map(fn {k, v} -> "&#{k}=#{v}" end)
    |> Enum.join
  end
end
