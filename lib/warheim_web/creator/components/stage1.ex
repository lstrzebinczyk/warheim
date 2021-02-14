defmodule Creator.Components.Stage1 do
  use WarheimWeb, :live_component

  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  def render(assigns) do
    ~L"""
    <%= f = form_for :state, "", [phx_submit: :set_band_type_id] %>
      <div>
        Stwórz nową bandę
      </div>
      <div>
        <%= label f, :band_type_id, "Typ Bandy" %>
        <%= select f, :band_type_id, all_bands_for_select(), prompt: "", value: @state.band_type_id %>
      </div>
      <div>
        <%= label f, :creator_mode, "Tryb Kreatora" %>
        <%= select f, :creator_mode, creator_modes(), prompt: "", value: @state.creator_mode %>
      </div>
      <div>
        <%= submit "ok!" %>
      </div>
    </form>
    """
  end

  defp all_bands_for_select do
    Warheim.Rules.Band.all()
    |> Enum.map(&{&1.name, &1.id})
  end

  defp creator_modes do
    [:import]
  end
end
