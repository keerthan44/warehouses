defmodule TrialWeb.Warehouse_ids_nameControllerTest do
  use TrialWeb.ConnCase

  import Trial.WarehouseFixtures

  alias Trial.Warehouse.Warehouse_ids_name

  @create_attrs %{
    warehouse_id: "some warehouse_id",
    warehouse_name: "some warehouse_name"
  }
  @update_attrs %{
    warehouse_id: "some updated warehouse_id",
    warehouse_name: "some updated warehouse_name"
  }
  @invalid_attrs %{warehouse_id: nil, warehouse_name: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all warehouse_id_name", %{conn: conn} do
      conn = get(conn, ~p"/api/warehouse_id_name")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create warehouse_ids_name" do
    test "renders warehouse_ids_name when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/warehouse_id_name", warehouse_ids_name: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/warehouse_id_name/#{id}")

      assert %{
               "id" => ^id,
               "warehouse_id" => "some warehouse_id",
               "warehouse_name" => "some warehouse_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/warehouse_id_name", warehouse_ids_name: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update warehouse_ids_name" do
    setup [:create_warehouse_ids_name]

    test "renders warehouse_ids_name when data is valid", %{conn: conn, warehouse_ids_name: %Warehouse_ids_name{id: id} = warehouse_ids_name} do
      conn = put(conn, ~p"/api/warehouse_id_name/#{warehouse_ids_name}", warehouse_ids_name: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/warehouse_id_name/#{id}")

      assert %{
               "id" => ^id,
               "warehouse_id" => "some updated warehouse_id",
               "warehouse_name" => "some updated warehouse_name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, warehouse_ids_name: warehouse_ids_name} do
      conn = put(conn, ~p"/api/warehouse_id_name/#{warehouse_ids_name}", warehouse_ids_name: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete warehouse_ids_name" do
    setup [:create_warehouse_ids_name]

    test "deletes chosen warehouse_ids_name", %{conn: conn, warehouse_ids_name: warehouse_ids_name} do
      conn = delete(conn, ~p"/api/warehouse_id_name/#{warehouse_ids_name}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/warehouse_id_name/#{warehouse_ids_name}")
      end
    end
  end

  defp create_warehouse_ids_name(_) do
    warehouse_ids_name = warehouse_ids_name_fixture()
    %{warehouse_ids_name: warehouse_ids_name}
  end
end
