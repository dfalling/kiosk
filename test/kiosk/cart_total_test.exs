defmodule Kiosk.CartTotalTest do
  use Kiosk.DataCase

  alias Kiosk.CartTotal

  describe "calculate" do
    alias Kiosk.Inventory.Product

    test "calculate/1 returns total for items with no offers" do
      cart_items = [
        %Product{code: "JM1", name: "Jamon", price: 7.00},
        %Product{code: "OV1", name: "Olives", price: 5.00}
      ]

      assert CartTotal.calculate(cart_items) == 12.00
    end
  end
end
