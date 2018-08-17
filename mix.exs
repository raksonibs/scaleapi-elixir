defmodule Scale.MixProject do
  use Mix.Project

  def project do
    [
      app: :scale,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:poison, "~> 3.1"},
      {:httpotion, "~> 3.0.2"},
      {:hackney, "~> 1.13.0"},
      {:sweet_xml, "~> 0.6"},
      {:jason, "~> 1.0"},
      {:httpoison, "~> 1.0", override: true},
    ]
  end
end
