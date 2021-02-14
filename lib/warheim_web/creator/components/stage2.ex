defmodule Creator.Components.Stage2 do
  use WarheimWeb, :live_component

  def update(%{state: state}, socket) do
    socket =
      socket
        |> assign(:state, state)
        # |> assign(:is_new_unit_modal_opened, false)
        |> assign(:is_new_unit_modal_opened, true)

    {:ok, socket}
  end

  def handle_event("open-new-unit-modal", _, %{assigns: %{state: state}} = socket) do
    socket =
      socket
        |> assign(:is_new_unit_modal_opened, true)

    {:noreply, socket}
  end

  def handle_event("close-new-unit-modal", _, %{assigns: %{state: state}} = socket) do
    socket =
      socket
        |> assign(:is_new_unit_modal_opened, false)

    {:noreply, socket}
  end

  def render(assigns) do
    ~L"""
    <div class="row">
      <div class="col-4">
        <h2><%= band_type_name(@state) %></h2>
        <div>
          Natura: <%= band_alignment_name(@state) %>
        </div>
        <br>
        <div>
          <div>Zasady Specjalne: </div>
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
        <br>
        <div>
          Rozmiar bandy: <%= band_size(@state) %> modeli
        </div>
      </div>
      <div class="col">
        <button type="button" phx-target="<%= @myself %>" phx-click="open-new-unit-modal">
          Dodaj jednostkę
        </button>
      </div>
        <%= if @is_new_unit_modal_opened do %>
          <div class="x-modal-background" phx-target="<%= @myself %>" phx-click="close-new-unit-modal"></div>
          <div class="x-modal">
            <div class="x-modal-content">
              <span class="close" phx-target="<%= @myself %>" phx-click="close-new-unit-modal">&times;</span>
              <p>
                <%= for unit_type <- Warheim.Rules.UnitType.all() do %>
                  <div><%= unit_type.name %></div>
                <% end %>
              </p>
            </div>
          </div>
        <% end %>
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

  defp band_size(%Creator.State{band_type_id: band_type_id}) do
    min..max = band(band_type_id).band_size
    "#{min} - #{max}"
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
