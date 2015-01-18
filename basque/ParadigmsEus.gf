resource ParadigmsEus = open Prelude, AditzTrinkoak, ResEus, CatEus, ParamX in {

oper
  mkN = overload {
   mkN : Str -> N = \s -> lin N (mkNoun s) ;
   mkN : Str -> Phono -> N = \s,ph -> lin N {s = s ; stem = s ; ph = ph } 
  } ;
  mkA : Str -> A = \s -> lin A (mkAdj s) ;
  mkV : Str -> V = \s -> lin V {s = copulaNor; prc = mkPrc s} ;

  mkPrc : Str -> (Tense => Str) = \ikusi ->
    let ikus = init ikusi ;
        ikusten = ikus + "ten" ;
	ikusiko = ikusi + "ko" ;
    in table {Pres => ikusten ;
	      Fut  => ikusiko ;
              _    => ikusi } ;

  mkAdj : Str -> Adjective = \s -> let 
                                   stem : Str = case last s of {
				       "a" => init s ; 
				       _   => s                } ;
				   phono : Phono = case last s of {
				       "a"               => FinalA ;
				       "r"               => FinalR ;
				       ("e"|"i"|"o"|"u") => FinalVow ;
 				       _                 => FinalCons } 
			       in { s = table {Posit  => stem ;
					       Compar => stem + "ago" ;
					       Superl => stem + "en" } ;
					      -- Excess => stem + "egi" } ;
				    ph = phono } ; 
  mkNoun : Str -> Noun = \s -> let 
                                   stem : Str = case last s of {
				       "a" => init s ; 
				       _   => s } ;
				   phono : Phono = case last s of {
				       "a"               => FinalA ;
				       "r"               => FinalR ;
				       ("e"|"i"|"o"|"u") => FinalVow ;
 				       _                 => FinalCons } 
			       in { s = s; stem = stem ; ph = phono } ; 



  mkV2 = overload {
   mkV2 : Str -> V2 = \s -> lin V2 {s = copulaNorNork ; prc = mkPrc s ; sc = Erg} ;
   mkV2 : Str -> Case -> V2 = \s,cas -> lin V2 {s = copulaNorNork ; prc = mkPrc s ; sc = cas} ;
  } ;


  mkV3 : Str -> V3 = \s -> lin V3 { prc = mkPrc s } ;

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;
  mkPrep : Str -> Prep = \s -> lin Prep {s = s} ;}
    