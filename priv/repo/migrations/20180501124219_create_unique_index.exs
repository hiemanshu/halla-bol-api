defmodule HallaBol.Repo.Migrations.CreateUniqueIndex do
  use Ecto.Migration

  def change do
    create index("campaigns", [:slug], unique: true)
  end
end
