defmodule Bouncer.MixProject do
  use Mix.Project

  def project do
    [
      app: :bouncer,
      version: "0.1.0",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :exconsul],
      mod: {Bouncer.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
        {:exconsul, github: "norbu09/exconsul"},
      # {:sibling_app_in_umbrella, in_umbrella: true},
    ]
  end
end
