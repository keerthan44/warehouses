defmodule TrialWeb.Warehouse_idJSON do
  alias Trial.Warehouse.Warehouse_id

  @doc """
  Renders a list of warehouse_id.
  """
  def index(%{warehouse_id: warehouse_id}) do
    %{data: for(warehouse_id <- warehouse_id, do: data(warehouse_id))}
  end

  @doc """
  Renders a single warehouse_id.
  """
  def show(%{warehouse_id: warehouse_id}) do
    %{data: data(warehouse_id)}
  end

  defp data(%Warehouse_id{} = warehouse_id) do
    %{
      id: warehouse_id.id,
      warehouse_id: warehouse_id.warehouse_id
    }
  end
end
