defmodule Kiosk.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      KioskWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:kiosk, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Kiosk.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Kiosk.Finch},
      # Start a worker by calling: Kiosk.Worker.start_link(arg)
      # {Kiosk.Worker, arg},
      # Start to serve requests, typically the last entry
      KioskWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Kiosk.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    KioskWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
