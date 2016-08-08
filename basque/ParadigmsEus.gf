resource ParadigmsEus = open Prelude, AditzTrinkoak, ResEus, CatEus, ParamX in {

oper

--2 Nouns

  mkN = overload {
   mkN : Str -> N = \s -> lin N (mkNoun s) ;
   mkN : Str -> Bizi -> N = \s,ani -> lin N (mkNoun s) ;
   mkN : Str -> Phono -> N = \s,ph -> lin N (mkNoun s) ** {ph = ph} ;
  } ;

  mkPN = overload {
    mkPN : Str -> PN = \s -> lin PN (mkPNoun s) ;
    mkPN : Str -> Phono -> PN = \s,ph -> lin PN (mkPNoun s) ** {ph = ph} ;

  } ;

--2 Adjectives

  mkA : Str -> A = \s -> lin A (mkAdj s) ;

--  mkA2 : Str -> A2 = \s -> lin A2 (mkAdj s) ;



--2 Verbs

  mkV = overload {

    mkV : Str -> V = \s -> lin V (mkVerbNor s) ;

    mkV : Str -> V -> V = \lo,egin -> 
      lin V (egin ** { prc = \\t => lo ++ egin.prc ! t }) ;

  } ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (mkVerbNorNork s) ;

    mkV2 : Str -> Valency -> V2 = \s,val -> lin V2 (mkVerbNor s ** { val = val }) ;

    mkV2 : Str -> V -> V2 = \lo,egin -> 
      lin V2 (egin ** { prc = \\t => lo ++ egin.prc ! t ;
                        val = NorNork Ukan }) ;

  } ;


  --mkV* : Str -> (VT : Type) -> VT = \s,VT -> lin VT (mkVerbNorNork s) ;

  mkVQ : Str -> VQ = \s -> lin VQ (mkVerbNorNork s) ;
  mkVS : Str -> VS = \s -> lin VS (mkVerbNorNork s) ;

  mkV2S : Str -> V2S = \s -> lin V2S (mkVerbNorNoriNork s) ;
  mkV2Q : Str -> V2Q = \s -> lin V2Q (mkVerbNorNoriNork s) ;
  mkV3 : Str -> V3 = \s -> lin V3 (mkVerbNorNoriNork s) ;


  -----
  -- Verbs with non-inflecting participle
  -- These are just Verb, use izanV for Nor and ukanV for NorNork.

  izanV : Str -> Verb = \bizi -> 
    let biziV = mkVerbNor bizi ;
    in biziV ** { prc = \\_ => bizi } ;

  ukanV : Str -> Verb = \maite -> 
    let maiteV2 = mkVerbNorNork maite ;
    in maiteV2 ** { prc = \\_ => maite } ;


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

  mkPNoun : Str -> PNoun = \s -> mkNoun s ** {nbr = Sg ; anim=Anim} ; 

  mkVerbNor : Str -> Verb = \s -> { val = Nor Izan ;
                                    prc = mkPrc s } ;  

  mkVerbNorNork : Str -> Verb = \s -> { val = NorNork Ukan ; 
                                        prc = mkPrc s } ; 

  mkVerbNorNoriNork : Str -> Verb = \s -> { val = NorNoriNork ; 
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

