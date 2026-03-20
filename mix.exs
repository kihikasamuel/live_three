defmodule LiveThree.MixProject do
  use Mix.Project

  def project do
    [
      app: :live_three,
      version: "0.1.0",
      elixir: "~> 1.18",
      elixirc_options: elixirc_options(Mix.env()),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Seamless Three.js integration for Phoenix LiveView.",
      package: package(),
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  #
  defp elixirc_options(:test), do: [warnings_as_errors: false]
  defp elixirc_options(_), do: [warnings_as_errors: true]

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_live_view, "~> 1.0"},
      {:jason, "~> 1.2"},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false, warn_if_outdated: true}
    ]
  end

  defp package do
    [
      files: ~w(lib assets mix.exs .formatter.exs README.md LICENSE),
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kihikasamuel/live_three"},
      source_url: "https://github.com/kihikasamuel/live_three"
    ]
  end

  defp docs do
    [
      main: "introduction",
      extras: [
        "guides/introduction.md",
        "guides/installation.md",
        "guides/custom_effects.md",
        "guides/architecture.md"
      ],
      groups_for_extras: [
        "Getting Started": [
          "guides/introduction.md",
          "guides/installation.md"
        ],
        "Advanced Usage": [
          "guides/custom_effects.md",
          "guides/architecture.md"
        ]
      ]
    ]
  end
end
