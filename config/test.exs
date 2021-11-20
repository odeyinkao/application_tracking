import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :application_tracking, ApplicationTracking.Repo,
  username: "postgres",
  password: "postgres",
  database: "application_tracking_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :application_tracking, ApplicationTrackingWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "u6jbpcbDiXZmaDBMMXfo79HnuSMOTZHH66Xc6nxHlS2iZE3g/ZHq+LQkFeVVb9zA",
  server: false

# In test we don't send emails.
config :application_tracking, ApplicationTracking.Mailer, adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
