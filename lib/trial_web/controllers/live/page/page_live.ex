defmodule TrialWeb.PageLive do
  use TrialWeb, :live_view

  import Phoenix.HTML.Form

  alias Trial.Warehouse
  require IO
  require Logger

  def mount(_params, _session, socket) do
    # On intial render, it gets all the available warehouse id names with the warehouse_ids joined

    warehouse_id_name = Warehouse.list_warehouse_id_name_joined()
    warehouse_id_name = Enum.map(warehouse_id_name, fn warehouse ->  %{"warehouse_id": %{warehouse.warehouse_id => warehouse.primary_key},"new": false, toggle: false} |> Enum.into(warehouse) end)
    Logger.info(IO.inspect(warehouse_id_name))

    {:ok, assign(socket, warehouse_id_name: warehouse_id_name, toggle_ids: [], visibility: [])}
  end

  def handle_event("checkAll", %{"value" => "on"}, socket) do
    # checks all textboxes to all

    toggle_ids = socket.assigns.warehouse_id_name |> Enum.map(& &1.id)
    {:noreply, assign(socket, :toggle_ids, toggle_ids)}
  end

  def handle_event("checkAll", %{}, socket) do
    # checks all textboxes to off

    {:noreply, assign(socket, :toggle_ids, [])}
  end

  def handle_event("table_data_checkboxes", %{"toggle-id" => id}, socket) do
    # used for checking each individual checkbox and keeping track of it

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
    # makes the input field for changing warehouse name visible or invisible

    id = String.to_integer(id)
    visbility = Enum.reject(socket.assigns.visibility, & &1 == id)
    {:noreply, assign(socket, :visibility, [id | socket.assigns.visibility])}
  end

  def handle_event("reset", %{"id" => id}, socket) do
    # reverts back any changes(if any) made to the warehouse name

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
    # Creates a new warehouse name and applies the necessary changes to the state variables

    warehouse_id_name_params = %{ "warehouse_id_name" => warehouse_name, "warehouse_id" => warehouse_id}
    with {:ok, %Warehouse.Warehouse_id_name{} = warehouse} <- Warehouse.create_warehouse_id_name(warehouse_id_name_params) do
      warehouse_id_name_mod = %{"warehouse_id": %{warehouse_name => warehouse_id},  warehouse_name: warehouse_name, id: warehouse.id, primary_key: warehouse_id, "new": false, toggle: false}
      Logger.info(IO.inspect(warehouse_id_name_mod))
      warehouse_id_name = Enum.map(socket.assigns.warehouse_id_name, fn warehouse -> if warehouse.id == "new", do: warehouse_id_name_mod |> Enum.into(warehouse), else: warehouse end)
      visibility = Enum.reject(socket.assigns.visibility, & &1 == id)
      toggle_ids = Enum.map(socket.assigns.toggle_ids, fn id -> if id == "new", do: warehouse.id, else: id end)
      {:noreply, socket
      |> put_flash(:info, "Successfully Created")
      |> assign(%{visibility:  visibility, warehouse_id_name: warehouse_id_name, toggle_ids: toggle_ids})}
    end
  end

  def handle_event("update", %{"warehouse_name" => warehouse_name, "id" => id}, socket) do
    #updates existing entry in the database

    id = String.to_integer(id)
    warehouse_id_name = Warehouse.get_warehouse_id_name!(id)

    with {:ok, %Warehouse.Warehouse_id_name{} = warehouse_id_name} <- Warehouse.update_warehouse_id_name(warehouse_id_name, %{"warehouse_id_name": warehouse_name, "warehouse_id": warehouse_id_name.warehouse_id}) do
      visibility = Enum.reject(socket.assigns.visibility, & &1 == id)
      warehouse_id_names = Enum.map(socket.assigns.warehouse_id_name, fn warehouse -> if warehouse.id == id, do: %{"warehouse_name": warehouse_name} |> Enum.into(warehouse), else: warehouse end)
      Logger.info(IO.inspect(warehouse_id_names))
      {:noreply, socket
      |> put_flash(:info, "Successfully Updated")
      |> assign(%{visibility:  visibility, warehouse_id_name: warehouse_id_names})}
    end
  end

  def handle_event("select_change", %{"value" => value}, socket) do
    # used for copying the value from the select field to the input field

    warehouse_id_names = socket.assigns.warehouse_id_name
    warehouse_id_name = Enum.filter(warehouse_id_names, fn warehouse -> warehouse.id == "new" end)
    key = Enum.filter(hd(warehouse_id_name).warehouse_id, fn warehouse_id -> warehouse_id[:value] == if value != "new", do: String.to_integer(value), else: "new" end)
    warehouse_id_names_mod = Enum.map(warehouse_id_names, fn warehouse -> if warehouse.id == "new", do:  %{"warehouse_name": hd(key)[:key]} |> Enum.into(warehouse), else: warehouse end)
    {:noreply, assign(socket, warehouse_id_name: warehouse_id_names_mod)}
  end

  def handle_event("deleteRow", __params, socket) do
    # used for delting row from table as well as database

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
      {:noreply, socket
      |> put_flash(:info, "Successfully Deleted")
      |> assign(warehouse_id_name: warehouse_id_name, toggle_ids: [])}
    catch
      exit, __ ->
      {:noreply, put_flash(socket, :error, "Id not found")}

    end
  end

  def handle_event("addRow",  %{"value" => value}, socket) do
    # used for creating a new row[Frontend Only]

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
