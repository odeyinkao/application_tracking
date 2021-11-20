defmodule ApplicationTracking.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      ApplicationTracking.Repo,
      # Start the Telemetry supervisor
      ApplicationTrackingWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: ApplicationTracking.PubSub},
      # Start the Endpoint (http/https)
      ApplicationTrackingWeb.Endpoint
      # Start a worker by calling: ApplicationTracking.Worker.start_link(arg)
      # {ApplicationTracking.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ApplicationTracking.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ApplicationTrackingWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
