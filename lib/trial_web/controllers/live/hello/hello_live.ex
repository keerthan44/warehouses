defmodule TrialWeb.HelloLive do
  use TrialWeb, :live_view

  import Phoenix.HTML.Form

  alias Trial.Warehouse
  require IO
  require Logger
  def mount(_params, _session, socket) do
    warehouse_id = Warehouse.list_warehouse_id()
    {:ok, assign(socket, warehouse_id: warehouse_id)}
  end

  def handle_event("create", %{"warehouse_id" => warehouse_id_params, "_csrf_token" => token}, socket) do
    #used for creating new warehouse Ids

    warehouse_id_params = %{"warehouse_id" => warehouse_id_params}
    with {:ok, %Warehouse.Warehouse_id{} = warehouse_id} <- Warehouse.create_warehouse_id(warehouse_id_params) do
      warehouse_id_new = Enum.concat(socket.assigns.warehouse_id, [warehouse_id])
      Logger.info(IO.inspect(warehouse_id_new))
      {:noreply, socket
      |> put_flash(:info, "Successfully Added")
      |> assign( warehouse_id: warehouse_id_new)}
    end
  end
end
