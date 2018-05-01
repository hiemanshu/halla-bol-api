defmodule HallaBolWeb.ActionView do
  use HallaBolWeb, :view
  alias HallaBolWeb.ActionView

  def render("show.json", %{action: action}) do
    render_one(action, ActionView, "action.json")
  end

  def render("action.json", %{action: action}) do
    %{id: action.id,
      title: action.title,
      type: action.type,
      body_content: action.body_content,
      cta_text: action.cta_text,
      button_text: action.button_text,
      extra_fields: action.extra_fields,
      current_count: action.current_count,
      max_count: action.max_count}
  end
end
