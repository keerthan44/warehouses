defmodule Trial.Repo.Migrations.CreateWarehouseIdName do
  use Ecto.Migration

  def change do
    create table(:warehouse_id_name) do
      add :warehouse_id, references(:warehouse_id, on_delete: :delete_all)
      add :warehouse_id_name, :string

      timestamps()
    end
  end
end
