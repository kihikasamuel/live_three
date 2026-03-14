defmodule LiveThree.Components do
  @moduledoc """
  Reusable components for embedding Three.js scenes in Phoenix LiveView.

  ## Examples
      <LiveThree.Components.three_scene id="my-three-scene" />
      or
      <.three_canvas
        id="hero-bg"
        effect="starfield"
        options={%{color: "#000000", density: 1.0}}
      />
  ## Sample values for effect: "basic", "starfield"
  ## Sample values for options: %{color: "#000000", density: 1.0, speed: 2.0}

  ## NOTE: Options values are passed to the effect as a map.
  """
  use Phoenix.Component

  attr(:id, :string, required: true)
  attr(:effect, :string, default: "basic")
  attr(:options, :map, default: %{color: "#000000", density: 1.0})
  attr(:class, :string, default: "w-full h-full")

  def three_scene(assigns) do
    ~H"""
    <div
      id={@id}
      phx-hook="LiveThreeHook"
      phx-update="ignore"
      data-effect={@effect}
      data-options={Jason.encode!(@options)}
      class={@class}
    >
      <div id={"#{@id}-canvas-container"} class="w-full h-full"></div>
    </div>
    """
  end
end
