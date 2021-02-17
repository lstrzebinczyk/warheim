defmodule Creator.Components.Stage2 do
  use Surface.LiveComponent

  alias Creator.Components.SpecialRule

  prop state, :any
  # data is_new_unit_modal_opened, :boolean, default: false
  data is_new_unit_modal_opened, :boolean, default: true
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
                      <div :for={{ unit_template <- unit_templates(@state.band_type_id, @unit_type_index_selected) }}>
                        <div>{{unit_template.name}}</div>
                        <div>Koszt: {{unit_template.cost}} ZK </div>
                        <div>
                          <table class="table">
                            <thead>
                              <tr>
                                <th>SZ</th>
                                <th>WW</th>
                                <th>US</th>
                                <th>S</th>
                                <th>Wt</th>
                                <th>Żw</th>
                                <th>I</th>
                                <th>A</th>
                                <th>CP</th>
                              </tr>
                            </thead>
                            <tbody>
                              <tr>
                                <td>{{ unit_template.initial_chars.movement }}</td>
                                <td>{{ unit_template.initial_chars.weapon_skill }}</td>
                                <td>{{ unit_template.initial_chars.balistic_skill }}</td>
                                <td>{{ unit_template.initial_chars.strength }}</td>
                                <td>{{ unit_template.initial_chars.toughness }}</td>
                                <td>{{ unit_template.initial_chars.wounds }}</td>
                                <td>{{ unit_template.initial_chars.initiative }}</td>
                                <td>{{ unit_template.initial_chars.attacks }}</td>
                                <td>{{ unit_template.initial_chars.leadership }}</td>
                              </tr>
                            </tbody>
                          </table>
                        </div>
                        <div>
                          <div>Zasady Specjalne: </div>
                          <div style="margin-left: 10px;" :for={{ special_rule_id <- special_rules_for(unit_template) }}>
                            <SpecialRule special_rule_id={{special_rule_id}} />
                          </div>
                        </div>
                        <div>
                          <div>Ekwipunek / Pancerz: </div>
                          <div style="margin-left: 10px;" :for={{ item_id <- unit_template.inventory }}>
                            {{item_id}}
                          </div>
                        </div>

                      </div>
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

  def special_rules_for(unit_template) do
    race = Warheim.Rules.Race.find(unit_template.race_id)
    race.special_rules ++ unit_template.special_rules
  end

  def unit_templates(band_type_id, unit_type_index_selected) do
    band_type = Warheim.Rules.Band.find(band_type_id)
    selected_unit_type = Warheim.Rules.UnitType.all() |> Enum.at(unit_type_index_selected)

    band_type.unit_templates
      |> Enum.filter(fn unit_type -> unit_type.unit_type == selected_unit_type.id end)
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
