defmodule Warheim.Rules.Alignment do
  def all do
    [
      %{
        id: "lawful",
        name: "Praworządna"
      },      %{
        id: "good",
        name: "Dobra"
      },      %{
        id: "neutral",
        name: "Neutralna"
      },      %{
        id: "evil",
        name: "Zła"
      },      %{
        id: "chaotic",
        name: "Chaotyczna"
      },
    ]
  end

  def find(alignment_id) do
    all()
    |> Enum.find(fn alignment -> alignment.id == alignment_id end)
  end
end
