defmodule Warheim.Rules.Band.GoblinPirates do
  def data do
    %{
      id: "goblin_pirates",
      name: "Załoga Zielonoskórych Kaprów",
      alignment_id: "evil",
      special_rule_ids: ["tax", "wasteful"],
      band_size: 3..15,
      unit_templates: [
        captain_template()
      ]
    }
  end

  defp captain_template do
    %{
      name: "Kapitan Goblinów",
      race: "goblin",
      unit_type: "hero",
      cost: 50,
      starting_exp: 20,
      count: 1..1,
      availability: nil,
      base: "20x20",
      initial_chars: %{
        movement: 4,
        weapon_skill: 4,
        balistic_skill: 4,
        strength: 3,
        toughness: 3,
        wounds: 2,
        initiative: 4,
        attacks: 1,
        leadership: 7
      },
      inventory: ["knife", "pistol"],
      special_rules: ["leader", "they_smell_weird"]
    }
  end
end
