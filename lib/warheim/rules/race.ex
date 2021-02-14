defmodule Warheim.Rules.Race do
  defmodule Warheim.Rules.Race.Dwarf do
    def data do
      %{
        id: "dwarf",
        name: "Krasnolud"
      }
    end
  end

  def all do
    [
      Warheim.Rules.Race.Dwarf.data()
    ]
  end
end
