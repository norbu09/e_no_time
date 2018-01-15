# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :welcome,
  namespace: Welcome

# Configures the endpoint
config :welcome, WelcomeWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NwEQOV+OhfO9v81aPaK8hucDvo0QHbPfd20H1IF01la+nyslpF/5SaSsURmRZQD1",
  render_errors: [view: WelcomeWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Welcome.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
