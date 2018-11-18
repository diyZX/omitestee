defmodule Omitestee.Paginator.Repository do
  @moduledoc """
  Schema representing a repository from GitHub Search API.
  """

  use Ecto.Schema
  alias Ecto.Changeset
  alias __MODULE__

  @type t :: %Repository{}

  embedded_schema do
    field(:full_name, :string)
    field(:description, :string)
    field(:language, :string)
    field(:stars_count, :integer)
    field(:license, :string)
  end

  @spec changeset(t(), map()) :: Changeset.t()
  def changeset(%Repository{} = repository, params \\ %{}) do
    repository
    |> Changeset.cast(params, ~w(full_name description language stars_count license)a)
    |> Changeset.validate_required(~w(full_name)a)
  end

  @doc """
  Creates a new repository according to passed params and
  returns %Repository{}.
  """
  @spec new(map) :: t()
  def new(params) when is_map(params) do
    repository_params = %{
      full_name: params |> get_in([:full_name]),
      description: params |> get_in([:description]),
      language: params |> get_in([:language]),
      stars_count: params |> get_in([:stargazers_count]),
      license: params |> get_in([:license, :name])
    }

    %Repository{}
    |> changeset(repository_params)
    |> Changeset.apply_changes()
  end
end
