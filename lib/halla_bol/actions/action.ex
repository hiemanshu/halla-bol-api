defmodule HallaBol.Actions.Action do
  use Ecto.Schema
  import Ecto.Changeset


  schema "actions" do
    field :body_content, :string
    field :button_text, :string
    field :cta_text, :string
    field :current_count, :float
    field :extra_fields, :map
    field :max_count, :float
    field :title, :string
    field :type, :string
    field :campaign_id, :id

    timestamps()
  end

  @doc false
  def changeset(action, attrs) do
    action
    |> cast(attrs, [:title, :type, :body_content, :cta_text, :button_text, :extra_fields, :current_count, :max_count, :campaign_id])
    |> validate_required([:title, :type, :body_content, :campaign_id])
  end
end
