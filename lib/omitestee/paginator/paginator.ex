defmodule Omitestee.Paginator do
  @moduledoc """
  Module provides pagination support and uses `Scrivener.Page` struct
  for this purpose.
  """

  alias Scrivener.Page
  alias Omitestee.Paginator.{GitHubSearch, Repository}

  @hardcoded_query "elixir"

  @spec paginate(map()) :: Scrivener.Page.t()
  def paginate(%{page_number: page_number}) do
    case repositories(page_number) do
      {:ok, %{items: repos, total_count: total_repos}} ->
        total_entries = (if total_repos < GitHubSearch.items_limit(),
          do: total_repos, else: GitHubSearch.items_limit())
        total_pages = total_pages(total_entries, GitHubSearch.per_page())

        {:ok, %Page{
          page_size: GitHubSearch.per_page(),
          page_number: page_number(page_number, total_pages),
          entries: repos |> Enum.map(&Repository.new/1),
          total_entries: total_entries,
          total_pages: total_pages
         }}
      {:ok, %{message: message}} ->
        {:error, message}
    end
  end

  ## Private auxiliary functions

  defp repositories(page_number) do
    response = try_repositories(page_number)
    case response do
      {:ok, %{message: _}} -> try_repositories(1)
      {:ok, %{items: _, total_count: _}} -> response
    end
  end

  defp try_repositories(page_number) do
    GitHubSearch.repositories(@hardcoded_query,
      %{sort: :stars, page: page_number, per_page: GitHubSearch.per_page()})
  end

  defp total_pages(0, _), do: 1
  defp total_pages(total_entries, page_size) do
    (total_entries / page_size) |> Float.ceil() |> round
  end

  defp page_number(page_number, total_pages) do
    cond do
      page_number < 1 -> 1
      page_number > total_pages -> total_pages
      true -> page_number
    end
  end
end
