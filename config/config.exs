# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :scrawler,
  ecto_repos: [Scrawler.Repo]

# Configures the endpoint
config :scrawler, Scrawler.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YT3naVoxzv4Ww9xEp6aoKdeQcMuE9ulNXxnQhj3DTReWeNiUaVsTDuICd2TH2CFb",
  render_errors: [view: Scrawler.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Scrawler.PubSub,
           adapter: Phoenix.PubSub.PG2]

config :phoenix, :template_engines,
  haml: PhoenixHaml.Engine

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
