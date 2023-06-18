defmodule Trial.WarehouseFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Trial.Warehouse` context.
  """

  @doc """
  Generate a warehouse_ids.
  """
  def warehouse_ids_fixture(attrs \\ %{}) do
    {:ok, warehouse_ids} =
      attrs
      |> Enum.into(%{
        warehouse_id: "some warehouse_id"
      })
      |> Trial.Warehouse.create_warehouse_ids()

    warehouse_ids
  end

  @doc """
  Generate a warehouse_ids_name.
  """
  def warehouse_ids_name_fixture(attrs \\ %{}) do
    {:ok, warehouse_ids_name} =
      attrs
      |> Enum.into(%{
        warehouse_id: "some warehouse_id",
        warehouse_name: "some warehouse_name"
      })
      |> Trial.Warehouse.create_warehouse_ids_name()

    warehouse_ids_name
  end

  @doc """
  Generate a warehouse_id.
  """
  def warehouse_id_fixture(attrs \\ %{}) do
    {:ok, warehouse_id} =
      attrs
      |> Enum.into(%{
        warehouse_id: "some warehouse_id"
      })
      |> Trial.Warehouse.create_warehouse_id()

    warehouse_id
  end

  @doc """
  Generate a warehouse_id_name.
  """
  def warehouse_id_name_fixture(attrs \\ %{}) do
    {:ok, warehouse_id_name} =
      attrs
      |> Enum.into(%{
        warehouse_id: "some warehouse_id",
        warehouse_id_name: "some warehouse_id_name"
      })
      |> Trial.Warehouse.create_warehouse_id_name()

    warehouse_id_name
  end
end
