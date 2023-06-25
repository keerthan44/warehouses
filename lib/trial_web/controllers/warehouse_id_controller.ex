defmodule TrialWeb.Warehouse_idController do
  use TrialWeb, :controller

  alias Trial.Warehouse
  alias Trial.Warehouse.Warehouse_id

  require Logger
  require IO

  action_fallback TrialWeb.FallbackController

  def index(conn, _params) do
    warehouse_id = Warehouse.list_warehouse_id()
    render(conn, :index, warehouse_id: warehouse_id)
  end

  def create(conn, %{"warehouse_id" => warehouse_id_params}) do
    with {:ok, %Warehouse_id{} = warehouse_id} <- Warehouse.create_warehouse_id(warehouse_id_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/warehouse_id/#{warehouse_id}")
      |> render(:show, warehouse_id: warehouse_id)
    end
  end

  def show(conn, %{"id" => id}) do
    warehouse_id = Warehouse.get_warehouse_id!(id)
    render(conn, :show, warehouse_id: warehouse_id)
  end

  def update(conn, %{"id" => id, "warehouse_id" => warehouse_id_params}) do
    warehouse_id = Warehouse.get_warehouse_id!(id)

    with {:ok, %Warehouse_id{} = warehouse_id} <- Warehouse.update_warehouse_id(warehouse_id, warehouse_id_params) do
      render(conn, :show, warehouse_id: warehouse_id)
    end
  end

  def delete(conn, %{"id" => id}) do
    warehouse_id = Warehouse.get_warehouse_id!(id)

    with {:ok, %Warehouse_id{}} <- Warehouse.delete_warehouse_id(warehouse_id) do
      send_resp(conn, :no_content, "")
    end
  end

  def show_not_used(conn, __params) do
    warehouse_ids_not_used = Warehouse.list_warehouse_id_not_used()
    json(conn, %{"data": warehouse_ids_not_used})
  end
end
