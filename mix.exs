defmodule Omitestee.MixProject do
  use Mix.Project

  def project do
    [
      app: :omitestee,
      version: "0.1.0",
      elixir: "~> 1.5",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix, :gettext] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {Omitestee.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test),
    do: ["lib", "test/support", "test/omitestee/paginator/search"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:phoenix, "~> 1.3.4"},
      {:phoenix_pubsub, "~> 1.0"},
      {:phoenix_html, "~> 2.10"},
      {:phoenix_live_reload, "~> 1.0.0", only: :dev},
      {:cowboy, "~> 1.0"},
      {:plug_cowboy, "~> 1.0"},
      {:ecto, "~> 3.0"},
      {:scrivener_html, "~> 1.7"},
      {:gettext, "~> 0.11"},
      {:jason, "~> 1.0"},
      {:httpoison, "~> 1.4"},
      {:ok, "~> 2.0"}
    ]
  end
end
