defmodule TrialWeb.PageLive do
  use TrialWeb, :live_view

  import Phoenix.HTML.Form

  alias Trial.Warehouse
  require IO
  require Logger

  def mount(_params, _session, socket) do
    warehouse_id_name = Warehouse.list_warehouse_id_name_joined()
    warehouse_id_name = Enum.map(warehouse_id_name, fn warehouse ->  %{"warehouse_id": %{warehouse.warehouse_id => warehouse.primary_key},"new": false, toggle: false} |> Enum.into(warehouse) end)
    Logger.info(IO.inspect(warehouse_id_name))

    {:ok, assign(socket, warehouse_id_name: warehouse_id_name, toggle_ids: [], visibility: [])}
  end

  def handle_event("checkAll", %{"value" => "on"}, socket) do
    toggle_ids = socket.assigns.warehouse_id_name |> Enum.map(& &1.id)
    {:noreply, assign(socket, :toggle_ids, toggle_ids)}
  end

  def handle_event("checkAll", %{}, socket) do
    {:noreply, assign(socket, :toggle_ids, [])}
  end

  def handle_event("table_data_checkboxes", %{"toggle-id" => id}, socket) do
  id = if id != "new", do: String.to_integer(id), else: id
  toggle_ids = socket.assigns.toggle_ids

  toggle_ids =
    if (id in toggle_ids) do
      Enum.reject(toggle_ids, & &1 == id)
    else
      [id|toggle_ids]
    end

  {:noreply, assign(socket, :toggle_ids, toggle_ids)}
  end

  def handle_event("pencilClick", %{"id" => id}, socket) do
    id = String.to_integer(id)
    visbility = Enum.reject(socket.assigns.visibility, & &1 == id)
    {:noreply, assign(socket, :visibility, [id | socket.assigns.visibility])}
  end

  def handle_event("reset", %{"id" => id}, socket) do
    if id != "new" do
      id = String.to_integer(id)
      visibility = Enum.reject(socket.assigns.visibility, & &1 == id)
      {:noreply, assign(socket, %{visibility:  visibility, warehouse_id_name: socket.assigns.warehouse_id_name})}
    else
      visibility = Enum.reject(socket.assigns.visibility, & &1 == id)
      warehouse_id_name_mod = socket.assigns.warehouse_id_name |> Enum.reverse() |> tl() |> Enum.reverse()
      {:noreply, assign(socket, %{visibility:  visibility, warehouse_id_name: warehouse_id_name_mod})}
    end

  end

  def handle_event("update", %{"warehouse_name" => warehouse_name, "id" => id, "warehouse_id" => warehouse_id}, socket) do
    warehouse_id_name_params = %{ "warehouse_id_name" => warehouse_name, "warehouse_id" => warehouse_id}
    with {:ok, %Warehouse.Warehouse_id_name{} = warehouse} <- Warehouse.create_warehouse_id_name(warehouse_id_name_params) do
      warehouse_id_name_mod = %{"warehouse_id": %{warehouse_name => warehouse_id},  warehouse_name: warehouse_name, id: warehouse.id, primary_key: warehouse_id, "new": false, toggle: false}
      Logger.info(IO.inspect(warehouse_id_name_mod))
      warehouse_id_name = Enum.map(socket.assigns.warehouse_id_name, fn warehouse -> if warehouse.id == "new", do: warehouse_id_name_mod |> Enum.into(warehouse), else: warehouse end)
      visibility = Enum.reject(socket.assigns.visibility, & &1 == id)
      {:noreply, assign(socket, %{visibility:  visibility, warehouse_id_name: warehouse_id_name})}
    end
  end

  def handle_event("update", %{"warehouse_name" => warehouse_name, "id" => id}, socket) do
    id = String.to_integer(id)
    warehouse_id_name = Warehouse.get_warehouse_id_name!(id)

    with {:ok, %Warehouse.Warehouse_id_name{} = warehouse_id_name} <- Warehouse.update_warehouse_id_name(warehouse_id_name, %{"warehouse_id_name": warehouse_name, "warehouse_id": warehouse_id_name.warehouse_id}) do
      visibility = Enum.reject(socket.assigns.visibility, & &1 == id)
      warehouse_id_names = Enum.map(socket.assigns.warehouse_id_name, fn warehouse -> if warehouse.id == id, do: %{"warehouse_name": warehouse_name} |> Enum.into(warehouse), else: warehouse end)
      Logger.info(IO.inspect(warehouse_id_names))
      {:noreply, assign(socket, %{visibility:  visibility, warehouse_id_name: warehouse_id_names})}
    end
  end

