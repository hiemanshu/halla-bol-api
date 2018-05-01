defmodule HallaBolWeb.ActionController do
  use HallaBolWeb, :controller

  alias HallaBol.Campaigns

  alias HallaBol.Actions
  alias HallaBol.Actions.Action

  action_fallback HallaBolWeb.FallbackController

  def index(conn, _params, _) do
    actions = Actions.list_actions()
    render(conn, "index.json", actions: actions)
  end

  def create(conn, %{"action" => action_params}) do
    with {:ok, %Action{} = action} <- Actions.create_action(action_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", campaign_action_path(conn, :show, action.campaign_id, action))
      |> render("show.json", action: action)
    end
  end

  def show(conn, %{"id" => id}) do
    action = Actions.get_action!(id)
    render(conn, "show.json", action: action)
  end

  def update(conn, %{"id" => id, "action" => action_params}, _) do
    action = Actions.get_action!(id)

    with {:ok, %Action{} = action} <- Actions.update_action(action, action_params) do
      render(conn, "show.json", action: action)
    end
  end

  def delete(conn, %{"id" => id}, _) do
    action = Actions.get_action!(id)
    with {:ok, %Action{}} <- Actions.delete_action(action) do
      send_resp(conn, :no_content, "")
    end
  end
end
