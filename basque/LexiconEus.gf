concrete LexiconEus of Lexicon = CatEus **
  open ParadigmsEus, Prelude, (R=ResEus) in {

lin black_A = mkA "beltz" ;
lin blood_N = mkN "odol" ;
lin blue_A = mkA "urdin" ;
lin beer_N = mkN "garagardo" ;
lin boy_N  = mkN "mutil" ;
lin girl_N  = mkN "neska" ;

lin blow_V = mkV "putz" egin_V ;
lin sleep_V = mkV "lo"  egin_V ;

lin love_V2 = ukanV2 "maite" ; 

lin see_V2  = mkV2 "ikusi" ;
lin drink_V2 = mkV2 "edan" ;


lin know_VQ = jakin_VQ ; -- synthetic verb
lin know_VS = ukanVS "uste" ;

oper
  egin_V : V = mkV "egin" ;

  jakin_VQ : VQ = 
  	let jakin = mkVQ "jakin" ;
  	in  jakin ** { prc = table { Pres => [] ; -- synthetic forms for present in AditzTrinkoak.jakin!
      							 tns  => jakin.prc ! tns } ;
      			   val = R.NorNork R.Jakin  
      			 } ;

}