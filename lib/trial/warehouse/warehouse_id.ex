defmodule Trial.Warehouse.Warehouse_id do
  use Ecto.Schema
  import Ecto.Changeset

  schema "warehouse_id" do
    field :warehouse_id, :string

    timestamps()
  end

  @doc false
  def changeset(warehouse_id, attrs) do
    warehouse_id
    |> cast(attrs, [:warehouse_id])
    |> unique_constraint(:warehouse_id)
    |> validate_required([:warehouse_id])
  end
end
