defmodule Welcome.Mixfile do
  use Mix.Project

  def project do
    [
      app: :welcome,
      version: "0.0.1",
      build_path: "../../_build",
      config_path: "../../config/config.exs",
      deps_path: "../../deps",
      lockfile: "../../mix.lock",
      elixir: "~> 1.4",
      elixirc_paths: elixirc_paths(Mix.env),
      compilers: [:phoenix, :gettext] ++ Mix.compilers,
      start_permanent: Mix.env == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Welcome.Application, []},
      extra_applications: [:logger, :runtime_tools, :comeonin, :pbkdf2_elixir,
                           :ueberauth, :ueberauth_identity, :excontentful, :earmark,
                           :prometheus_phoenix, :prometheus_plugs] ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_),     do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # Phoenix core dependencies
      {:phoenix, "~> 1.3.0"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      {:gettext, "~> 0.11"},
      {:cowboy, "~> 1.0"},

      # Authentication code dependencies
      {:comeonin, "~> 4.0"},
      # {:argon2_elixir, "~> 1.2"},
      {:pbkdf2_elixir, "~> 0.12"},
      {:ueberauth, "~> 0.4"},
      {:ueberauth_identity, "~> 0.2"},

      # metrics
      {:prometheus_phoenix, ">= 1.2.0"},
      {:prometheus_plugs, ">= 1.1.1"},

      # content handling
      {:excontentful, github: "norbu09/excontentful"},
      {:earmark, ">= 1.2.4"}
    ]
  end
end
