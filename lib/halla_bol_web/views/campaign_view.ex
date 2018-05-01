defmodule HallaBolWeb.CampaignView do
  use HallaBolWeb, :view
  alias HallaBolWeb.CampaignView

  def render("index.json", %{campaigns: campaigns}) do
    %{campaigns: render_many(campaigns, CampaignView, "campaign.json")}
  end

  def render("show.json", %{campaign: campaign}) do
    Map.merge(
      render_one(campaign, CampaignView, "campaign.json"),
      %{
        actions: render_many(campaign.actions, HallaBolWeb.ActionView, "action.json"),
        id: campaign.id
      }
    )
  end

  def render("campaign.json", %{campaign: campaign}) do
    %{name: campaign.name,
      description: campaign.description,
      image: campaign.image,
      live: campaign.live,
      slug: campaign.slug,
      featured: campaign.featured}
  end
end
