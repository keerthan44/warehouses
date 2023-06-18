defmodule TrialWeb.Warehouse_idControllerTest do
  use TrialWeb.ConnCase

  import Trial.WarehouseFixtures

  alias Trial.Warehouse.Warehouse_id

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

  describe "create warehouse_id" do
    test "renders warehouse_id when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/warehouse_id", warehouse_id: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/warehouse_id/#{id}")

      assert %{
               "id" => ^id,
               "warehouse_id" => "some warehouse_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/warehouse_id", warehouse_id: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update warehouse_id" do
    setup [:create_warehouse_id]

    test "renders warehouse_id when data is valid", %{conn: conn, warehouse_id: %Warehouse_id{id: id} = warehouse_id} do
      conn = put(conn, ~p"/api/warehouse_id/#{warehouse_id}", warehouse_id: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/warehouse_id/#{id}")

      assert %{
               "id" => ^id,
               "warehouse_id" => "some updated warehouse_id"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, warehouse_id: warehouse_id} do
      conn = put(conn, ~p"/api/warehouse_id/#{warehouse_id}", warehouse_id: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete warehouse_id" do
    setup [:create_warehouse_id]

    test "deletes chosen warehouse_id", %{conn: conn, warehouse_id: warehouse_id} do
      conn = delete(conn, ~p"/api/warehouse_id/#{warehouse_id}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/warehouse_id/#{warehouse_id}")
      end
    end
  end

  defp create_warehouse_id(_) do
    warehouse_id = warehouse_id_fixture()
    %{warehouse_id: warehouse_id}
  end
end
