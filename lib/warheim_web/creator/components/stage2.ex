defmodule Creator.Components.Stage2 do
  use WarheimWeb, :live_component

  def mount(params, _session, socket) do
    IO.inspect({"params yo", params})

    {:ok, socket}
  end

  # def update(%{state: state}, socket) do
  #   band_type = Warheim.Rules.Band.find(state.band_type_id)
  #   IO.inspect({"assigns", assigns, socket})
  #   {:ok, socket}
  # end

  def render(assigns) do
    ~L"""
    <div class="row">
      <div class="col-4">
        <h2><%= band_type_name(@state) %></h2>
        <div>Natura: <%= band_alignment_name(@state) %></div>
        <br>
        <div>
          <div>Specjalne zasady: </div>
          <%= for special_rule <- special_rules(@state) do %>
            <div style="margin-left: 10px;">
              <%= special_rule.name %>
              <i
                class="bi bi-info-circle"
                data-bs-toggle="tooltip"
                data-bs-html="true"
                data-bs-placement="right"
                title="<%= to_html(special_rule.description) %>"
                >
              </i>
            </div>
          <% end %>
        </div>
      </div>
      <div class="col">
        main page
      </div>
    </div>
    """
  end

  defp to_html(markdown_text) do
    {:ok, html_doc, _deprecation_messages} = Earmark.as_html(markdown_text)
    html_doc
  end

  defp band_type_name(%Creator.State{band_type_id: band_type_id}) do
    band(band_type_id).name
  end

  defp band_alignment_name(%Creator.State{band_type_id: band_type_id}) do
    alignment_id = band(band_type_id).alignment_id
    Warheim.Rules.Alignment.find(alignment_id).name
  end

  defp special_rules(%Creator.State{band_type_id: band_type_id}) do
    band(band_type_id).special_rule_ids
    |> Enum.map(fn special_rule_id ->
      Warheim.Rules.SpecialRule.find(special_rule_id)
    end)
  end

  defp band(band_type_id) do
    Warheim.Rules.Band.find(band_type_id)
  end
end
