defmodule Warheim.Rules.Race do
  defmodule Warheim.Rules.Race.Goblin do
    def data do
      %{
        id: "goblin",
        name: "Goblin",
        max_chars: %{
          movement: 5,
          weapon_skill: 5,
          balistic_skill: 6,
          strength: 3,
          toughness: 4,
          wounds: 3,
          initiative: 6,
          attacks: 4,
          leadership: 7
        }
      }
    end
  end

  def all do
    [
      Warheim.Rules.Race.Goblin.data()
    ]
  end
end
