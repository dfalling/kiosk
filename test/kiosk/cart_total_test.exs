defmodule Kiosk.CartTotalTest do
  use Kiosk.DataCase

  alias Kiosk.CartTotal

  describe "calculate" do
    alias Kiosk.Inventory.Product

    test "calculate/1 returns total for items with no offers" do
      cart_items = [
        %Product{
          code: "GR1",
          name: "Green Tea",
          price: 3.11
        },
        %Product{
          code: "SR1",
          name: "Strawberries",
          price: 5.00
        }
      ]

      assert CartTotal.calculate(cart_items) == 8.11
    end

    test "calculate/1 returns total for duplicate items with no offers" do
      cart_items = [
        %Product{
          code: "CF1",
          name: "Coffee",
          price: 11.23
        },
        %Product{
          code: "CF1",
          name: "Coffee",
          price: 11.23
        }
      ]

      assert CartTotal.calculate(cart_items) == 22.46
    end
  end
end
