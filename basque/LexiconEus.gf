concrete LexiconEus of Lexicon = CatEus **
  open ParadigmsEus, Prelude, (R=ResEus), AditzTrinkoak in {

----
-- A

lin add_V3 = mkV3 "gehitu" ; -- | mkV3 "erantsi" | mkV3 "gaineratu" ; --Apertium
lin airplane_N = mkN "hegazkin" ;
--lin alas_Interj = mkInterj "" ;
lin already_Adv = mkAdv "dagoeneko" ; --Google translate
lin animal_N = mkN "animalia" ;
lin answer_V2S = mkV2S "erantzun" ; 
lin apartment_N = mkN "pisu" ; -- | mkN "apartamentu" ; --Apertium
lin apple_N = mkN "sagar" ;
lin art_N = mkN "arte" ;
--lin ashes_N = mkN 
lin ask_V2Q = mkV2Q "galdetu" ;

----
-- B

lin baby_N = mkN "haur" ; -- | mkN "ume" | mkN "kreatura" ; --Apertium
lin back_N = mkN "bizkar" ;
lin bad_A = mkA "txar" ;
lin bank_N = mkN "banku" ; --| mkN "erribera" | mkN "ertz" ; --Apertium
lin bark_N = mkN "azal" ; --Apertium
lin beautiful_A = mkA "polit" ;
lin become_VA = mkVA "bihurtu" ;
lin beer_N = mkN "garagardo" ;
lin beg_V2V = mkV2V "erregutu" ;
lin belly_N = mkN "urdail" ; --| mkN "sabel" ; --Apertium
lin big_A = mkA "handi" ;
lin bike_N = mkN "bizikleta" ;
lin bird_N = mkN "txori" ; -- | mkN "hegazti" ; --Apertium
lin bite_V2 = mkV2 "ausiki" ; -- mkV2 (mkV "kosk" egin_V) --Apertium
lin black_A = mkA "beltz" ;
lin blood_N = mkN "odol" ;
lin blow_V = mkV "putz" egin_V ;
lin blue_A = mkA "urdin" ;
lin boat_N = mkN "itsasontzi" ;
lin bone_N = mkN "hezur" ; --Apertium
lin boot_N = mkN "bota" ; --Apertium
lin boss_N = mkN "nagusi" ; --Apertium
lin book_N = mkN "liburu" ;
lin boy_N  = mkN "mutil" ;
lin bread_N = mkN "ogi" ; --Apertium
lin break_V2 = mkV2 "izorratu" ; --Apertium
lin breast_N = mkN "bular" ; --Apertium
lin breathe_V = mkV "arnastu" ; --Apertium
lin broad_A = mkA "zabal" ; --Apertium
lin brother_N2 = mkN2 "anaia" ;
lin brown_A = mkA "marroi" ; --Apertium
lin burn_V = mkV "erre" ; -- | mkV "kiskali" ; --Apertium
lin butter_N = mkN "gurin" ; --Apertium
lin buy_V2 = mkV2 "erosi" ;

----
-- C

lin camera_N = mkN "kamera" ; -- | mkN "ganbera" ; --Apertium
lin cap_N = mkN "txapel" ; -- | mkN "tapoi" ; --Apertium
lin car_N = mkN "auto" ; --| mkN "automobil" ; --Apertium
lin carpet_N = mkN "alfonbra" ; --Apertium
lin cat_N = mkN "katu" ;
lin ceiling_N = mkN "sabai" ; --Apertium
lin chair_N = mkN "aulki" ; --Apertium
lin cheese_N = mkN "gazta" ; --Apertium
lin child_N = mkN "ume" ; --| mkN "umetxo" ; --Apertium
lin church_N = mkN "eliza" ; --Apertium
lin city_N = mkN "hiri" ; --Apertium
lin clean_A = mkA "garbi" ; --Apertium
lin clever_A = mkA "azkar" ; --Apertium
lin close_V2 = mkV2 "gerturatu" ; -- | mkV2 "itxi" | mkV2 "zarratu" ; --Apertium
lin cloud_N = mkN "hodei" ; --Apertium
lin coat_N = mkN "beroki" ; -- | mkN "kapa" ; --Apertium
lin cold_A = mkA "hotz" ;
lin come_V = etorri_V ; --Synthetic verb
lin computer_N = mkN "ordenagailu" ; --| mkN "ordenatzaile" ; --Apertium
lin correct_A = mkA "zuzen" ; --Apertium
lin count_V2 = mkV2 "kontatu" ; -- | mkV2 "zenbatu" ; --Apertium
lin country_N = mkN "herri" ; --Apertium
lin cousin_N = mkN "lehengusu" ; --Apertium
lin cow_N = mkN "behi" | mkN "behi" ; --Apertium
lin cut_V2 = mkV2 "ebaki" ; -- | mkV2 "moztu" ; --Apertium

----
-- D

lin day_N = mkN "egun" ; --Apertium
lin die_V = izanV "hil" ; -- | mkV "zendu" ; --Apertium
lin dig_V = mkV "zulatu" ; --Apertium
lin dirty_A = mkA "likits" ; --| mkA "zikin" ; --Apertium
-- lin distance_N3 = mkN3 (mkN "distantzia") fromP toP ; --Apertium
lin do_V2 = lin V2 egin_V ;
lin doctor_N = mkN "mediku" ; --| mkN "doktore" ; --Apertium
lin dog_N = mkN "txakur" ;
lin door_N = mkN "ate" ;
lin drink_V2 = mkV2 "edan" ;
lin dry_A = mkA "lehor" ; --Apertium
lin dull_A = mkA "aspergarri" ; --Apertium
lin dust_N = mkN "hauts" | mkN "hauts" ; --Apertium

----
-- E

lin ear_N = mkN "belarri" ; --Apertium
lin earth_N = mkN "lur" ; --Apertium
lin eat_V2 = mkV2 "jan" ; -- | mkV2 "bazkaldu" ; --Apertium
lin egg_N = mkN "arrautza" ; --Apertium
lin empty_A = mkA "huts" ; --| mkA "bakarti" ; --Apertium
lin enemy_N = mkN "etsai" ; --| mkN "arerio" ; --Apertium
lin eye_N = mkN "begi" ;

----
-- F

lin factory_N = mkN "fabrika" ; --| mkN "lantegi" ; --Apertium
lin fall_V = mkV "amildu" ; -- | mkV "erori" ; --Apertium
lin fat_N = mkN "gantz" ; --| mkN "koipe" ; --Apertium
lin father_N2 = mkN2 "aita" ; --genitive
lin fear_V2 = ukanV "beldur" ; -- beldur nauzu `you are afraid of me'
lin fear_VS = izanV "beldur" ; -- beldur naiz [ez datorrela] `I'm afraid s/he won't come'
lin feather_N = mkN "luma" ; --Apertium
lin fight_V2 = mkV2 "borrokatu" ; --Apertium
lin find_V2 = mkV2 "aurkitu" ; -- | mkV2 "topatu" ; --Apertium
lin fingernail_N = mkN "azazkal" ; --Apertium
lin fire_N = mkN "su" ; --Apertium
lin fish_N = mkN "arrain" ; --Apertium
lin float_V = mkV "flotatu" ; --Apertium
lin floor_N = mkN "lurzoru" ; -- | mkN "solairu" ; --Apertium
lin flow_V = mkV "jariatu" ; --Apertium
lin flower_N = mkN "lore" ; --Apertium
lin fly_V = mkV "hegan" egin_V ; -- | mkV "pilotatu" ; --Apertium
lin fog_N = mkN "laino" ; --Apertium
lin foot_N = mkN "oin" ; --Apertium
lin forest_N = mkN "baso" ; --Apertium
lin forget_V2 = mkV2 "ahaztu" ; --Apertium
lin freeze_V = mkV "izoztu" ; --Apertium
lin fridge_N = mkN "elurtegi" ; --Apertium
lin friend_N = mkN "lagun" ; --| mkN "adiskide" ; --Apertium
lin fruit_N = mkN "fruta" ; --Apertium
lin full_A = mkA "bete" ; --Apertium
--lin fun_AV

----
-- G

lin garden_N = mkN "lorategi" ; --Apertium
lin girl_N  = mkN "neska" ;
lin give_V3 = mkV3 "eman" ; --Apertium
lin glove_N = mkN "eskularru" | mkN "eskularru" ; --Apertium
lin go_V = mkV "joan" ; --Apertium --TODO synthetic version
lin gold_N = mkN "urre" | mkN "urre" ; --Apertium
lin good_A = mkA "on" | mkA "hobe" | mkA "on" | mkA "onen" ; --Apertium
lin grammar_N = mkN "gramatika" ; --Apertium
lin grass_N = mkN "belar" ; --Apertium
lin green_A = mkA "berde" ; --Apertium

----
-- H

lin hair_N = mkN "ile" ; -- | mkN "adats" ; --Apertium
lin hand_N = mkN "esku" ; --Apertium
lin harbour_N = mkN "portu" ; --| mkN "kai" | mkN "mendate" ; --Apertium
lin hat_N = mkN "kapela" ; --Apertium
lin hate_V2 = mkV2 "gorrotatu" ; --Apertium
lin head_N = mkN "buru" ; --Apertium
lin hear_V2 = mkV2 "entzun" ; --Apertium
lin heart_N = mkN "bihotz" ; --Apertium
lin heavy_A = mkA "astun" ; --Apertium
lin hill_N = mkN "muino" ; --Apertium
lin hit_V2 = mkV2 "jo" ; --Apertium
lin hold_V2 = mkV2 "eutsi" ; --Apertium
lin hope_VS = lin VS (egonV "zain") ; --Apertium
lin horn_N = mkN "adar" ; --Apertium
lin horse_N = mkN "zaldi" ; --Apertium
lin hot_A = mkA "bero" ; --Apertium
lin house_N = mkN "etxe" ; --Apertium
lin hunt_V2 = mkV2 "ehizatu" ; -- | lin V2 (mkV "ehizan" AditzTrinkoak.ibiliNorNork) ; --Apertium
lin husband_N = mkN "senar" ; --Apertium

----
-- I

lin ice_N = mkN "izotz" ; --Apertium ; --Apertium
lin industry_N = mkN "industria" ; --Apertium
lin iron_N = mkN "burdina" ; -- | mkN "plantxa" ; --Apertium

--------
-- J - K

lin jump_V = mkV "jauzi" egin_V ; --Apertium
lin kill_V2 = mkV2 "hil" ; --Apertium
lin king_N = mkN "errege" ; --Apertium
lin knee_N = mkN "belaun" ; --Apertium
lin know_V2 = lin V2 jakin_V ; -- synthetic verb
lin know_VQ = lin VQ jakin_V ; -- synthetic verb

lin know_VS = ukanV "uste" ;


----
-- L

lin lake_N = mkN "aintzira" ; --Apertium
lin lamp_N = mkN "lanpara" ; --Apertium
lin language_N = mkN "hizkuntza" ; --Apertium
lin laugh_V = mkV "barre" egin_V ; --Apertium
lin leaf_N = mkN "orri" ; -- | mkN "hosto" ; --Apertium
lin learn_V2 = mkV2 "ikasi" ; --Apertium
lin leather_N = mkN "larru" ; --Apertium
lin leave_V2 = mkV2 "utzi" ; --| mkV2 "laga" ; --Apertium
lin leg_N = mkN "hanka" ; --Apertium
-- lin lie_V = mkVX "gezur8erran" ; --Apertium
-- lin lie_V = mkVX "gezurra8esan" ; --Apertium
--lin like_V2 = mkVX "gustatu" ; --Apertium -- NOR-NORI
-- lin like_V2 = mkVX "atsegin_izan" ; --Apertium
-- lin like_V2 = mkVX "atsegin8izan<per>" ; --Apertium
-- lin like_V2 = mkVX "gogoko8izan<per>" ; --Apertium
lin listen_V2 = mkV2 "entzun" ; --Apertium
lin live_V  = izanV "bizi" ;
lin liver_N = mkN "gibel" ; --Apertium
lin long_A = mkA "luze" ; --Apertium
lin lose_V2 = mkV2 "galdu" ; --Apertium
lin louse_N = mkN "zorri" ; --Apertium
lin love_N = mkN "maitasun" ; -- | mkN "amodio" ; --Apertium
lin love_V2 = ukanV "maite" ; 
lin man_N = mkN "gizon" ; --Apertium
lin meat_N = mkN "haragi" ; -- | mkN "mami" ; --Apertium
lin milk_N = mkN "esne" ; --Apertium
lin moon_N = mkN "ilargi" ; --Apertium
lin mother_N2 = mkN2 "ama" ;lin mountain_N = mkN "mendi" | mkN "mendi" ; --Apertium
lin mouth_N = mkN "aho" ; --Apertium
lin music_N = mkN "musika" ; --Apertium

------
-- N -


lin sea_N   = mkN "itsaso" ;
lin sleep_V = mkV "lo" egin_V ;



lin see_V2  = mkV2 "ikusi" ;


oper
  egin_V : V = mkV "egin" ;

  etorri_V : V = mkV "etorri" ; --TODO synthetic

  jakin_V : R.Verb = 
  	let jakin = mkVerbNorNork "jakin" ;
  	in  jakin ** { prc = table { R.Pres => [] ; -- synthetic forms for present in AditzTrinkoak.jakin!
      							 tns    => jakin.prc ! tns } ;
      			   val = R.NorNork R.Jakin  
      			 } ;

}