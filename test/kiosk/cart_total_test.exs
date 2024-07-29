defmodule Kiosk.CartTotalTest do
  use Kiosk.DataCase

  alias Kiosk.CartTotal

  alias Kiosk.Inventory.Product

  @green_tea %Product{
    code: "GR1",
    name: "Green Tea",
    price: 3.11
  }

  @strawberries %Product{
    code: "SR1",
    name: "Strawberries",
    price: 5.00
  }

  @coffee %Product{
    code: "CF1",
    name: "Coffee",
    price: 11.23
  }

  describe "calculate" do
    test "calculate/1 returns total for items with no offers" do
      cart_items = [@green_tea, @strawberries]

      assert CartTotal.calculate(cart_items) == 8.11
    end

    test "calculate/1 returns total for coffee with no offers" do
      cart_items = [@coffee, @coffee]

      assert CartTotal.calculate(cart_items) == 22.46
    end

    test "calculate/1 returns buy-one-get-one-free deal for green tea" do
      cart_items = [
        @green_tea,
        @green_tea,
        @green_tea
      ]

      assert CartTotal.calculate(cart_items) == 6.22
    end

    test "calculate/1 returns normal price for two strawberries" do
      cart_items = [
        @strawberries,
        @strawberries
      ]

      assert CartTotal.calculate(cart_items) == 10.00
    end

    test "calculate/1 returns fixed 4.50 deal price for three strawberries" do
      cart_items = [
        @strawberries,
        @strawberries,
        @strawberries
      ]

      assert CartTotal.calculate(cart_items) == 13.50
    end
  end
end
