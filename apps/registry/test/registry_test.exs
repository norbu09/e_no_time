defmodule ENoTime.RegistryTest do
  use ExUnit.Case
  doctest ENoTime.Registry

  test "greets the world" do
    assert ENoTime.Registry.hello() == :world
  end
end
