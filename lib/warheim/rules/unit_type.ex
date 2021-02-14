defmodule Warheim.Rules.UnitType do
  def all do
    [
      %{
        id: "hero",
        name: "Bohater"
      },
      %{
        id: "henchmen",
        name: "Stronnik"
      },
      %{
        id: "machine",
        name: "Maszyna"
      }
    ]
  end
end
