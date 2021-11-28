# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ApplicationTracking.Repo.insert!(%ApplicationTracking.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


ApplicationTracking.Accounts.register_user(%{ password: "rKMTxtAkf7F29aU", email: "odeyinkao@yahoo.com"})
