concrete ConjunctionEus of Conjunction = 
  CatEus ** open ResEus, Coordination, Prelude in {

  flags optimize=all_subs ;

  lin

    ConjCN co ns = {s = conjunctX co ns ; ph=FinalA ; stem = ns.s2}  ; --- gender?

    ConjAP co as = {s = conjunctX co as ; ph=FinalA ; stem = as.s2 } ; 

  lincat

    [CN] = {s1,s2 : Str } ;
    [AP] = {s1,s2 : Str } ;

}
