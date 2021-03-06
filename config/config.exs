# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :omitestee, OmitesteeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "V47TMaxEJujpnnfclV5HGsw+FTO/bob4C/mlaCFxIByeUT7L8FnSR2KAKZZnT/Xq",
  render_errors: [view: OmitesteeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Omitestee.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :scrivener_html,
  routes_helper: OmitesteeWeb.Router.Helpers

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :omitestee, :paginator,
  search: Omitestee.Paginator.Search.GitHub,
  github_limit: 1_000,
  per_page: 10

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
