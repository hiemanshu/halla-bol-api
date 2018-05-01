defmodule HallaBolWeb.CampaignView do
  use HallaBolWeb, :view
  alias HallaBolWeb.CampaignView

  def render("index.json", %{campaigns: campaigns}) do
    %{campaigns: render_many(campaigns, CampaignView, "campaign.json")}
  end

  def render("show.json", %{campaign: campaign}) do
    render_one(campaign, CampaignView, "campaign.json")
  end

  def render("campaign.json", %{campaign: campaign}) do
    %{name: campaign.name,
      intro: campaign.intro,
      live: campaign.live,
      slug: campaign.slug,
      featured: campaign.featured}
  end
end
