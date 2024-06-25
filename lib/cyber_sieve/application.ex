defmodule CyberSieve.Application do
  use Application

  def start(_type, _args) do
    children = [
      # Define your supervised processes here
    ]

    opts = [strategy: :one_for_one, name: CyberSieve.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
