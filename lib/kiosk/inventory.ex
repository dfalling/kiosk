defmodule Kiosk.Inventory do
  @moduledoc """
  The Inventory context.
  """

  alias Kiosk.Inventory.Product

  @products [
    %Product{
      code: "GR1",
      name: "Green Tea",
      price: 3.11
    },
    %Product{
      code: "SR1",
      name: "Strawberries",
      price: 5.00
    },
    %Product{
      code: "CF1",
      name: "Coffee",
      price: 11.23
    }
  ]

  @doc """
  Returns the list of products.

  ## Examples

      iex> list_products()
      [%Product{}, ...]

  """
  def list_products, do: @products

  @doc """
  Gets a single product.

  Raises `Kiosk.NoResultsError` if the Product does not exist.

  ## Examples

      iex> get_product!("GR1")
      %Product{
        code: "GR1",
        name: "Green Tea",
        price: 3.11
      }

      iex> get_product!(456)
      ** (Kiosk.NoResultsError)

  """
  def get_product!(code) do
    Enum.find(@products, &(&1.code == code))
    |> case do
      nil -> raise Kiosk.NoResultsError
      product -> product
    end
  end

  @doc """
    Gets the total price of the cart items.

    ## Examples

      iex> calculate([%Product{price: 3.11}, %Product{price: 5.00}])
      8.11
  """

  def cart_total(cart_items), do: Kiosk.CartTotal.calculate(cart_items)
end
