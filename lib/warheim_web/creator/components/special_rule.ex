defmodule Creator.Components.SpecialRule do
  use Surface.Component

  prop special_rule_id, :string, required: true
  data special_rule, :any

  def update(%{special_rule_id: special_rule_id}, socket) do
    special_rule = Warheim.Rules.SpecialRule.find(special_rule_id)

    case special_rule do
      nil ->
        raise "Special rule '#{special_rule_id}' not found during render"

      _ ->
        socket =
          socket
            |> assign(:special_rule, special_rule)
        {:ok, socket}
    end
  end

  def render(assigns) do
    ~H"""
      <span>
        {{ @special_rule.name }}
        <Creator.Components.InfoWithTooltip tooltip={{@special_rule.description}} />
      </span>
    """
  end
end
