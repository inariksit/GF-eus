--# -path=.:../basque

concrete DictionaryEus of Dictionary = CatEus 
** open ResEus, Prelude in {

oper mkN : Str -> N = \s -> lin N {s = s} ;
oper mkA : Str -> A = \s -> lin A {s = s} ;
oper mkV : Str -> V = \s -> lin V {s = table {_ => s}} ;
oper mkV2 : Str -> V2 = \s -> lin V2 {s = table {_ => s} ; cas = Abs} ;
oper mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;

lin boy_N = mkN "mutil" ; 
lin house_N = mkN "etxe" ; 
lin light_N = mkN "argi" ;
lin see_V2  = mkV2 "ikusi" ;
lin now_Adv = mkAdv "orain" ;
lin walk_V = mkV "ibili" ;


}

