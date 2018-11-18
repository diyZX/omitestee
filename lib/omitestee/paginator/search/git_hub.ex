defmodule Omitestee.Paginator.Search.GitHub do
  @moduledoc """
  Wrapper module to fetch data from
  [GitHub Search API](https://developer.github.com/v3/guides/traversing-with-pagination)
  with pagination.
  """

  alias Omitestee.Paginator.Search

  @behaviour Search

  @endpoint "https://api.github.com/search"

  @impl Search
  def repositories(query, params \\ %{}) do
    request(:repositories, query,
      %{per_page: per_page()} |> Map.merge(params))
  end

  @impl Search
  def per_page() do
    Application.get_env(:omitestee, :paginator)
    |> get_in([:per_page])
  end

  @impl Search
  def items_limit() do
    Application.get_env(:omitestee, :paginator)
    |> get_in([:github_limit])
  end

  ## Private and auxiliary functions

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
