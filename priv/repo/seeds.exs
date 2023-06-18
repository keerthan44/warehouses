# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Trial.Repo.insert!(%Trial.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Trial.Repo
alias Trial.Warehouse



Warehouse.create_warehouse_id(%{warehouse_id: "BCMR1010"})
Warehouse.create_warehouse_id(%{warehouse_id: "BCMR1011"})
Warehouse.create_warehouse_id(%{warehouse_id: "BCMR1012"})

Warehouse.create_warehouse_id_name(%{warehouse_id: 20, warehouse_name: "BCMR1010-Manual"})
Warehouse.create_warehouse_id_name(%{warehouse_id: 22, warehouse_name: "BCMR1010-Manual"})
