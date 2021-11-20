defmodule ApplicationTracking.Repo do
  use Ecto.Repo,
    otp_app: :application_tracking,
    adapter: Ecto.Adapters.Postgres
end
