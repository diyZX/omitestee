defmodule Omitestee.Fixtures do
  @moduledoc """
  This module defines data fixtures to be used by any
  kind of tests. Can be used with passing the params of
  some specific fixtures,
  eg. `use Omitestee.Fixtures, [:document]`
  """

  @doc false
  def document() do
    quote do
      @nodes_attrs %{
        10 => %{
          "children" => [],
          "id" => 10,
          "level" => 0,
          "parent_id" => nil,
          "title" => "House"
        },
        12 => %{
          "children" => [],
          "id" => 12,
          "level" => 1,
          "parent_id" => 10,
          "title" => "Red Roof"
        },
        18 => %{
          "children" => [],
          "id" => 18,
          "level" => 1,
          "parent_id" => 10,
          "title" => "Blue Roof"
        },
        13 => %{
          "children" => [],
          "id" => 13,
          "level" => 1,
          "parent_id" => 10,
          "title" => "Wall"
        },
        17 => %{
          "children" => [],
          "id" => 17,
          "level" => 2,
          "parent_id" => 12,
          "title" => "Blue Window"
        },
        16 => %{
          "children" => [],
          "id" => 16,
          "level" => 2,
          "parent_id" => 13,
          "title" => "Door"
        },
        15 => %{
          "children" => [],
          "id" => 15,
          "level" => "56",
          "parent_id" => "12",
          "title" => "Red Window"
        },
        with_invalid_types: %{
          "children" => "test",
          "id" => "test",
          "level" => "test",
          "parent_id" => "test",
          "title" => 123
        },
        with_extra_params: %{
          "id" => 1,
          "level" => 1,
          "title" => "test",
          "extra" => "test"
        }
      }

      @documents_attrs %{
        valid: %{
          "0" => [
            @nodes_attrs[10]
          ],
          "1" => [
            @nodes_attrs[12],
            @nodes_attrs[18],
            @nodes_attrs[13]
          ],
          "2" => [
            @nodes_attrs[17],
            @nodes_attrs[16],
            @nodes_attrs[15]
          ]
        },
        with_invalid_levels: %{
          "test" => [
            @nodes_attrs[10]
          ]
        }
      }

      def node_fixture(node) do
        @nodes_attrs[node]
      end

      def document_fixture(document) do
        @documents_attrs[document]
      end
    end
  end

  @doc false
  def paginator() do
    quote do
      @repositories_attrs %{
        elixir: %{
          full_name: "elixir-lang/elixir",
          description: "Elixir is awesome language",
          language: "Elixir",
          stars_count: 100_500,
          license: "Apache License 2.0"
        },
        with_invalid_types: %{
          full_name: 123,
          stars_count: "test"
        },
        github_elixir: %{
          full_name: "elixir-lang/elixir",
          description: "Elixir is awesome language.",
          language: "Elixir",
          stargazers_count: 100_500,
          license: %{name: "Apache License 2.0"}
        },
        github_phoenix: %{
          full_name: "phoenixframework/phoenix",
          description: "Productive. Reliable. Fast.",
          language: "Elixir",
          stargazers_count: 10_500,
          license: %{name: "MIT license"}
        }
      }

      def repository_fixture(repository) do
        @repositories_attrs[repository]
      end
    end
  end



  defmacro __using__(fixtures) when is_list(fixtures) do
    for fixture <- fixtures, is_atom(fixture),
      do: apply(__MODULE__, fixture, [])
  end
end
