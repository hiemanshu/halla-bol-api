defmodule HallaBol.Repo.Migrations.AddMoreColumnsToCampaign do
  use Ecto.Migration

  def change do
    alter table("campaigns") do
      add :image, :string
    end

    rename table("campaigns"), :intro, to: :description
  end
end
