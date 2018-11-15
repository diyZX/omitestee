defmodule OmitesteeWeb.SearchController do
  use OmitesteeWeb, :controller

  alias Omitestee.Paginator

  def index(conn, params) do
    config = %{page_number: page(params["page"])}

    case Paginator.paginate(config) do
      {:ok, page} ->
        render(conn, "index.html", page: page)
      {:error, message} ->
        render(conn, "error.html", message: message)
    end
  end

  defp page(nil), do: 1
  defp page(str) when is_binary(str) do
    case Integer.parse(str) do
      {int, _} -> int
      :error -> 1
    end
  end
end
