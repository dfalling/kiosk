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

    test "shows cart total", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Total: €0.00"
    end

    test "adds item to cart and updates total", %{conn: conn} do
      {:ok, view, html} = live(conn, ~p"/")

      view
      |> element("#product_CF1")
      |> render_click()

      view
      |> element("#cart-items > :first-child")
      |> render() =~ "Coffee"

      render(view) =~ "Total: €11.23"
    end
  end
end
