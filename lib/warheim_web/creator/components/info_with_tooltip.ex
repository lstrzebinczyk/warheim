defmodule Creator.Components.InfoWithTooltip do
  use WarheimWeb, :live_component

  # Accepts a single tooltip param
  def render(assigns) do
    ~L"""
      <i class="bi bi-info-circle x-tooltip">
        <span class="x-tooltip-text">
          <%= raw to_html(@tooltip) %>
        </span>
      </i>
    """
  end

  defp to_html(markdown_text) do
    {:ok, html_doc, _deprecation_messages} = Earmark.as_html(markdown_text)
    html_doc
  end
end
