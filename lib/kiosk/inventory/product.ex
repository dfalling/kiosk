defmodule Kiosk.Inventory.Product do
  use TypedStruct

  typedstruct do
    field(:code, :string)
    field(:name, :string, enforce: true, null: false)
    field(:price, :float, enforce: true, null: false)
  end
end
