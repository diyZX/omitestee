defmodule Omitestee.Document do
  @moduledoc """
  Context module which provides functionality for transformation of document
  from one format to another.
  """

  alias Omitestee.Document.Node

  @doc """
  Transforms document from one format to another.
  """
  @spec transform(map()) :: {:ok, [map()]} | {:error, atom()}
  def transform(input) do
    try do
      transform_valid_format(input)
    rescue
      _ -> {:error, :invalid_format}
    end
  end

  ## Private auxiliary functions

  defp transform_valid_format(input) when is_map(input) do
    case process_nodes(input) do
      {:ok, nodes} ->
        output = nodes
        |> Enum.group_by(&(&1.parent_id))
        |> fill_nodes_children(nil)

        {:ok, output}
      {:error, reason} ->
        {:error, reason}
    end
  end

  defp process_nodes(input) do
    input
    |> Map.keys
    |> Enum.flat_map(&(input[&1]))
    |> Enum.map(&(Task.async(fn -> Node.new(&1) end)))
    |> Enum.map(&(Task.await(&1)))
    |> Enum.reduce_while({:ok, []}, &reduce_node/2)
  end

  defp reduce_node(node, {:ok, nodes}) do
    case node do
      {:ok, node} -> {:cont, {:ok, [node | nodes]}}
      {:error, error} -> {:halt, {:error, error}}
    end
  end

  defp fill_nodes_children(all_nodes, parent_id) do
    all_nodes
    |> Map.get(parent_id, [])
    |> Enum.map(&(%{&1 |> Map.from_struct |
                   children: all_nodes |> fill_nodes_children(&1.id)}))
  end
end
