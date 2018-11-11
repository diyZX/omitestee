defmodule Omitestee.Application do
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      OmitesteeWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: Omitestee.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def config_change(changed, _new, removed) do
    OmitesteeWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