# def handle_event("addRow", params, socket) do

#   to_delete = socket.assigns.toggle_ids
#   try do
#     for id <- to_delete do
#       warehouse_id_name = Warehouse.get_warehouse_id_name!(id)
#       Warehouse.delete_warehouse_id_name(warehouse_id_name)
#     end
#     warehouse_id_name = filter_warehouses(socket.assigns.warehouse_id_name, to_delete)
#     Logger.debug(IO.inspect(warehouse_id_name))
#     {:noreply, assign(socket, warehouse_id_name: warehouse_id_name, toggle_ids: [])}
#   catch
#     exit, __ ->
#     {:noreply, put_flash(socket, :error, "Id not found")}

#   end
# end

  def handle_event("select_change", %{"value" => value}, socket) do
    warehouse_id_names = socket.assigns.warehouse_id_name
    warehouse_id_name = Enum.filter(warehouse_id_names, fn warehouse -> warehouse.id == "new" end)
    key = Enum.filter(hd(warehouse_id_name).warehouse_id, fn warehouse_id -> warehouse_id[:value] == String.to_integer(value) end)
    warehouse_id_names_mod = Enum.map(warehouse_id_names, fn warehouse -> if warehouse.id == "new", do:  %{"warehouse_name": hd(key)[:key]} |> Enum.into(warehouse), else: warehouse end)
    {:noreply, assign(socket, warehouse_id_name: warehouse_id_names_mod)}
  end

  def handle_event("deleteRow", __params, socket) do

    to_delete = socket.assigns.toggle_ids
    Logger.debug(IO.inspect(to_delete))
    try do
      for id <- to_delete do
        if id != "new" do
          warehouse_id_name = Warehouse.get_warehouse_id_name!(id)
          Warehouse.delete_warehouse_id_name(warehouse_id_name)
        end
      end
      warehouse_id_name = filter_warehouses(socket.assigns.warehouse_id_name, to_delete)
      Logger.debug(IO.inspect(warehouse_id_name))
      {:noreply, assign(socket, warehouse_id_name: warehouse_id_name, toggle_ids: [])}
    catch
      exit, __ ->
      {:noreply, put_flash(socket, :error, "Id not found")}

    end
  end

  def handle_event("addRow",  %{"value" => value}, socket) do
    warehouse_id_name = socket.assigns.warehouse_id_name
    Logger.debug(IO.inspect(warehouse_id_name))
    if (warehouse_id_name != [] and List.last(warehouse_id_name).new) do
      {:noreply, put_flash(socket, :info, "New Row Already Exists. Fill that first to proceed")}
    else
      warehouse_ids_not_used = [ [key: "Warehouse ID", value: "new", hidden: true, selected: true] | Warehouse.list_warehouse_id_not_used() |> Enum.map(fn warehouse -> [key: warehouse.name_id, value: warehouse.id] end)]
      warehouse_id_name = warehouse_id_name ++ [%{warehouse_id: warehouse_ids_not_used, warehouse_name: "", id: "new", primary_key: "new", toggle: false, new: true}]
      visibility = [ "new" | socket.assigns.visibility]
      {:noreply, assign(socket, warehouse_id_name: warehouse_id_name, visibility: visibility)}
    end
  end

  defp filter_warehouses(warehouse_id_name, ids) do
    Enum.filter(warehouse_id_name, fn warehouse -> warehouse.id not in ids end)
  end
end
