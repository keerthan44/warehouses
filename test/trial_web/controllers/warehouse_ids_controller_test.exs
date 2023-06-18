defmodule TrialWeb.Warehouse_idsControllerTest do
  use TrialWeb.ConnCase

  import Trial.WarehouseFixtures

  alias Trial.Warehouse.Warehouse_ids

  @create_attrs %{
    warehouse_id: "some warehouse_id"
  }
  @update_attrs %{
    warehouse_id: "some updated warehouse_id"
  }
  @invalid_attrs %{warehouse_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all warehouse_id", %{conn: conn} do
      conn = get(conn, ~p"/api/warehouse_id")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create warehouse_ids" do
    test "renders warehouse_ids when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/warehouse_id", warehouse_ids: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/warehouse_id/#{id}")

      assert %{
               "id" => ^id,
               "warehouse_id" => "some warehouse_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/warehouse_id", warehouse_ids: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update warehouse_ids" do
    setup [:create_warehouse_ids]

    test "renders warehouse_ids when data is valid", %{conn: conn, warehouse_ids: %Warehouse_ids{id: id} = warehouse_ids} do
      conn = put(conn, ~p"/api/warehouse_id/#{warehouse_ids}", warehouse_ids: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/warehouse_id/#{id}")

      assert %{
               "id" => ^id,
               "warehouse_id" => "some updated warehouse_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, warehouse_ids: warehouse_ids} do
      conn = put(conn, ~p"/api/warehouse_id/#{warehouse_ids}", warehouse_ids: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete warehouse_ids" do
    setup [:create_warehouse_ids]

    test "deletes chosen warehouse_ids", %{conn: conn, warehouse_ids: warehouse_ids} do
      conn = delete(conn, ~p"/api/warehouse_id/#{warehouse_ids}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/warehouse_id/#{warehouse_ids}")
      end
    end
  end

  defp create_warehouse_ids(_) do
    warehouse_ids = warehouse_ids_fixture()
    %{warehouse_ids: warehouse_ids}
  end
end
