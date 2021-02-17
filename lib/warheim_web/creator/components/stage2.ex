defmodule Creator.Components.Stage2 do
  use WarheimWeb, :live_component

  def update(%{state: state}, socket) do
    socket =
      socket
        |> assign(:state, state)
        |> assign(:is_new_unit_modal_opened, false)
        # |> assign(:is_new_unit_modal_opened, true)

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
        <%= live_component @socket, Creator.Components.BandDetails, band_type_id: @state.band_type_id %>
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
end
