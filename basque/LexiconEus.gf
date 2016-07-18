concrete LexiconEus of Lexicon = CatEus **
  open ParadigmsEus, Prelude, (R=ResEus) in {

lin black_A = mkA "beltz" ;
lin blood_N = mkN "odol" ;
lin blue_A = mkA "urdin" ;
lin beer_N = mkN "garagardo" ;
--lin have_V2 = { s = AditzTrinkoak.eduki_V2 } ** { prc = mkPrc "" ; sc = Erg } ;

lin blow_V = mkV "putz" egin_V ;
lin sleep_V = mkV "lo"  egin_V ;

lin love_V2 = mkV2 "maite" egin_V ; --TODO don't put egin_V but the real thing

lin see_V2  = mkV2 "ikusi" ;
lin drink_V2 = mkV2 "edan" ;


oper
  egin_V : V = mkV "egin" ;

}