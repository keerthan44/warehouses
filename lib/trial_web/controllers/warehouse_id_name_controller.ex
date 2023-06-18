defmodule TrialWeb.Warehouse_id_nameController do
  use TrialWeb, :controller

  alias Trial.Warehouse
  alias Trial.Warehouse.Warehouse_id_name

  action_fallback TrialWeb.FallbackController

  def index(conn, _params) do
    warehouse_id_name = Warehouse.list_warehouse_id_name()
    render(conn, :index, warehouse_id_name: warehouse_id_name)
  end

  def create(conn, %{"warehouse_id_name" => warehouse_id_name_params}) do
    with {:ok, %Warehouse_id_name{} = warehouse_id_name} <- Warehouse.create_warehouse_id_name(warehouse_id_name_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/warehouse_id_name/#{warehouse_id_name}")
      |> render(:show, warehouse_id_name: warehouse_id_name)
    end
  end

  def show(conn, %{"id" => id}) do
    warehouse_id_name = Warehouse.get_warehouse_id_name!(id)
    render(conn, :show, warehouse_id_name: warehouse_id_name)
  end

  def update(conn, %{"id" => id, "warehouse_id_name" => warehouse_id_name_params}) do
    warehouse_id_name = Warehouse.get_warehouse_id_name!(id)

    with {:ok, %Warehouse_id_name{} = warehouse_id_name} <- Warehouse.update_warehouse_id_name(warehouse_id_name, warehouse_id_name_params) do
      render(conn, :show, warehouse_id_name: warehouse_id_name)
    end
  end

  def delete(conn, %{"ids" => ids}) do
    try do
      for id <- ids do
        warehouse_id_name = Warehouse.get_warehouse_id_name!(id)
        Warehouse.delete_warehouse_id_name(warehouse_id_name)
      end
      send_resp(conn, 200, "Success")
    catch
      exit, __ ->
      send_resp(conn, 500, "")
    end
  end
end
