defmodule Trial.Repo.Migrations.CreateWarehouseId do
  use Ecto.Migration

  def change do
    create table(:warehouse_id) do
      add :warehouse_id, :string

      timestamps()
    end
      create unique_index(:warehouse_id, [:id])

  end
end
