defmodule WarheimWeb.CreatorLive do
  use WarheimWeb, :live_view

  def mount(_params, _session, socket) do
    bands = ["Goblins", "Dwarfs"]
    state = %{
      selected_band: nil
    }

    {:ok, assign(socket, bands: bands, state: state)}
  end

  def handle_event("band-selected", %{"band" => %{"selected_band" => selected_band}}, socket) do
    new_state = Map.put(socket.assigns.state, :selected_band, selected_band)
    {:noreply, assign(socket, state: new_state)}
  end

  def handle_event(name, params, socket) do
    IO.inspect({name, params})

    {:noreply, socket}
  end

  defp all_bands_for_select do
    Warheim.Rules.Band.all()
    |> Enum.map(&{&1.name, &1.id})
  end
end
