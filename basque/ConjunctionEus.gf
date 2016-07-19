concrete ConjunctionEus of Conjunction = 
  CatEus ** open ResEus, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    {- Conjunction for category X needs four things:
       lincat [X] 
       lin BaseX
       lin ConsX
       lin ConjX

    For example, if X is defined as

      lincat X   = {s     : Number => Str ;     g : Gender} ;

    then [X] will split its s field into two, and retain its other fields as is:

      lincat [X] = {s1,s2 : Number => Str ; g : Gender} ;

    Let us look at a simple case: Adv is of type {s : Str}
    Then [Adv] is {s1,s2 : Str}.
    BaseAdv, ConsAdv and ConjAdv can all use functions defined in prelude/Coordination:

      BaseAdv = twoSS ;
      ConsAdv = consrSS comma ;
      ConjAdv = conjunctSS ;

    --}


    BaseAdv = twoSS ;
    ConsAdv = consrSS comma ;
    ConjAdv = conjunctSS ;
    
    BaseNP x y = twoTable Case x y ** {agr = y.agr ; anim = y.anim ; nbr = y.nbr } ;
    ConsNP xs x = consrTable Case comma xs x ** {agr = x.agr ; anim = x.anim ; nbr = x.nbr } ;


    -- FIXME: The agreement should be sensible like 
    --         "Ni eta Inari itsasoan gaude."
    ConjNP conj ss = conjunctTable Case conj ss ** { agr = Hauek ; anim = Inan ; nbr = Pl ; isDef = True } ; 

    ConjAP co as = {s = conjunctX co as ; ph=FinalA ; stem = as.s2 ; typ = as.typ } ; 

  lincat
    [Adv] = {s1,s2 : Str} ;
    [AP] = {s1,s2 : Str ; stem : Str ; ph : Phono ; typ : APType } ;
    [NP] = {s1,s2 : Case => Str ; agr : Agr ; anim : Bizi ; nbr : Number } ;


}


UseCl (TTAnt TPres ASimul) PNeg (PredVP (DetCN (DetQuant ? ?) (UseN boy_N)) (ComplSlash (SlashV2a drink_V2) (DetCN (DetQuant ArtDef ?) (UseN beer_N))))
