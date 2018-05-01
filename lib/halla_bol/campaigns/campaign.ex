defmodule HallaBol.Campaigns.Campaign do
  use Ecto.Schema
  import Ecto.Changeset

  schema "campaigns" do
    field :featured, :boolean, default: false
    field :description, :string
    field :live, :boolean, default: false
    field :name, :string
    field :slug, :string
    field :image, :string

    timestamps()
  end

  @doc false
  def changeset(campaign, attrs) do
    campaign
    |> cast(attrs, [:name, :description, :live, :slug, :featured, :image])
    |> validate_required([:name, :description, :live, :slug, :featured])
    |> unique_constraint(:slug)
    |> validate_url(:image)
  end

  defp validate_url(changeset, field, opts \\ []) do
    validate_change changeset, field, fn _, value ->
      case URI.parse(value) do
        %URI{scheme: nil} -> "is missing a scheme (e.g. https)"
        %URI{host: nil} -> "is missing a host"
        %URI{host: host} ->
          case :inet.gethostbyname(Kernel.to_charlist host) do
            {:ok, _} -> nil
            {:error, _} -> "invalid host"
          end
      end
      |> case do
           error when is_binary(error) -> [{field, Keyword.get(opts, :message, error)}]
           _ -> []
         end
    end
  end
end
