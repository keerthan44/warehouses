defmodule Trial.WarehouseTest do
  use Trial.DataCase

  alias Trial.Warehouse

  describe "warehouse_id" do
    alias Trial.Warehouse.Warehouse_ids

    import Trial.WarehouseFixtures

    @invalid_attrs %{warehouse_id: nil}

    test "list_warehouse_id/0 returns all warehouse_id" do
      warehouse_ids = warehouse_ids_fixture()
      assert Warehouse.list_warehouse_id() == [warehouse_ids]
    end

    test "get_warehouse_ids!/1 returns the warehouse_ids with given id" do
      warehouse_ids = warehouse_ids_fixture()
      assert Warehouse.get_warehouse_ids!(warehouse_ids.id) == warehouse_ids
    end

    test "create_warehouse_ids/1 with valid data creates a warehouse_ids" do
      valid_attrs = %{warehouse_id: "some warehouse_id"}

      assert {:ok, %Warehouse_ids{} = warehouse_ids} = Warehouse.create_warehouse_ids(valid_attrs)
      assert warehouse_ids.warehouse_id == "some warehouse_id"
    end

    test "create_warehouse_ids/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_warehouse_ids(@invalid_attrs)
    end

    test "update_warehouse_ids/2 with valid data updates the warehouse_ids" do
      warehouse_ids = warehouse_ids_fixture()
      update_attrs = %{warehouse_id: "some updated warehouse_id"}

      assert {:ok, %Warehouse_ids{} = warehouse_ids} = Warehouse.update_warehouse_ids(warehouse_ids, update_attrs)
      assert warehouse_ids.warehouse_id == "some updated warehouse_id"
    end

    test "update_warehouse_ids/2 with invalid data returns error changeset" do
      warehouse_ids = warehouse_ids_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_warehouse_ids(warehouse_ids, @invalid_attrs)
      assert warehouse_ids == Warehouse.get_warehouse_ids!(warehouse_ids.id)
    end

    test "delete_warehouse_ids/1 deletes the warehouse_ids" do
      warehouse_ids = warehouse_ids_fixture()
      assert {:ok, %Warehouse_ids{}} = Warehouse.delete_warehouse_ids(warehouse_ids)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_warehouse_ids!(warehouse_ids.id) end
    end

    test "change_warehouse_ids/1 returns a warehouse_ids changeset" do
      warehouse_ids = warehouse_ids_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_warehouse_ids(warehouse_ids)
    end
  end

  describe "warehouse_id_name" do
    alias Trial.Warehouse.Warehouse_ids_name

    import Trial.WarehouseFixtures

    @invalid_attrs %{warehouse_id: nil, warehouse_name: nil}

    test "list_warehouse_id_name/0 returns all warehouse_id_name" do
      warehouse_ids_name = warehouse_ids_name_fixture()
      assert Warehouse.list_warehouse_id_name() == [warehouse_ids_name]
    end

    test "get_warehouse_ids_name!/1 returns the warehouse_ids_name with given id" do
      warehouse_ids_name = warehouse_ids_name_fixture()
      assert Warehouse.get_warehouse_ids_name!(warehouse_ids_name.id) == warehouse_ids_name
    end

    test "create_warehouse_ids_name/1 with valid data creates a warehouse_ids_name" do
      valid_attrs = %{warehouse_id: "some warehouse_id", warehouse_name: "some warehouse_name"}

      assert {:ok, %Warehouse_ids_name{} = warehouse_ids_name} = Warehouse.create_warehouse_ids_name(valid_attrs)
      assert warehouse_ids_name.warehouse_id == "some warehouse_id"
      assert warehouse_ids_name.warehouse_name == "some warehouse_name"
    end

    test "create_warehouse_ids_name/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_warehouse_ids_name(@invalid_attrs)
    end

    test "update_warehouse_ids_name/2 with valid data updates the warehouse_ids_name" do
      warehouse_ids_name = warehouse_ids_name_fixture()
      update_attrs = %{warehouse_id: "some updated warehouse_id", warehouse_name: "some updated warehouse_name"}

      assert {:ok, %Warehouse_ids_name{} = warehouse_ids_name} = Warehouse.update_warehouse_ids_name(warehouse_ids_name, update_attrs)
      assert warehouse_ids_name.warehouse_id == "some updated warehouse_id"
      assert warehouse_ids_name.warehouse_name == "some updated warehouse_name"
    end

    test "update_warehouse_ids_name/2 with invalid data returns error changeset" do
      warehouse_ids_name = warehouse_ids_name_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_warehouse_ids_name(warehouse_ids_name, @invalid_attrs)
      assert warehouse_ids_name == Warehouse.get_warehouse_ids_name!(warehouse_ids_name.id)
    end

    test "delete_warehouse_ids_name/1 deletes the warehouse_ids_name" do
      warehouse_ids_name = warehouse_ids_name_fixture()
      assert {:ok, %Warehouse_ids_name{}} = Warehouse.delete_warehouse_ids_name(warehouse_ids_name)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_warehouse_ids_name!(warehouse_ids_name.id) end
    end

    test "change_warehouse_ids_name/1 returns a warehouse_ids_name changeset" do
      warehouse_ids_name = warehouse_ids_name_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_warehouse_ids_name(warehouse_ids_name)
    end
  end

  describe "warehouse_id" do
    alias Trial.Warehouse.Warehouse_id

    import Trial.WarehouseFixtures

    @invalid_attrs %{warehouse_id: nil}

    test "list_warehouse_id/0 returns all warehouse_id" do
      warehouse_id = warehouse_id_fixture()
      assert Warehouse.list_warehouse_id() == [warehouse_id]
    end

    test "get_warehouse_id!/1 returns the warehouse_id with given id" do
      warehouse_id = warehouse_id_fixture()
      assert Warehouse.get_warehouse_id!(warehouse_id.id) == warehouse_id
    end

    test "create_warehouse_id/1 with valid data creates a warehouse_id" do
      valid_attrs = %{warehouse_id: "some warehouse_id"}

      assert {:ok, %Warehouse_id{} = warehouse_id} = Warehouse.create_warehouse_id(valid_attrs)
      assert warehouse_id.warehouse_id == "some warehouse_id"
    end

    test "create_warehouse_id/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_warehouse_id(@invalid_attrs)
    end

    test "update_warehouse_id/2 with valid data updates the warehouse_id" do
      warehouse_id = warehouse_id_fixture()
      update_attrs = %{warehouse_id: "some updated warehouse_id"}

      assert {:ok, %Warehouse_id{} = warehouse_id} = Warehouse.update_warehouse_id(warehouse_id, update_attrs)
      assert warehouse_id.warehouse_id == "some updated warehouse_id"
    end

    test "update_warehouse_id/2 with invalid data returns error changeset" do
      warehouse_id = warehouse_id_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_warehouse_id(warehouse_id, @invalid_attrs)
      assert warehouse_id == Warehouse.get_warehouse_id!(warehouse_id.id)
    end

    test "delete_warehouse_id/1 deletes the warehouse_id" do
      warehouse_id = warehouse_id_fixture()
      assert {:ok, %Warehouse_id{}} = Warehouse.delete_warehouse_id(warehouse_id)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_warehouse_id!(warehouse_id.id) end
    end

    test "change_warehouse_id/1 returns a warehouse_id changeset" do
      warehouse_id = warehouse_id_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_warehouse_id(warehouse_id)
    end
  end

  describe "warehouse_id_name" do
    alias Trial.Warehouse.Warehouse_id_name

    import Trial.WarehouseFixtures

    @invalid_attrs %{warehouse_id: nil, warehouse_id_name: nil}

    test "list_warehouse_id_name/0 returns all warehouse_id_name" do
      warehouse_id_name = warehouse_id_name_fixture()
      assert Warehouse.list_warehouse_id_name() == [warehouse_id_name]
    end

    test "get_warehouse_id_name!/1 returns the warehouse_id_name with given id" do
      warehouse_id_name = warehouse_id_name_fixture()
      assert Warehouse.get_warehouse_id_name!(warehouse_id_name.id) == warehouse_id_name
    end

    test "create_warehouse_id_name/1 with valid data creates a warehouse_id_name" do
      valid_attrs = %{warehouse_id: "some warehouse_id", warehouse_id_name: "some warehouse_id_name"}

      assert {:ok, %Warehouse_id_name{} = warehouse_id_name} = Warehouse.create_warehouse_id_name(valid_attrs)
      assert warehouse_id_name.warehouse_id == "some warehouse_id"
      assert warehouse_id_name.warehouse_id_name == "some warehouse_id_name"
    end

    test "create_warehouse_id_name/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Warehouse.create_warehouse_id_name(@invalid_attrs)
    end

    test "update_warehouse_id_name/2 with valid data updates the warehouse_id_name" do
      warehouse_id_name = warehouse_id_name_fixture()
      update_attrs = %{warehouse_id: "some updated warehouse_id", warehouse_id_name: "some updated warehouse_id_name"}

      assert {:ok, %Warehouse_id_name{} = warehouse_id_name} = Warehouse.update_warehouse_id_name(warehouse_id_name, update_attrs)
      assert warehouse_id_name.warehouse_id == "some updated warehouse_id"
      assert warehouse_id_name.warehouse_id_name == "some updated warehouse_id_name"
    end

    test "update_warehouse_id_name/2 with invalid data returns error changeset" do
      warehouse_id_name = warehouse_id_name_fixture()
      assert {:error, %Ecto.Changeset{}} = Warehouse.update_warehouse_id_name(warehouse_id_name, @invalid_attrs)
      assert warehouse_id_name == Warehouse.get_warehouse_id_name!(warehouse_id_name.id)
    end

    test "delete_warehouse_id_name/1 deletes the warehouse_id_name" do
      warehouse_id_name = warehouse_id_name_fixture()
      assert {:ok, %Warehouse_id_name{}} = Warehouse.delete_warehouse_id_name(warehouse_id_name)
      assert_raise Ecto.NoResultsError, fn -> Warehouse.get_warehouse_id_name!(warehouse_id_name.id) end
    end

    test "change_warehouse_id_name/1 returns a warehouse_id_name changeset" do
      warehouse_id_name = warehouse_id_name_fixture()
      assert %Ecto.Changeset{} = Warehouse.change_warehouse_id_name(warehouse_id_name)
    end
  end
end
