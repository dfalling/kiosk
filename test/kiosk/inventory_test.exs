defmodule Kiosk.InventoryTest do
  use Kiosk.DataCase

  alias Kiosk.Inventory

  describe "products" do
    test "list_products/0 returns all products" do
      assert Inventory.list_products() |> length() == 3
    end
  end
end
