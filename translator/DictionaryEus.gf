--# -path=.:../basque

concrete DictionaryEus of Dictionary = CatEus ** open ParadigmsEus, ResEus, Prelude in {

-- SECTION: Adpositions

lin in_Prep = mkPrep "n" ;
lin with_Prep = mkPrep "z" | mkPrep "ekin" ;  -- split
lin from_Prep = mkPrep "tik" ;
lin to_Prep = mkPrep "ra" ;

-- SECTION: Adjectives

lin new_A = mkA "berri" ;
lin big_A = mkA "handi" ;
lin difficult_A = mkA "errazo" ;

-- SECTION: Nouns

lin aeroplane_N = mkN "hegazkin" ;
lin animal_N = mkN "animalia" ;
lin apartment_N = mkN "pisu" ;
lin apple_N = mkN "sagar" ;
lin art_N = mkN "arte" ;
lin beer_N = mkN "garagardo" ;
lin bike_N = mkN "bizikleta" ;
lin bird_N = mkN "txori" ;
lin blood_N = mkN "odol" ;
lin boat_N = mkN "itsasontzi" ;
lin bone_N = mkN "hezur" ;
lin book_N = mkN "liburu" ;
lin boot_N = mkN "bota" ;
lin boss_N = mkN "buru" ;
lin boy_N = mkN "mutil" ; 
lin bread_N = mkN "ogi" ;
lin brother_N = mkN "anai" | mkN "anaia" ; -- FIXME: Depends on gender of 'possessor'
lin butter_N = mkN "gurin" ;
lin cat_N = mkN "katu" ;
lin chair_N = mkN "aulki" ;
lin cheese_N = mkN "gazta" ;
lin child_N = mkN "ume" ;
lin church_N = mkN "eliza" ;
lin city_N = mkN "hiri" ;
lin cloud_N = mkN "hodei" ;
lin computer_N = mkN "ordenagailu" ;
lin country_N = mkN "herri" ;
lin day_N = mkN "egun" ;
lin doctor_N = mkN "mediku" | mkN "doktore" ; 
lin dog_N = mkN "txakur" ;
lin door_N = mkN "ate" ;
lin dust_N = mkN "hauts" ;
lin ear_N = mkN "belarri" ;
lin earth_N = mkN "lur" ;
lin egg_N = mkN "arrautza" ;
lin enemy_N = mkN "etsai" ;
lin eye_N = mkN "ojo" ;
lin factory_N = mkN "fabrika" | mkN "lantegi" ;
lin feather_N = mkN "luma" ;
lin fire_N = mkN "su" ;
lin fish_N = mkN "arrain" ;
lin floor_N = mkN "lurzoru" ;
lin flower_N = mkN "lore" ;
lin foot_N = mkN "oin" ;
lin force_N = mkN "indar" ;
lin fridge_N = mkN "elurtegi" ;
lin friend_N = mkN "lagun" ;
lin fruit_N = mkN "fruta" ; 
lin garden_N = mkN "lorategi" ;
lin girl_N = mkN "neska" ;
lin glove_N = mkN "eskularru" ;
lin gold_N = mkN "urre" ;
lin grammar_N = mkN "gramatika" ;
lin hand_N = mkN "esku" ;
lin harbour_N = mkN "portu" ;
lin head_N = mkN "buru" ;
lin heart_N = mkN "bihotz" ;
lin horse_N = mkN "zaldi" ;
lin house_N = mkN "etxe" ; 
lin ice_N = mkN "izotz" ;
lin industry_N = mkN "industria" ;
lin iron_N = mkN "burdina" ; -- FIXME: Check
lin lake_N = mkN "aintzira" ;
lin lamp_N = mkN "lanpara" ;
lin language_N = mkN "hizkuntza" ;
lin leg_N = mkN "hanka" ;
lin light_N = mkN "argi" ;
lin love_N = mkN "maitasun" ;
lin man_N = mkN "gizon" ;
lin meat_N = mkN "haragi" ;
lin milk_N = mkN "esne" ;
lin moon_N = mkN "ilargi" ;
lin mountain_N = mkN "mendi" ;
lin mouth_N = mkN "aho" ;
lin music_N = mkN "musika" ;
lin name_N = mkN "izen" ;
lin neck_N = mkN "lepo" ;
lin newspaper_N = mkN "egunkari" ;
lin night_N = mkN "gau" ;
lin nose_N = mkN "sudur" ;
lin number_N = mkN "zenbaki" ;
lin paper_N = mkN "paper" ;
lin peace_N = mkN "bake" ;
lin person_N = mkN "pertsona" ;
lin planet_N = mkN "planeta" ;
lin plastic_N = mkN "plastiko" ;
lin policeman_N = mkN "ertzain" ;
lin question_N = mkN "galdera" ;
lin radio_N = mkN "erradio" ;
lin rain_N = mkN "euri" ;
lin religion_N = mkN "erlijio" ;
lin restaurant_N = mkN "janetxe" ;
lin river_N = mkN "ibai" ;
lin road_N = mkN "kale" ; -- FIXME: errepide[?]
lin rock_N = mkN "arroka" ; 
lin roof_N = mkN "teilatu" ;
lin root_N = mkN "erro" ;
lin rope_N = mkN "korda" ;
lin rule_N = mkN "erregela" ;
lin salt_N = mkN "gatz" ;
lin sand_N = mkN "harea" ;
lin school_N = mkN "eskola" ;
lin science_N = mkN "zientzia" ;
lin sea_N = mkN "itsaso" ;
lin seed_N = mkN "hazi" ;
lin ship_N = mkN "ontzi" ;
lin shirt_N = mkN "alkandora" ;
lin shoe_N = mkN "zapata" ;
lin shop_N = mkN "denda" ;
lin silver_N = mkN "zilar" ;
lin sister_N = mkN "aizpa" | mkN "arreba" ; -- FIXME: Depends on gender of 'possessor'
lin skin_N = mkN "larru" ;
lin sky_N = mkN "zeru" ;
lin smoke_N = mkN "ke" ;
lin snake_N = mkN "suge" ;
lin snow_N = mkN "elur" ;
lin sock_N = mkN "galtzetin" ;
lin song_N = mkN "kanta" ;
lin star_N = mkN "izar" ;
lin stick_N = mkN "palo" ;
lin stone_N = mkN "harri" ;
lin student_N = mkN "ikasle" ;
lin sun_N = mkN "eguzki" ;
lin table_N = mkN "mahai" ;
lin teacher_N = mkN "irakasle" ;
lin television_N = mkN "telebista" ;
lin time_N = mkN "denbora" ;  
lin tooth_N = mkN "hortz" ;
lin train_N = mkN "tren" ;
lin tree_N = mkN "zuhaitz" ;
lin university_N = mkN "unibertsitate" ;
lin village_N = mkN "herrixka" ;
lin war_N = mkN "gerra" ;
lin water_N = mkN "ur" FinalCons ;
lin wind_N = mkN "haize" ;
lin window_N = mkN "leiho" ;
lin wine_N = mkN "ardo" ;
lin wing_N = mkN "hegal" ;
lin woman_N = mkN "emakume" ;
lin worm_N = mkN "har" ;
lin year_N = mkN "urte" ;

lin back_N = mkN "bizkar" ;
lin belly_N = mkN "urdail" ;
lin breast_N = mkN "bular" ;
lin husband_N = mkN "senar" ;
lin leaf_N = mkN "orri" ;
lin tail_N = mkN "buztan" ;
lin tongue_N = mkN "mihi" ;
lin wife_N = mkN "emazte" ;

-- SECTION: Adverbs 

lin now_Adv = mkAdv "orain" ;

-- SECTION: Verbs

lin walk_V = mkV "ibili" ;
lin fall_V = mkV "amildu" ;

lin see_V2  = mkV2 "ikusi" ;

-- SECTION: TODO

-- lin cousin_N = mkN "lehengusu" ;
-- lin priest_N = mkN "apaiz" | mkN "artzain" ; -- FIXME: split

-- lin ceiling_N = mkN "sabai" ;
-- lin baby_N = mkN "baby" ;
-- lin bank_N = mkN "bank" ;
-- lin camera_N = mkN "camera" ;
-- lin cap_N = mkN "cap" ;
-- lin car_N = mkN "car" ;
-- lin carpet_N = mkN "carpet" ;
-- lin coat_N = mkN "coat" ;
-- lin cow_N = mkN "cow" ;
-- lin distance_N3 = mkN3 (mkN "distance") fromP toP ;
-- lin brother_N2 = mkN2 (mkN masculine (mkN "brother")) (mkPrep "of") ;
-- lin father_N2 = mkN2 (mkN masculine (mkN "father")) (mkPrep "of") ;
-- lin mother_N2 = mkN2 (mkN feminine (mkN "mother")) (mkPrep "of") ;
-- lin hat_N = mkN "hat" ;
-- lin hill_N = mkN "hill" ;
-- lin king_N = mkN masculine (mkN "king") ;
-- lin leather_N = mkN "leather" ;
-- lin oil_N = mkN "oil" ;
-- lin pen_N = mkN "pen" ;
-- lin queen_N = mkN feminine (mkN "queen") ;
-- lin rubber_N = mkN "rubber" ;
-- lin sheep_N = mk2N "sheep" "sheep" ;
-- lin steel_N = mkN "steel" ;
-- lin stove_N = mkN "stove" ;
-- lin wood_N = mkN "wood" ;
-- lin ashes_N = mkN "ash" ; -- FIXME: plural only?
-- lin bark_N = mkN "bark" ;
-- lin fat_N = mkN "fat" ;
-- lin fingernail_N = mkN "fingernail" ;
-- lin fog_N = mkN "fog" ;
-- lin forest_N = mkN "forest" ;
-- lin grass_N = mkN "grass" ;
-- lin guts_N = mkN "gut" ; -- FIXME: no singular
-- lin hair_N = mkN "hair" ;
-- lin horn_N = mkN "horn" ;
-- lin knee_N = mkN "knee" ;
-- lin liver_N = mkN "liver" ;
-- lin louse_N = mk2N "louse" "lice" ;
-- lin reason_N = mkN "reason" ;
}

