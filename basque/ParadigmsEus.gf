resource ParadigmsEus = open Prelude, AditzTrinkoak, ResEus, CatEus, ParamX in {

oper
  mkN : Str -> N = \s -> lin N (mkNoun s) ;
  mkA : Str -> A = \s -> lin A (mkNoun s) ;
  mkV : Str -> V = \s -> lin V {s = copulaNor; prc = mkPrc s} ;

  mkPrc : Str -> (Tense => Str) = \ikusi ->
    let ikus = init ikusi ;
        ikusten = ikus + "ten" ;
	ikusiko = ikusi + "ko" ;
    in table {Pres => ikusten ;
	      Fut  => ikusiko ;
              _    => ikusi } ;

  mkNoun : Str -> Noun = \s -> {s = s ;
                                ph = case last s of {
				   "r" => FinalR ;
				   "a" => FinalA ;
				   ("e"|"i"|"o"|"u") => FinalVow ;
 				   _   => FinalCons } ;
                                } ; 


  mkV2 = overload {
   mkV2 : Str -> V2 = \s -> lin V2 {s = copulaNorNork ; prc = mkPrc s ; sc = Erg} ;
   mkV2 : Str -> Case -> V2 = \s,cas -> lin V2 {s = copulaNorNork ; prc = mkPrc s ; sc = cas} ;
  } ;

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;
  mkPrep : Str -> Prep = \s -> lin Prep {s = s} ;}
    