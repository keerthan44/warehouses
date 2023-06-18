defmodule TrialWeb.PageController do
  use TrialWeb, :controller

  alias Trial.Warehouse
  require IO
  require Logger
  action_fallback TrialWeb.FallbackController
  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    warehouseID = [1, 2, 4]
    warehouse_id_name = Warehouse.list_warehouse_id_name_joined()
    Logger.debug(IO.inspect(warehouse_id_name))
    render(conn, :home, warehouse_id_name: warehouse_id_name)
  end
end
