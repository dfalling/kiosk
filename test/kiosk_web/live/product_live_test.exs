defmodule KioskWeb.ProductLiveTest do
  use KioskWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "lists all products with their prices to two decimals", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Listing Products"

      products = Kiosk.Inventory.list_products()

      Enum.each(products, fn product ->
        # convert float to two digit string
        price = Float.to_string(product.price, decimals: 2)
        assert html =~ product.name
        assert html =~ "€#{price}"
      end)
    end
  end
end
