defmodule Mix.Tasks.LiveThree.Install do
  use Mix.Task

  @shortdoc "Installs LiveThree JS dependencies and provides setup instructions"
  @min_lv_version "0.20.0"

  @moduledoc """
  This task helps you set up LiveThree in your Phoenix project.
  It performs the following:
  1. Checks for a `package.json` in the assets directory.
  2. Runs `npm install three` (or your preferred manager).
  3. Provides the JS Hook registration code.
  """

  def run(_args) do
    Mix.shell().info([:green, "* installing live_three setup..."])

    case check_liveview_version() do
      :ok ->
        perform_install()

      {:error, reason} ->
        Mix.shell().error("✘ Compatibility Error: #{reason}")
        Mix.shell().info("LiveThree requires Phoenix LiveView >= #{@min_lv_version}")
    end
  end

  defp install_npm_deps(path) do
    Mix.shell().info([:blue, "Checking for npm dependencies..."])

    # Detect package manager
    {cmd, args} =
      cond do
        File.exists?(Path.join(path, "pnpm-lock.yaml")) -> {"pnpm", ["add", "three"]}
        File.exists?(Path.join(path, "yarn.lock")) -> {"yarn", ["add", "three"]}
        true -> {"npm", ["install", "--save", "three"]}
      end

    case System.cmd(cmd, args, cd: path, into: IO.stream(:stdio, :line)) do
      {_, 0} ->
        Mix.shell().info([:green, "✔ Successfully installed three.js"])

      _ ->
        Mix.shell().error(
          "✘ Failed to install three.js. Please run '#{cmd} #{Enum.join(args, " ")}' manually in ./assets"
        )
    end
  end

  defp check_liveview_version do
    case Application.loaded_applications() |> List.keyfind(:phoenix_live_view, 0) do
      {:phoenix_live_view, _desc, version} ->
        v_string = List.to_string(version)

        if Version.match?(v_string, ">= #{@min_lv_version}") do
          :ok
        else
          {:error, "Found LiveView #{v_string}, but we need #{@min_lv_version}+"}
        end

      nil ->
        {:error, "Phoenix LiveView not found in loaded applications."}
    end
  end

  defp perform_install do
    assets_path = Path.expand("assets")

    if File.dir?(assets_path) do
      Mix.shell().info([:green, "✔ Environment is compatible. Proceeding with JS install..."])
      install_npm_deps(assets_path)
      print_instructions()
    else
      Mix.shell().error(
        "Could not find 'assets' directory. Make sure you are in the root of your Phoenix project"
      )
    end
  end

  defp print_instructions do
    Mix.shell().info("""

    #{IO.ANSI.bright()}Next Steps:#{IO.ANSI.reset()}

    1. Register the Hook in your #{IO.ANSI.cyan()}assets/js/app.js#{IO.ANSI.reset()}:

       import { LiveThreeHook } from "live_three"
       let Hooks = { LiveThreeHook }
       // ... add to your LiveSocket
       let liveSocket = new LiveSocket("/live", Socket, {
         params: {_csrf_token: csrfToken},
         hooks: Hooks
       })

    2. Use the component in your LiveView template:

       <.three_scene id="my-scene" effect="starfield" />

    Enjoy building in 3D!
    """)
  end
end
