defmodule Kiosk.CartTotal do
  alias Kiosk.Inventory.Product

  defmodule ProductQuantity do
    use TypedStruct

    typedstruct do
      field(:product, Product, enforce: true, null: false)
      field(:quantity, :integer, enforce: true, null: false)
    end
  end

  @doc """
  Calculate the total price of a cart of products.

  ## Examples

      iex> CartTotal.calculate([%Product{code: "GR1", price: 3.11}, %Product{code: "SR1", price: 5.00}])
      8.11
  """
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

  # buy-one-get-one-free deal for green tea
  defp calculate_item_total(%Product{code: "GR1", price: price} = product, quantity)
       when quantity >= 2 do
    discount_total = price * div(quantity, 2)
    discount_total + calculate_item_total(product, rem(quantity, 2))
  end

  # fixed 4.50 deal price for three or more strawberries
  defp calculate_item_total(%Product{code: "SR1"}, quantity)
       when quantity > 2 do
    4.5 * quantity
  end

  # 2/3 price for three or more coffees
  defp calculate_item_total(%Product{code: "CF1", price: price}, quantity)
       when quantity > 2 do
    price * quantity * 2 / 3
  end

  # no offers
  defp calculate_item_total(%Product{price: price}, quantity), do: price * quantity
end
