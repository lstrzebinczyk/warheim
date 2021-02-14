defmodule Warheim.Rules.SpecialRule do
  def find(special_rule_id) do
    all()
    |> Enum.find(nil, fn special_rule -> special_rule.id == special_rule_id end)
  end

  def all do
    [
      %{
        id: "tax",
        name: "Podatek",
        description: """
          Być może kompania służy organizacji, która pośredniczy w zakupie ekwipunku,
          a może Gildia Kupców nałożyła na *drużynę* dodatkowy podatek. Niezależnie od przyczyny,
          dla kompanii oznacza to dodatkowe koszty związane z pozyskaniem najpospolitszych nawet przedmiotów.
          W grze odzwierciedla to zasada, zgodnie z którą *drużyna* za każdy zakupiony w trakcie *sekwencji po potycznce*
          przedmiot muszą zapłacić dodatkowym złotem. I tak, wartość przedmiotu, którego cena nie przekracza **20** ZK wzrasta
          o kolejne **K6** ZK; ekwipunek, którego wartość podstawowa oscyluje w granicach od **21** ZK do **50** ZK zostaje
          zwiększona o kolejne **2K6** ZK, zaś przedmioty, których cena podstawowa przekracza **51** ZK muszą dopłacić kolejne **3K6** ZK.
        """
      },
      %{
        id: "wasteful",
        name: "Rozrzutność",
        description: """
          Kompanie podlegające *zasadzie specjalnej* `Rozrzutność` trwonią spore nakłady finansowe na zapewnienie odpowiedniego wiktu i opierunku,
          lub w celu ukrycia swej prawiwej natury. W grze odzwierciedla to zasada, zgodnie z którą w trakcie *sekwencji po potyczce*, na potrzeby
          zasad sprzedaży *łupów* kompania traktowana jest tak, jakby licza modeli w *drużynie* była o jeden poziom większa,
          niż to faktycznie ma miejsce.
        """
      }
    ]
  end
end
