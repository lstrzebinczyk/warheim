defmodule Creator.Components.BandDetails do
  use Surface.Component

  prop band_type_id, :string, required: true
  data band, :any

  def update(%{band_type_id: band_type_id}, socket) do
    band = Warheim.Rules.Band.find(band_type_id)

    socket =
      socket
        |> assign(:band, band)

    {:ok, socket}
  end

  # Accepts a single tooltip param
  def render(assigns) do
    ~H"""
      <div>
        <h2>{{ @band.name }}</h2>
        <div>
          Natura: {{ band_alignment_name(@band) }}
        </div>
        <br>
        <div>
          <div>Zasady Specjalne: </div>
            <div style="margin-left: 10px;" :for={{ special_rule <- special_rules(@band) }}>
              {{ special_rule.name }}
              <Creator.Components.InfoWithTooltip tooltip={{special_rule.description}} />
            </div>
        </div>
        <br>
        <div>
          Rozmiar bandy: {{ band_size(@band) }} modeli
        </div>
      </div>
    """
  end

  defp band_size(band) do
    min..max = band.band_size
    "#{min} - #{max}"
  end

  defp band_alignment_name(band) do
    Warheim.Rules.Alignment.find(band.alignment_id).name
  end

  defp special_rules(band) do
    band.special_rule_ids
    |> Enum.map(fn special_rule_id ->
      Warheim.Rules.SpecialRule.find(special_rule_id)
    end)
  end
end
