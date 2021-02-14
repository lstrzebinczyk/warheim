defmodule Warheim.Rules.Band do
  def all do
    [
      Warheim.Rules.Band.GoblinPirates.data()
    ]
  end

  def find(band_id) do
    all()
    |> Enum.find(nil, fn band -> band.id == band_id end)
  end
end
