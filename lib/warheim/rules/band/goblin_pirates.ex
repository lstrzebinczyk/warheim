defmodule Warheim.Rules.Band.GoblinPirates do
  def data do
    %{
      id: "goblin_pirates",
      name: "Załoga Zielonoskórych Kaprów",
      alignment_id: "evil",
      special_rule_ids: ["tax", "wasteful"],
      band_size: 3..15
    }
  end
end
