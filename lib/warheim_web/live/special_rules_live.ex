defmodule WarheimWeb.SpecialRulesLive do
  use WarheimWeb, :live_view

  # def mount(%{"id" => id}, _session, socket) do
  #   socket =
  #     socket
  #     |> assign(:id, id)
  #     |> assign(:special_rule, Warheim.Rules.SpecialRule.find(id))

  #   {:ok, socket}
  # end

  def mount(_, _, socket), do: {:ok, socket}

  def handle_params(%{"id" => id}, url, socket) do
    socket =
      socket
      |> assign(:id, id)
      |> assign(:special_rule, Warheim.Rules.SpecialRule.find(id))

    {:noreply, socket}
  end

  def handle_params(_, _, socket), do: {:noreply, socket}

  def all_special_rules do
    Warheim.Rules.SpecialRule.all() |> Enum.sort(fn (rule1, rule2) -> rule1.name <= rule2.name end)
  end

  defp to_html(markdown_text) do
    {:ok, html_doc, _deprecation_messages} = Earmark.as_html(markdown_text)
    html_doc
  end
end
