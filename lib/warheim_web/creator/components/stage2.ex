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
      </div>
      <div class="col">
        main page
      </div>
    </div>
    """
  end

  defp band_type_name(%Creator.State{band_type_id: band_type_id}) do
    band(band_type_id).name
  end

  defp band_alignment_name(%Creator.State{band_type_id: band_type_id}) do
    alignment_id = band(band_type_id).alignment_id
    Warheim.Rules.Alignment.find(alignment_id).name
  end

  defp band(band_type_id) do
    Warheim.Rules.Band.find(band_type_id)
  end
end
