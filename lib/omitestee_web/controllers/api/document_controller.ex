defmodule OmitesteeWeb.API.DocumentController do
  use OmitesteeWeb, :controller

  alias Omitestee.Document

  @doc """
  Re-organizes document from one format to another.
  """
  def reorganize(conn, params) do
    case Document.transform(params) do
      {:ok, document} ->
        conn
        |> json(document)
      {:error, _} ->
        conn
        |> put_status(:unprocessable_entity)
        |> text("Please check input format")
    end
  end
end
