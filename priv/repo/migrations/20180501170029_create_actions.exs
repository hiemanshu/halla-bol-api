defmodule HallaBol.Repo.Migrations.CreateActions do
  use Ecto.Migration

  def change do
    create table(:actions) do
      add :title, :string
      add :type, :string
      add :body_content, :string
      add :cta_text, :string
      add :button_text, :string
      add :extra_fields, :map
      add :current_count, :float
      add :max_count, :float
      add :campaign_id, references(:campaigns, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:actions, [:campaign_id])
  end
end
