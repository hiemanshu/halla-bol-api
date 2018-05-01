defmodule HallaBol.Campaigns.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campaigns" do
    field :featured, :boolean, default: false
    field :intro, :string
    field :live, :boolean, default: false
    field :name, :string
    field :slug, :string

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :intro, :live, :slug, :featured])
    |> validate_required([:name, :intro, :live, :slug, :featured])
    |> unique_constraint(:slug)
  end
end
