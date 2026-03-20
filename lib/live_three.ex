defmodule LiveThree do
  @moduledoc """
  Documentation for `LiveThree`.
  """
  defmacro __using__(_opts) do
    quote do
      import LiveThree.Components
    end
  end
end
