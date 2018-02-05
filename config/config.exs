# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mybs,
  ecto_repos: [Mybs.Repo]

# Configures the endpoint
config :mybs, Mybs.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "3/e1Oxdd76b30dSpTrYRvQ+ONBj+T2WUba0h+PrBVk3WXAdTcYDEqy7essblo2eL",
  render_errors: [view: Mybs.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Mybs.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :mybs, Mybs.Scheduler,
  jobs: [
    {"*/5 * * * *", {Mybs.RaceFetcher, :start, []}}
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
