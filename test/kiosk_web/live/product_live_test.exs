defmodule KioskWeb.ProductLiveTest do
  use KioskWeb.ConnCase

  import Phoenix.LiveViewTest

  describe "Index" do
    test "lists all products", %{conn: conn} do
      {:ok, _index_live, html} = live(conn, ~p"/")

      assert html =~ "Listing Products"

      products = Kiosk.Inventory.list_products()

      Enum.each(products, fn product ->
        assert html =~ product.name
      end)
    end
  end
end
