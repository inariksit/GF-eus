resource ParadigmsEus = open Prelude, AditzTrinkoak, ResEus, CatEus, ParamX in {

oper

--2 Nouns

  mkN = overload {
   mkN : Str -> N = \s -> lin N (mkNoun s) ;
   mkN : Str -> Bizi -> N = \s,ani -> lin N (mkNoun s) ** {anim=ani} ;
   mkN : Str -> Phono -> N = \s,ph -> lin N {s = s ; stem = s ; ph = ph ; anim=Inan} 
  } ;

  mkPN = overload {
    mkPN : Str -> PN = \s -> lin PN (mkNoun s ** {nbr = Sg} ) ; -- FIXME: check mkNoun
    mkPN : Str -> Phono -> PN = \s,ph -> lin PN {s = s ; stem = s ; ph = ph ; nbr = Sg ; anim=Anim} 

  } ;

--2 Adjectives

  mkA : Str -> A = \s -> lin A (mkAdj s) ;

--  mkA2 : Str -> A2 = \s -> lin A2 (mkAdj s) ;

--2 Verbs

  mkV = overload {

    mkV : Str -> V = \s -> lin V (mkVerb1 s) ;

    mkV : Str -> Str -> V = \lo,egin -> 
      lin V (mkVerb1 lo ** { prc = \\t => lo ++ mkPrc egin ! t }) ;

  } ;


  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (mkVerb2 s) ;

    mkV2 : Str -> Case -> V2 = \s,cas -> lin V2 (mkVerb2 s ** { sc = cas }) ;

    mkV2 : Str -> Str -> V2 = \lo,egin -> 
      lin V2 (mkVerb2 lo ** { prc = \\t => lo ++ mkPrc egin ! t }) ;

  } ;

  mkV3 : Str -> V3 = \s -> lin V3 { prc = mkPrc s ; ph = FinalCons } ;

-------------------------------------------------------------------------------


  mkPrc : Str -> (Tense => Str) = \ikusi ->
    let egi = init ikusi ;
        egite = case last ikusi of {
                      "n" => egi + "te" ;
                      _   => egi
                 } ;
        ikusten = egite + "n" ;
        ikusiko = egite + "ko" ;
    in table { Pres => ikusten ;
	             Fut  => ikusiko ;
               _    => ikusi } ;

  mkAdj : Str -> Adjective = \s -> 
    let stem : Str = case last s of {
				       "a" => init s ; 
				       _   => s                } ;
				phono : Phono = case last s of {
				       "a"               => FinalA ;
				       "r"               => FinalR ;
				       ("e"|"i"|"o"|"u") => FinalVow ;
 				       _                 => FinalCons } 
	  in { s = table { Posit  => stem ;
					           Compar => stem + "ago" ;
					           Superl => stem + "en" } ;
				  	      -- Excess => stem + "egi" } ;
				 ph = phono } ; 

  mkNoun : Str -> Noun = \s ->
    let stem : Str = case last s of {
				       "a" => init s ; 
				       _   => s } ;
				phono : Phono = case last s of {
				       "a"               => FinalA ;
				       "r"               => FinalR ;
				       ("e"|"i"|"o"|"u") => FinalVow ;
 				       _                 => FinalCons } 
		in { s = s;  stem = stem ; ph = phono ; anim=Inan } ; 

  mkVerb1 : Str -> Verb1 = \s -> { s   = copulaNor; 
                                   prc = mkPrc s ;
                                   ph  = FinalCons } ;  

  mkVerb2 : Str -> Verb2 = \s -> { s   = copulaNorNork ; 
                                   prc = mkPrc s ; 
                                   sc  = Erg ; 
                                   ph  = FinalCons } ; 


  mkConj : Str -> Conj = \s -> lin Conj { s = s } ; 

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;

  mkAdV : Str -> AdV = \s -> lin AdV {s = s} ;

  mkAdA : Str -> AdA = \s -> lin AdA {s = s} ;

--2 Prepositions

  mkPrep = overload {
 
    mkPrep : Str -> ComplType -> Bool -> Prep = \s,compl,konf -> 
       lin Prep { s = s ; 
                  complType = compl ; 
                  attached = konf } ;

    mkPrep : Str -> ComplType -> Prep = \s,compl -> 
       lin Prep { s = s ; 
                  complType = compl ; 
                  attached = True } ;

    mkPrep : Str -> Prep = \s -> 
       lin Prep { s = s ; 
                  complType = AbsNP ; 
                  attached = True } ;

  } ; 

}

