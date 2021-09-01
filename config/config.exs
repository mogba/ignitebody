# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ignitebody,
  ecto_repos: [Ignitebody.Repo]

config :ignitebody, Ignitebody.Repo,
  migration_primary_key: [type: :binary_id],
  migration_foreign_key: [type: :binary_id]

# Configures the endpoint
config :ignitebody, IgnitebodyWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "TNsdr/PhbWYohGNKzHGhgWbjYprm49JjosoyK/IWOGePM8kd8W0SZSqzK7xMLfxu",
  render_errors: [view: IgnitebodyWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Ignitebody.PubSub,
  live_view: [signing_salt: "ragSIID7"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
