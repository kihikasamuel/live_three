defmodule LiveThreeTest do
  use ExUnit.Case
  doctest LiveThree

  test "greets the world" do
    assert LiveThree.hello() == :world
  end
end
