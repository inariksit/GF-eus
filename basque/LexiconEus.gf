concrete LexiconEus of Lexicon = CatEus **
  open ParadigmsEus, Prelude, (R=ResEus) in {


lin add_V3 = mkV3 "gehitu" ;
lin airplane_N = mkN "hegazkin" ;
--lin alas_Interj = mkInterj "" ;
lin already_Adv = mkAdv "dagoeneko" ; --Google translate
lin animal_N = mkN "animalia" ;
--apartment_N
lin art_N = mkN "arte" ;
--ashes_N
--baby_N
--back_N
lin bad_A = mkA "txarra" ;
--bank_N
--bark_N
--beautiful_A
lin become_VA = mkVA "bihurtu" ;
lin apple_N = mkN "sagar" ;

lin beer_N = mkN "garagardo" ;
lin big_A = mkA "handi" ;
lin black_A = mkA "beltz" ;
lin blood_N = mkN "odol" ;
lin blow_V = mkV "putz" egin_V ;
lin blue_A = mkA "urdin" ;
lin book_N = mkN "liburu" ;
lin boy_N  = mkN "mutil" ;
lin brother_N2 = mkN2 "anaia" ;
lin buy_V2 = mkV2 "erosi" ;

lin drink_V2 = mkV2 "edan" ;
lin dog_N = mkN "txakur" ;

lin eye_N = mkN "begi" ;
lin father_N2 = mkN2 "aita" ;
lin fear_V2 = ukanV "beldur" ; -- beldur nauzu `you are afraid of me'
lin fear_VS = izanV "beldur" ; -- beldur naiz [ez datorrela] `I'm afraid s/he won't come'
lin girl_N  = mkN "neska" ;

lin mother_N2 = mkN2 "ama" ;


lin sea_N   = mkN "itsaso" ;
lin sleep_V = mkV "lo" egin_V ;

lin live_V  = izanV "bizi" ;
lin love_V2 = ukanV "maite" ; 

lin see_V2  = mkV2 "ikusi" ;


lin know_VQ = jakin_VQ ; -- synthetic verb

lin know_VS = ukanV "uste" ;

lin answer_V2S = mkV2S "erantzun" ; 
lin ask_V2Q = mkV2Q "galdetu" ;

oper
  egin_V : V = mkV "egin" ;

  jakin_VQ : VQ = 
  	let jakin = mkVQ "jakin" ;
  	in  jakin ** { prc = table { R.Pres => [] ; -- synthetic forms for present in AditzTrinkoak.jakin!
      							 tns    => jakin.prc ! tns } ;
      			   val = R.NorNork R.Jakin  
      			 } ;

}