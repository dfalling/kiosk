defmodule Kiosk.Inventory.Product do
  use TypedEctoSchema

  @primary_key false
  typed_schema "products" do
    field(:code, :string)
    field(:name, :string, enforce: true, null: false)
    field(:price, :float, enforce: true, null: false)
  end
end
