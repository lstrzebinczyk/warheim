defmodule Creator.Components.Stage2 do
  use Surface.LiveComponent

  alias Surface.Components.Form.Field

  prop state, :any
  data is_new_unit_modal_opened, :boolean, default: false
  data unit_type_index_selected, :integer, default: 0

  def render(assigns) do
    ~H"""
      <div class="row">
        <div class="col-4">
          <Creator.Components.BandDetails band_type_id={{ @state.band_type_id }} />
        </div>
        <div class="col">
          <button type="button" class="btn btn-primary" :on-click="open-new-unit-modal">
            Dodaj jednostkę
          </button>
          <div :if={{ @is_new_unit_modal_opened }}>
            <div class="x-modal-background" :on-click="close-new-unit-modal"></div>
            <div class="x-modal">
              <div class="x-modal-content">
                <span class="close" :on-click="close-new-unit-modal">&times;</span>
                <p>
                  <div class="row">
                    <div class="col-4">
                      <div :for.with_index={{ {unit_type, i} <- unit_types() }}>
                        <button
                          :on-click="select-unit-type-id"
                          type="button"
                          class={{"btn", "btn-primary", active: i == @unit_type_index_selected }}
                          value={{i}}
                        >
                          {{ unit_type.name }}
                        </button>
                      </div>
                    </div>
                    <div class="col">
                      {{ unit_types() |> Enum.at(@unit_type_index_selected) |> Map.get(:name) }}
                    </div>
                  </div>
                </p>
              </div>
            </div>
          </div>
        </div>
      </div>
    """
  end

  def unit_types do
    Warheim.Rules.UnitType.all()
  end

  def handle_event("open-new-unit-modal", _, socket) do
    socket =
      socket
        |> assign(:unit_type_index_selected, 0)
        |> assign(:is_new_unit_modal_opened, true)

    {:noreply, socket}
  end

  def handle_event("close-new-unit-modal", _, socket) do
    socket = assign(socket, :is_new_unit_modal_opened, false)
    {:noreply, socket}
  end

  def handle_event("select-unit-type-id", %{"value" => number_as_string}, socket) do
    unit_type_index_selected = String.to_integer(number_as_string)

    socket =
      socket
        |> assign(:unit_type_index_selected, unit_type_index_selected)

    {:noreply, socket}
  end
end
