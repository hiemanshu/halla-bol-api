defmodule HallaBolWeb.ActionControllerTest do
  use HallaBolWeb.ConnCase

  alias HallaBol.Actions
  alias HallaBol.Actions.Action

  @create_attrs %{body_content: "some body_content", button_text: "some button_text", cta_text: "some cta_text", current_count: 120.5, extra_fields: %{}, max_count: 120.5, title: "some title", type: "some type"}
  @update_attrs %{body_content: "some updated body_content", button_text: "some updated button_text", cta_text: "some updated cta_text", current_count: 456.7, extra_fields: %{}, max_count: 456.7, title: "some updated title", type: "some updated type"}
  @invalid_attrs %{body_content: nil, button_text: nil, cta_text: nil, current_count: nil, extra_fields: nil, max_count: nil, title: nil, type: nil}

  def fixture(:action) do
    {:ok, action} = Actions.create_action(@create_attrs)
    action
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all actions", %{conn: conn} do
      conn = get conn, action_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create action" do
    test "renders action when data is valid", %{conn: conn} do
      conn = post conn, action_path(conn, :create), action: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, action_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body_content" => "some body_content",
        "button_text" => "some button_text",
        "cta_text" => "some cta_text",
        "current_count" => 120.5,
        "extra_fields" => %{},
        "max_count" => 120.5,
        "title" => "some title",
        "type" => "some type"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, action_path(conn, :create), action: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update action" do
    setup [:create_action]

    test "renders action when data is valid", %{conn: conn, action: %Action{id: id} = action} do
      conn = put conn, action_path(conn, :update, action), action: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, action_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "body_content" => "some updated body_content",
        "button_text" => "some updated button_text",
        "cta_text" => "some updated cta_text",
        "current_count" => 456.7,
        "extra_fields" => %{},
        "max_count" => 456.7,
        "title" => "some updated title",
        "type" => "some updated type"}
    end

    test "renders errors when data is invalid", %{conn: conn, action: action} do
      conn = put conn, action_path(conn, :update, action), action: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete action" do
    setup [:create_action]

    test "deletes chosen action", %{conn: conn, action: action} do
      conn = delete conn, action_path(conn, :delete, action)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, action_path(conn, :show, action)
      end
    end
  end

  defp create_action(_) do
    action = fixture(:action)
    {:ok, action: action}
  end
end
