defmodule BsnWeb do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec
    :ets.new(:session, [:named_table, :public, read_concurrency: true])
    # Define workers and child supervisors to be supervised
    children = [
      # Start the endpoint when the application starts
      supervisor(BsnWeb.Endpoint, []),
      # Start your own worker by calling: BsnWeb.Worker.start_link(arg1, arg2, arg3)
      # worker(BsnWeb.Worker, [arg1, arg2, arg3]),
      worker(Neo4j.Sips, [Application.get_env(:neo4j_sips, Neo4j)])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: BsnWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    BsnWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
