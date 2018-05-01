defmodule HallaBolWeb.CampaignControllerTest do
  use HallaBolWeb.ConnCase

  alias HallaBol.Campaigns
  alias HallaBol.Campaigns.Campaign

  @create_attrs %{featured: true, intro: "some intro", live: true, name: "some name", slug: "some slug"}
  @update_attrs %{featured: false, intro: "some updated intro", live: false, name: "some updated name", slug: "some updated slug"}
  @invalid_attrs %{featured: nil, intro: nil, live: nil, name: nil, slug: nil}

  def fixture(:campaign) do
    {:ok, campaign} = Campaigns.create_campaign(@create_attrs)
    campaign
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all campaigns", %{conn: conn} do
      conn = get conn, campaign_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create campaign" do
    test "renders campaign when data is valid", %{conn: conn} do
      conn = post conn, campaign_path(conn, :create), campaign: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, campaign_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "featured" => true,
        "intro" => "some intro",
        "live" => true,
        "name" => "some name",
        "slug" => "some slug"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, campaign_path(conn, :create), campaign: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update campaign" do
    setup [:create_campaign]

    test "renders campaign when data is valid", %{conn: conn, campaign: %Campaign{id: id} = campaign} do
      conn = put conn, campaign_path(conn, :update, campaign), campaign: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, campaign_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "featured" => false,
        "intro" => "some updated intro",
        "live" => false,
        "name" => "some updated name",
        "slug" => "some updated slug"}
    end

    test "renders errors when data is invalid", %{conn: conn, campaign: campaign} do
      conn = put conn, campaign_path(conn, :update, campaign), campaign: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete campaign" do
    setup [:create_campaign]

    test "deletes chosen campaign", %{conn: conn, campaign: campaign} do
      conn = delete conn, campaign_path(conn, :delete, campaign)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, campaign_path(conn, :show, campaign)
      end
    end
  end

  defp create_campaign(_) do
    campaign = fixture(:campaign)
    {:ok, campaign: campaign}
  end
end
