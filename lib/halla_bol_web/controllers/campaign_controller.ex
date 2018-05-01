defmodule HallaBolWeb.CampaignController do
  use HallaBolWeb, :controller

  alias HallaBol.Campaigns
  alias HallaBol.Campaigns.Campaign

  action_fallback HallaBolWeb.FallbackController

  def index(conn, _params) do
    campaigns = Campaigns.list_campaigns()
    render(conn, "index.json", campaigns: campaigns)
  end

  def create(conn, %{"campaign" => campaign_params}) do
    with {:ok, %Campaign{} = campaign} <- Campaigns.create_campaign(campaign_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", campaign_path(conn, :show, campaign))
      |> render("show.json", campaign: campaign)
    end
  end

  def show(conn, %{"slug" => slug}) do
    campaign = Campaigns.get_campaign!(slug)
    render(conn, "show.json", campaign: campaign)
  end

  def update(conn, %{"id" => id, "campaign" => campaign_params}) do
    campaign = Campaigns.get_campaign!(id)

    with {:ok, %Campaign{} = campaign} <- Campaigns.update_campaign(campaign, campaign_params) do
      render(conn, "show.json", campaign: campaign)
    end
  end

  def delete(conn, %{"id" => id}) do
    campaign = Campaigns.get_campaign!(id)
    with {:ok, %Campaign{}} <- Campaigns.delete_campaign(campaign) do
      send_resp(conn, :no_content, "")
    end
  end
end
