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
      package: package()
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
      {:ex_doc, ">= 0.0.0", runtime: false}
    ]
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/kihikasamuel/live_three"}
    ]
  end
end
