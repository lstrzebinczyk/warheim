defmodule Warheim.Rules.Band.GoblinPirates do
  def data do
    %{
      id: "goblin_pirates",
      name: "Załoga Zielonoskórych Kaprów",
      alignment_id: "evil",
      special_rules: ["tax", "wasteful"]
    }
  end
end
