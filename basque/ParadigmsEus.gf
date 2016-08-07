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

    mkV : Str -> V -> V = \lo,egin -> 
      lin V (egin ** { prc = \\t => lo ++ egin.prc ! t }) ;

  } ;


  izanV : Str -> V = \maite -> 
    let maiteV = mkVerb1 maite ;
    in lin V (maiteV ** { prc = \\_ => maite }) ;

  ukanV2 : Str -> V2 = \maite -> 
    let maiteV2 = mkVerb2 maite ;
    in lin V2 (maiteV2 ** { prc = \\_ => maite }) ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (mkVerb2 s) ;

    mkV2 : Str -> Valency -> V2 = \s,val -> lin V2 (mkVerb2 s ** { val = val }) ;

    mkV2 : Str -> V -> V2 = \lo,egin -> 
      lin V2 (egin ** { prc = \\t => lo ++ egin.prc ! t ;
                        val = NorNork }) ;

  } ;

  mkV3 : Str -> V3 = \s -> lin V3 { prc = mkPrc s ; val = NorNoriNork } ;

  mkVQ : Str -> VQ = \s -> lin VQ (mkVerb2 s) ;


  mkVS : Str -> VS = \s -> lin VS (mkVerb2 s) ;
  ukanVS : Str -> VS = \uste -> 
    let usteV2 = mkVerb2 uste ;
    in lin VS (usteV2 ** { prc = \\_ => uste }) ;

  --mkV* : Str -> (VT : Type) -> VT = \s,VT -> lin VT (mkVerb2 s) ;
-------------------------------------------------------------------------------

  -- ibili, ibiltzen, ibiliko
  -- amildu, amiltzen, amilduko
  mkPrc : Str -> (Tense => Str) = \ikusi ->
    let egi = init ikusi ; 
        egite = egi + "te" ;
        ikusten = egite + "n" ;
        ikusiko = case last ikusi of {
                    "n" => egite + "ko" ;
                    _   => ikusi + "ko" }
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
		in { s = stem ; ph = phono ; anim=Inan } ; 

  mkVerb1 : Str -> Verb = \s -> { val = Nor ;
                                  prc = mkPrc s } ;  

  mkVerb2 : Str -> Verb = \s -> { val = NorNork ; 
                                   prc = mkPrc s } ; 


  mkConj : Str -> Number -> Conj = \s,num -> lin Conj { s = s ; nbr = num } ; 
  mkSubj : Str -> Bool -> Subj   = \s,b   -> lin Subj { s = s ; isPre = b } ;

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;

  mkAdV : Str -> AdV = \s -> lin AdV {s = s} ;

  mkAdA : Str -> AdA = \s -> lin AdA {s = s} ;

--2 Prepositions

  mkPrep = overload { 
    mkPrep : Str -> Case -> Bool -> Prep = \s,compl,konf -> 
       lin Prep (mkPost s compl konf) ; 

    mkPrep : Str -> Case -> Prep = \s,compl -> 
       lin Prep (mkPost s compl True) ; 

    mkPrep : Str -> Prep = \s -> 
       lin Prep (mkPost s Abs True) ;
  } ; 

  casePrep : Case -> Prep = \cas ->
    mkPrep [] cas False ; -- choose given case, add empty string without BIND

}

