defmodule KioskWeb.ProductLive.Index do
  use KioskWeb, :live_view

  alias Kiosk.Inventory

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> stream_configure(:products, dom_id: &"product_#{&1.code}")
      |> stream(:products, Inventory.list_products())
      |> assign(:cart_total, 0.00)
      |> assign(:cart_items, [])

    {:ok, socket}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  @impl true
  def handle_event("add_to_cart", %{"code" => code}, socket) do
    product = Inventory.get_product!(code)

    cart_items = [product | socket.assigns.cart_items]
    cart_total = Kiosk.Inventory.cart_total(cart_items)

    {:noreply, assign(socket, cart_total: cart_total, cart_items: cart_items)}
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end
end
