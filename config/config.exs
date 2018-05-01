# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :halla_bol,
  ecto_repos: [HallaBol.Repo]

# Configures the endpoint
config :halla_bol, HallaBolWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "s6jQ/ZpRSTD2gVqYKf19I63JH9zjFfveC2hEsAxpOc2YJYQEIPNRuSr7KkhBOIEX",
  render_errors: [view: HallaBolWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: HallaBol.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
