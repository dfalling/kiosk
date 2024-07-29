defmodule Kiosk.CartTotal do
  alias Kiosk.Inventory.Product

  defmodule ProductQuantity do
    use TypedStruct

    typedstruct do
      field(:product, Product, enforce: true, null: false)
      field(:quantity, :integer, enforce: true, null: false)
    end
  end

  def calculate(cart_products) do
    item_quantities = group_items(cart_products)

    Enum.reduce(item_quantities, 0, fn item_quantity, accumulator ->
      accumulator + calculate_item_total(item_quantity.product, item_quantity.quantity)
    end)
  end

  defp group_items(cart_products) do
    # reduce items into map of product code to product + quantity
    item_quantities_map =
      Enum.reduce(cart_products, %{}, fn cart_product, accumulator ->
        item_quantity =
          Map.get(accumulator, cart_product.code, %ProductQuantity{
            product: cart_product,
            quantity: 0
          })

        quantity = item_quantity.quantity + 1
        updated_item_quantity = Map.put(item_quantity, :quantity, quantity)
        Map.put(accumulator, cart_product.code, updated_item_quantity)
      end)

    # pull items out of map
    Map.values(item_quantities_map)
  end

  def calculate_item_total(%Product{price: price}, quantity), do: price * quantity
end
