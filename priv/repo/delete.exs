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


Repo.delete_all("warehouse_id")
Repo.delete_all("warehouse_id_name")
