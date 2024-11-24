defmodule ExMaglevTest do
  use ExUnit.Case
  test "load nif", context do
    nodes = ["a", "b", "c"]
    {:ok, ref} = ExMaglev.new(nodes, length(nodes))
    assert is_reference(ref)
  end

  test "hash" do
    nodes = [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ]

    {:ok, ref} = ExMaglev.new(nodes)
    {:ok, "Friday"} = ExMaglev.hash(ref, "alice")
    {:ok, "Wednesday"} = ExMaglev.hash(ref, "bob")
    {:ok, 701 = prev_capacity} = ExMaglev.get_capacity(ref)

    new_nodes = [
      "Monday",
      "Tuesday",
      "Wednesday",
      # "Thursday",
      # "Friday",
      "Saturday",
      "Sunday"
    ]

    {:ok, new_ref} = ExMaglev.new(new_nodes, prev_capacity)

    {:ok, "Saturday"} = ExMaglev.hash(new_ref, "alice")
    {:ok, "Wednesday"} = ExMaglev.hash(new_ref, "bob")
  end
end
