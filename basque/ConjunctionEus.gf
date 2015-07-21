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
    
--    BaseNP np1 np2 = twoSS np1 np2 ** {stem = np2.stem ; ph = np2.ph } ;
--    ConsNP np1 np2s = consrSS comma np1 np2s ** { stem = np1.stem ; ph = np1.ph } ; -- this is wrong, should be last item
--    ConjNP co nps =  let newnp = conjunctX co nps in { s,stem=newnp ; ph = nps.ph } ;
{-
    BaseCN cn1 cn2 = twoSS cn1 cn2 ** {stem = cn2.stem ; ph = cn2.ph } ;
    ConsCN cn1 cn2s = consrSS comma cn1 cn2s ** {stem = cn1.stem ; ph = cn1.ph} ; 
    ConjCN co ns = let newcn = conjunctX co ns in
     {s,stem=newcn ; ph=ns.ph} ;
-}
    ConjAP co as = {s = conjunctX co as ; ph=FinalA ; stem = as.s2 } ; 

  lincat
    [Adv] = {s1,s2 : Str} ;
--    [CN] = {s1,s2 : Str ; stem : Str ; ph : Phono} ;
    [AP] = {s1,s2 : Str ; stem : Str ; ph : Phono} ;
    [NP] = {s1,s2 : Str ; stem : Str ; ph : Phono} ;

}
