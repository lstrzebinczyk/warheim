defmodule WarheimWeb.CreatorLive do
  use WarheimWeb, :live_view

  def mount(_params, _session, socket) do
    # state = %Creator.State{}
    state = %Creator.State{
      stage: 2,
      band_type_id: "goblin_pirates",
      creator_mode: "import"
    }

    {:ok, assign(socket, state: state)}
  end

  # set_band_type_id

  def handle_event(
    "submit_state_1",
    %{
      "state" =>
      %{
        "band_type_id" => band_type_id,
        "creator_mode" => creator_mode
      }
    },
    %{assigns: %{state: state}} = socket
    ) do

    state =
      state
        |> Map.put(:band_type_id, band_type_id)
        |> Map.put(:creator_mode, creator_mode)
        |> Map.put(:stage, 2)

    IO.inspect(state)

    {:noreply, assign(socket, state: state)}
  end

  def handle_event(name, params, socket) do
    IO.inspect({"UNHANDLED EVENT", name, params})

    {:noreply, socket}
  end
end
