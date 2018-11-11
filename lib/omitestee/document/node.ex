defmodule Omitestee.Document.Node do
  @moduledoc """
  Schema representing a node in hierarchical document structure.
  """

  use Ecto.Schema
  alias Ecto.Changeset
  alias __MODULE__

  @type t :: %Node{}

  @primary_key {:id, :integer, autogenerate: false, source: :id}
  embedded_schema do
    field(:title, :string)
    field(:level, :integer)
    field(:children, {:array, Node}, default: [])
    field(:parent_id, :integer)
  end

  @spec changeset(t(), map()) :: Changeset.t()
  def changeset(%Node{} = node, params \\ %{}) do
    node
    |> Changeset.cast(params, ~w(id title level children parent_id)a)
    |> Changeset.validate_required(~w(id title level children)a)
  end

  @spec cast(any()) :: {:ok, t()} | {:error, atom()}
  def cast(params), do: new(params)

  @doc """
  Creates a new node according to passed params and returns {:ok, %Node{}}.
  In case of some invalid params returns {:error, :invalid_params}.
  """
  @spec new(map) :: {:ok, t()} | {:error, atom()}
  def new(params) when is_map(params) do
    node = %Node{} |> changeset(params)

    case node.valid? do
      true -> {:ok, node |> Changeset.apply_changes()}
      false -> {:error, :invalid_params}
    end
  end
  def new(_), do: {:error, :invalid_params}
end
