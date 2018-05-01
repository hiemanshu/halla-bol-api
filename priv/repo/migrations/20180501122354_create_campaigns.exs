defmodule HallaBol.Repo.Migrations.CreateCampaigns do
  use Ecto.Migration

  def change do
    create table(:campaigns) do
      add :name, :string
      add :intro, :text
      add :live, :boolean, default: false, null: false
      add :slug, :string
      add :featured, :boolean, default: false, null: false

      timestamps()
    end

  end
end
