defmodule Warheim.Rules.Race do
  defmodule Warheim.Rules.Race.Dwarf do
    def id, do: "dwarf"
    def name, do: "Krasnolud"
  end

  def all do
    [
      Warheim.Rules.Race.Dwarf
    ]
  end
end
