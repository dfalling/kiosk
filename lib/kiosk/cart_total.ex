defmodule Kiosk.CartTotal do
  def calculate(products) do
    Enum.reduce(products, 0, fn product, total ->
      total + product.price
    end)
  end
end
