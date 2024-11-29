import Config
config :mibli, token_signing_secret: "7MYATQN5y3dgtNmvWSNyj4RvbE1FA46+"
config :ash, disable_async?: true

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :mibli, Mibli.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "mibli_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mibli, MibliWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "NHAZbP2+J6X6AUxMZ9lOt9t35yMcJu/YWQ6ugs5K62hM+R3nWwdOhvNWmUqsHYRP",
  server: false

# In test we don't send emails
config :mibli, Mibli.Mailer, adapter: Swoosh.Adapters.Test

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true
