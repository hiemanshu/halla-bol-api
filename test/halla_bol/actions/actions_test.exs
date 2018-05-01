defmodule HallaBol.ActionsTest do
  use HallaBol.DataCase

  alias HallaBol.Actions

  describe "actions" do
    alias HallaBol.Actions.Action

    @valid_attrs %{body_content: "some body_content", button_text: "some button_text", cta_text: "some cta_text", current_count: 120.5, extra_fields: %{}, max_count: 120.5, title: "some title", type: "some type"}
    @update_attrs %{body_content: "some updated body_content", button_text: "some updated button_text", cta_text: "some updated cta_text", current_count: 456.7, extra_fields: %{}, max_count: 456.7, title: "some updated title", type: "some updated type"}
    @invalid_attrs %{body_content: nil, button_text: nil, cta_text: nil, current_count: nil, extra_fields: nil, max_count: nil, title: nil, type: nil}

    def action_fixture(attrs \\ %{}) do
      {:ok, action} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Actions.create_action()

      action
    end

    test "list_actions/0 returns all actions" do
      action = action_fixture()
      assert Actions.list_actions() == [action]
    end

    test "get_action!/1 returns the action with given id" do
      action = action_fixture()
      assert Actions.get_action!(action.id) == action
    end

    test "create_action/1 with valid data creates a action" do
      assert {:ok, %Action{} = action} = Actions.create_action(@valid_attrs)
      assert action.body_content == "some body_content"
      assert action.button_text == "some button_text"
      assert action.cta_text == "some cta_text"
      assert action.current_count == 120.5
      assert action.extra_fields == %{}
      assert action.max_count == 120.5
      assert action.title == "some title"
      assert action.type == "some type"
    end

    test "create_action/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Actions.create_action(@invalid_attrs)
    end

    test "update_action/2 with valid data updates the action" do
      action = action_fixture()
      assert {:ok, action} = Actions.update_action(action, @update_attrs)
      assert %Action{} = action
      assert action.body_content == "some updated body_content"
      assert action.button_text == "some updated button_text"
      assert action.cta_text == "some updated cta_text"
      assert action.current_count == 456.7
      assert action.extra_fields == %{}
      assert action.max_count == 456.7
      assert action.title == "some updated title"
      assert action.type == "some updated type"
    end

    test "update_action/2 with invalid data returns error changeset" do
      action = action_fixture()
      assert {:error, %Ecto.Changeset{}} = Actions.update_action(action, @invalid_attrs)
      assert action == Actions.get_action!(action.id)
    end

    test "delete_action/1 deletes the action" do
      action = action_fixture()
      assert {:ok, %Action{}} = Actions.delete_action(action)
      assert_raise Ecto.NoResultsError, fn -> Actions.get_action!(action.id) end
    end

    test "change_action/1 returns a action changeset" do
      action = action_fixture()
      assert %Ecto.Changeset{} = Actions.change_action(action)
    end
  end
end
