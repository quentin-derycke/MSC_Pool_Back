defmodule GoThimeManager.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GoThimeManagerWeb.Telemetry,
      GoThimeManager.Repo,
      {DNSCluster, query: Application.get_env(:gothime_manager, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GoThimeManager.PubSub},
      # Start a worker by calling: GoThimeManager.Worker.start_link(arg)
      # {GoThimeManager.Worker, arg},
      # Start to serve requests, typically the last entry
      GoThimeManagerWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GoThimeManager.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GoThimeManagerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
