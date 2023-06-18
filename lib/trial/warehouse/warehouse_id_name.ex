defmodule Trial.Warehouse.Warehouse_id_name do
  use Ecto.Schema
  import Ecto.Changeset

  schema "warehouse_id_name" do
    field :warehouse_id, :integer
    field :warehouse_id_name, :string

    timestamps()
  end

  @doc false
  def changeset(warehouse_id_name, attrs) do
    warehouse_id_name
    |> cast(attrs, [:warehouse_id, :warehouse_id_name])
    |> validate_required([:warehouse_id, :warehouse_id_name])
  end
end
