defmodule TrialWeb.HelloController do
  use TrialWeb, :controller

  alias Trial.Warehouse


  def index(conn, _params) do
    warehouse_id = Warehouse.list_warehouse_id()
    render(conn, :index, warehouse_id: warehouse_id)
  end
end
