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
      assert CartTotal.calculate([@green_tea, @strawberries]) == 8.11
    end

    test "calculate/1 returns total for coffee with no offers" do
      assert CartTotal.calculate([@coffee, @coffee]) == 22.46
    end

    test "calculate/1 returns buy-one-get-one-free deal for green tea" do
      assert CartTotal.calculate([@green_tea]) == 3.11
      assert CartTotal.calculate([@green_tea, @green_tea]) == 3.11
      assert CartTotal.calculate([@green_tea, @green_tea, @green_tea]) == 6.22
    end

    test "calculate/1 returns normal price for two strawberries" do
      assert CartTotal.calculate([@strawberries, @strawberries]) == 10.00
    end

    test "calculate/1 returns fixed 4.50 deal price for three or more strawberries" do
      assert CartTotal.calculate([@strawberries, @strawberries, @strawberries]) == 13.50
    end

    test "calculate/1 returns full price for less than three coffee" do
      assert CartTotal.calculate([@coffee, @coffee]) == 22.46
    end

    test "calculate/1 returns 2/3 price for three or more coffee" do
      assert CartTotal.calculate([@coffee, @coffee, @coffee]) == 33.69 * 2 / 3
    end
  end
end
