defmodule Creator.Components.Stage2 do
  use Surface.LiveComponent

  prop state, :any
  data is_new_unit_modal_opened, :boolean, default: false

  def render(assigns) do
    ~H"""
      <div class="row">
        <div class="col-4">
          <Creator.Components.BandDetails band_type_id={{ @state.band_type_id }} />
        </div>
        <div class="col">
          <button type="button" :on-click="open-new-unit-modal">
            Dodaj jednostkę
          </button>
          <div :if={{ @is_new_unit_modal_opened }}>
            <div class="x-modal-background" :on-click="close-new-unit-modal"></div>
            <div class="x-modal">
              <div class="x-modal-content">
                <span class="close" :on-click="close-new-unit-modal">&times;</span>
                <p>
                  <div :for={{ unit_type <- unit_types() }}>
                    {{ unit_type.name }}
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
    socket = assign(socket, :is_new_unit_modal_opened, true)
    {:noreply, socket}
  end

  def handle_event("close-new-unit-modal", _, socket) do
    socket = assign(socket, :is_new_unit_modal_opened, false)
    {:noreply, socket}
  end
end
