defmodule Scrawler do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(Scrawler.Repo, []),
      # Start the endpoint when the application starts
      supervisor(Scrawler.Endpoint, []),
      :poolboy.child_spec(pool_name(), poolboy_config(), []),
      # Start your own worker by calling: Scrawler.Worker.start_link(arg1, arg2, arg3)
      # worker(Scrawler.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Scrawler.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Scrawler.Endpoint.config_change(changed, removed)
    :ok
  end

  defp pool_name() do
    :phantom_pool
  end

  defp poolboy_config() do
    [
      {:name, {:local, pool_name()}},
      {:worker_module, Scrawler.Workers.PhantomWorker},
      {:size, 10},
      {:max_overflow, 5}
    ]
  end
end
