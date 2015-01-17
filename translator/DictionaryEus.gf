--# -path=.:../basque

concrete DictionaryEus of Dictionary = CatEus 
** open ResEus, Prelude in {

oper mkN : Str -> N = \s -> lin N {s = s} ;
oper mkA : Str -> A = \s -> lin A {s = s} ;
oper mkV : Str -> V = \s -> lin V {s = table {_ => s}} ;
oper mkV2 : Str -> V2 = \s -> lin V2 {s = table {_ => s} ; cas = Abs} ;
oper mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;
oper mkPrep : Str -> Prep = \s -> lin Prep {s = s} ;

lin in_Prep = mkPrep "n" ;

lin boy_N = mkN "mutil" ; 
lin house_N = mkN "etxe" ; 
lin light_N = mkN "argi" ;

lin now_Adv = mkAdv "orain" ;

lin walk_V = mkV "ibili" ;
lin fall_V = mkV "amildu" ;

lin see_V2  = mkV2 "ikusi" ;


}

