defmodule TrialWeb.Warehouse_id_nameJSON do
  alias Trial.Warehouse.Warehouse_id_name

  @doc """
  Renders a list of warehouse_id_name.
  """
  def index(%{warehouse_id_name: warehouse_id_name}) do
    %{data: for(warehouse_id_name <- warehouse_id_name, do: data(warehouse_id_name))}
  end

  @doc """
  Renders a single warehouse_id_name.
  """
  def show(%{warehouse_id_name: warehouse_id_name}) do
    %{data: data(warehouse_id_name)}
  end

  defp data(%Warehouse_id_name{} = warehouse_id_name) do
    %{
      id: warehouse_id_name.id,
      warehouse_id: warehouse_id_name.warehouse_id,
      warehouse_id_name: warehouse_id_name.warehouse_id_name
    }
  end
end
