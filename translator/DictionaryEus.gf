--# -path=.:../basque

concrete DictionaryEus of Dictionary = CatEus ** open ParadigmsEus, Prelude in {


lin in_Prep = mkPrep "n" ;
lin with_Prep = mkPrep "z" | mkPrep "ekin" ;  -- split
lin from_Prep = mkPrep "tik" ;
lin to_Prep = mkPrep "ra" ;

lin boy_N = mkN "mutil" ; 
lin house_N = mkN "etxe" ; 
lin light_N = mkN "argi" ;

lin now_Adv = mkAdv "orain" ;

lin walk_V = mkV "ibili" ;
lin fall_V = mkV "amildu" ;

lin see_V2  = mkV2 "ikusi" ;


}

