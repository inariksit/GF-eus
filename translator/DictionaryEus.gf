--# -path=.:../basque

concrete DictionaryEus of Dictionary = CatEus ** open ParadigmsEus, ResEus, Prelude in {

-- SECTION: Adpositions

lin in_Prep = mkPrep "n" ;
lin from_Prep = mkPrep "tik" ;
lin to_Prep = mkPrep "ra" ;
lin with_Prep = mkPrep "z" | mkPrep "ekin" ;  -- split
lin of_Prep = mkPrep "ko" | mkPrep "ren" ;
lin for_Prep = mkPrep "entzat" ;
lin because_of_Prep = mkPrep "gatik" ;

-- SECTION: Adjectives

lin new_A = mkA "berri" ;
lin big_A = mkA "handi" ;
lin green_A = mkA "berde" ; 
lin difficult_A = mkA "errazo" ;
lin bad_A = mkA "txar" ;
lin beautiful_A = mkA "polit" ;
lin black_A = mkA "beltz" ;
lin blue_A = mkA "urdin" ;
lin broad_A = mkA "zabal" ;
lin brown_A = mkA "marroi" ;
lin clean_A = mkA "garbi" ;
lin clever_A = mkA "azkar" ;
lin cold_A = mkA "hotz" ;
lin correct_A = mkA "zuzen" ;
lin dirty_A = mkA "zikin" ;
lin dry_A = mkA "lehor" ;
lin dull_A = mkA "aspergarri" ;
lin empty_A = mkA "huts" ;
lin full_A = mkA "bete" ;
lin good_A = mkA "on" | mkA "hobe" ; 
lin heavy_A = mkA "astun" ;
lin hot_A = mkA "bero" ;
lin important_A = mkA "garrantzizko" ;
lin long_A = mkA "luze" ;
lin narrow_A = mkA "estu" ;
lin near_A = mkA "hurbil" ;
lin old_A = mkA "zahar" ;
lin ready_A = mkA "prest" ;
lin red_A = mkA "gorri" ;
lin rotten_A = mkA "ustel" ;
lin round_A = mkA "biribil" ;
lin sharp_A = mkA "zorrotz" ;
lin small_A = mkA "txiki" ;
lin smooth_A = mkA "leun" ;
lin straight_A = mkA "zuzen" ;
lin stupid_A = mkA "ergel" ;
lin thick_A = mkA "lodi" ;
lin thin_A = mkA "argal" | mkA "mehe" ;
lin ugly_A = mkA "itsusi" ;
lin uncertain_A = mkA "gezur" ;
lin warm_A = mkA "bero" ;
lin wet_A = mkA "busti" ;
lin white_A = mkA "zuri" ;
lin wide_A = mkA "zabal" ;
lin yellow_A = mkA "hori" ;
lin young_A = mkA "gazte" ;

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

lin baby_N = mkN "ume" ; -- FIXME: see child_N
lin back_N = mkN "bizkar" ;
lin bank_N = mkN "banku" ;
lin bark_N = mkN "azal"  ; -- FIXME: ladrido
lin belly_N = mkN "urdail" ;
lin breast_N = mkN "bular" ;
lin camera_N = mkN "kamera" ;
lin cap_N = mkN "txapel" | mkN "tapoi" ; 
lin car_N = mkN "automobil" ;
lin carpet_N = mkN "alfonbra" ;
lin ceiling_N = mkN "sabai" ;
lin coat_N = mkN "beroki" ;
lin cousin_N = mkN "lehengusu" ;
lin cow_N = mkN "behi" ;
lin fat_N = mkN "gantz" ;
lin fingernail_N = mkN "azazkal" ;
lin fog_N = mkN "laino" ;
lin forest_N = mkN "baso" ;
lin grass_N = mkN "belar" ;
lin hair_N = mkN "ile" | mkN "adats" ;
lin hat_N = mkN "kapela" ;
lin hill_N = mkN "muino" ;
lin horn_N = mkN "adar" ;
lin husband_N = mkN "senar" ;
lin king_N = mkN "errege" ;
lin knee_N = mkN "belaun" ;
lin leaf_N = mkN "orri" ;
lin leather_N = mkN "larru" ;
lin liver_N = mkN "gibel" ;
lin louse_N = mkN "zorri" ;
lin oil_N = mkN "olio" ;
lin pen_N = mkN "boligrafo" ;
lin priest_N = mkN "apaiz" | mkN "artzain" ; -- FIXME: split
lin queen_N = mkN "erregina" ;
lin reason_N = mkN "arrazoi" ;
lin rubber_N = mkN "goma" ;
lin sheep_N = mkN "ardi" ;
lin steel_N = mkN "altzairu" ;
lin stove_N = mkN "berogailu" ;
lin tail_N = mkN "buztan" ;
lin tongue_N = mkN "mihi" ;
lin wife_N = mkN "emazte" ;
lin wood_N = mkN "zur" ; -- FIXME: leña, bosque

lin winner_N = mkN "irabazle" ; 
lin story_N = mkN "historia" ; 

-- lin brother_N2 = mkN2 (mkN masculine (mkN "brother")) (mkPrep "of") ;
-- lin father_N2 = mkN2 (mkN masculine (mkN "father")) (mkPrep "of") ;
-- lin mother_N2 = mkN2 (mkN feminine (mkN "mother")) (mkPrep "of") ;
-- lin ashes_N = mkN "ash" ; -- FIXME: plural only?
-- lin guts_N = mkN "gut" ; -- FIXME: no singular
-- lin distance_N3 = mkN3 (mkN "distantzia") fromP toP ;

-- SECTION: Adverbs 

lin now_Adv = mkAdv "orain" ;
lin again_Adv = mkAdv "berriz" ; 

-- SECTION: Verbs

lin walk_V = mkV "ibili" ;
lin fall_V = mkV "amildu" ;
lin die_V = mkV "hil" ;
lin travel_V = mkV "bidaiatu" ;

lin see_V2  = mkV2 "ikusi" ;
lin learn_V2 = mkV2 "ikasi" ;
lin write_V2 = mkV2 "idatzi" ;
lin hit_V2 = mkV2 "jo" ;
lin drink_V2 = mkV2 "edan" ;

-- lin like_V2 = mkVX "gustatu" ; -- NOR-NORI

lin pay_V3  = mkV3 "igorri" ;

-- Section: TODO

-- lin add_V3 = mkVX "erantsi" ;
-- lin add_V3 = mkVX "gaineratu" ;
-- lin add_V3 = mkVX "gehitu" ;
-- lin answer_V2S = mkVX "erantzun" ;
-- lin ask_V2Q = mkVX "eskatu" ;
-- lin ask_V2Q = mkVX "galdegin" ;
-- lin ask_V2Q = mkVX "galdetu" ;
-- lin become_VA = mkVX "bihurtu" ;
-- lin become_VA = mkVX "gertatu" ;
-- lin beg_V2V = mkVX "erregutu" ;
-- lin beg_V2V = mkVX "eske_ibili" ;
-- lin bite_V2 = mkVX "ausiki" ;
-- lin break_V2 = mkVX "eten" ;
-- lin break_V2 = mkVX "hautsi" ;
-- lin break_V2 = mkVX "hondatu" ;
-- lin break_V2 = mkVX "izorratu" ;
-- lin breathe_V = mkVX "arnastu" ;
-- lin burn_V = mkVX "erre" ;
-- lin burn_V = mkVX "kiskali" ;
-- lin close_V2 = mkVX "gerturatu" ;
-- lin close_V2 = mkVX "itxi" ;
-- lin close_V2 = mkVX "zarratu" ;
-- lin count_V2 = mkVX "kontatu" ;
-- lin count_V2 = mkVX "zenbatu" ;
-- lin cut_V2 = mkVX "ebaki" ;
-- lin cut_V2 = mkVX "moztu" ;
-- lin eat_V2 = mkVX "bazkaldu" ;
-- lin eat_V2 = mkVX "jan" ;
-- lin fall_V = mkVX "amildu" ;
-- lin fall_V = mkVX "erori" ;
-- lin fight_V2 = mkVX "borrokatu" ;
-- lin find_V2 = mkVX "aurkitu" ;
-- lin find_V2 = mkVX "topatu" ;
-- lin float_V = mkVX "flotatu" ;
-- lin flow_V = mkVX "jariatu" ;
-- lin fly_V = mkVX "pilotatu" ;
-- lin forget_V2 = mkVX "ahaztu" ;
-- lin freeze_V = mkVX "izoztu" ;
-- lin hate_V2 = mkVX "gorrotatu" ;
-- lin hear_V2 = mkVX "entzun" ;
-- lin hold_V2 = mkVX "eutsi" ;
-- lin hunt_V2 = mkVX "ehizan_ibili" ;
-- lin hunt_V2 = mkVX "ehizatu" ;
-- lin kill_V2 = mkVX "erail" ;
-- lin kill_V2 = mkVX "ero" ;
-- lin kill_V2 = mkVX "hil" ;
-- lin know_V2 = mkVX "ezagutu" ;
-- lin know_V2 = mkVX "jakin" ;
-- lin leave_V2 = mkVX "joan" ;
-- lin leave_V2 = mkVX "laga" ;
-- lin leave_V2 = mkVX "utzi" ;
-- lin like_V2 = mkVX "atsegin_izan" ;
-- lin listen_V2 = mkVX "entzun" ;
-- lin live_V = mkVX "bizi_izan" ;
-- lin lose_V2 = mkVX "galdu" ;
-- lin open_V2 = mkVX "ireki" ;
-- lin open_V2 = mkVX "zabaldu" ;
-- lin paint_V2A = mkVX "margotu" ;
-- lin paint_V2A = mkVX "pintatu" ;
-- lin play_V = mkVX "interpretatu" ;
-- lin play_V = mkVX "jokatu" ;
-- lin play_V = mkVX "jolastu" ;
-- lin pull_V2 = mkVX "tenkatu" ;
-- lin pull_V2 = mkVX "tiratu" ;
-- lin push_V2 = mkVX "bultzatu" ;
-- lin push_V2 = mkVX "estutu" ;
-- lin put_V2 = mkVX "ezarri" ;
-- lin put_V2 = mkVX "jarri" ;
-- lin put_V2 = mkVX "paratu" ;
-- lin put_V2 = mkVX "sartu" ;
-- lin read_V2 = mkVX "irakurri" ;
-- lin rub_V2 = mkVX "igurtzi" ;
-- lin run_V = mkVX "funtzionatu" ;
-- lin run_V = mkVX "korritu" ;
-- lin say_VS = mkVX "erran" ;
-- lin scratch_V2 = mkVX "urratu" ;
-- lin seek_V2 = mkVX "bilatu" ;
-- lin sell_V3 = mkVX "saldu" ;
-- lin send_V3 = mkVX "bidali" ;
-- lin send_V3 = mkVX "igorri" ;
-- lin sew_V = mkVX "josi" ;
-- lin sing_V = mkVX "kantatu" ;
-- lin sit_V = mkVX "eseri" ;
-- lin sit_V = mkVX "jarri" ;
-- lin smell_V = mkVX "usain_izan" ;
-- lin speak_V2 = mkVX "mintzatu" ;
-- lin split_V2 = mkVX "pitzatu" ;
-- lin split_V2 = mkVX "zatitu" ;
-- lin squeeze_V2 = mkVX "estutu" ;
-- lin stab_V2 = mkVX "sastatu" ;
-- lin stand_V = mkVX "egon" ;
-- lin stand_V = mkVX "eutsi" ;
-- lin stand_V = mkVX "jarri" ;
-- lin stop_V = mkVX "atxilotu" ;
-- lin stop_V = mkVX "geldiarazi" ;
-- lin stop_V = mkVX "gelditu" ;
-- lin stop_V = mkVX "geratu" ;
-- lin suck_V2 = mkVX "edoski" ;
-- lin suck_V2 = mkVX "xurgatu" ;
-- lin suck_V2 = mkVX "zupatu" ;
-- lin swell_V = mkVX "handitu" ;
-- lin talk_V3 = mkVX "mintzatu" ;
-- lin teach_V2 = mkVX "erakutsi" ;
-- lin teach_V2 = mkVX "irakatsi" ;
-- lin think_V = mkVX "iritzi" ;
-- lin think_V = mkVX "pentsatu" ;
-- lin throw_V2 = mkVX "aurtiki" ;
-- lin throw_V2 = mkVX "bota" ;
-- lin throw_V2 = mkVX "jaurti" ;
-- lin throw_V2 = mkVX "tiratu" ;
-- lin tie_V2 = mkVX "lotu" ;
-- lin turn_V = mkVX "biratu" ;
-- lin turn_V = mkVX "jiratu" ;
-- lin wait_V2 = mkVX "itxaron" ;
-- lin wash_V2 = mkVX "garbitu" ;
-- lin watch_V2 = mkVX "begiratu" ;
-- lin win_V2 = mkVX "garaitu" ;
-- lin win_V2 = mkVX "irabazi" ;
-- lin wipe_V2 = mkVX "garbitu" ;

-- SECTION: Verbs amb egin etc.

-- lin bite_V2 = mkVX "kosk8egin" ;
-- lin blow_V = mkVX "putz8egin" ;
-- lin breathe_V = mkVX "arnasa8hartu" ;
-- lin fly_V = mkVX "hegan8egin" ;
-- lin hope_VS = mkVX "zain8egon" ;
-- lin jump_V = mkVX "jauzi8egin" ;
-- lin laugh_V = mkVX "barre8egin" ;
-- lin laugh_V = mkVX "irri8egin" ;
-- lin leave_V2 = mkVX "alde8egin" ;
-- lin lie_V = mkVX "gezur8erran" ;
-- lin lie_V = mkVX "gezurra8esan" ;
-- lin play_V = mkVX "berriz8gertatu" ;
-- lin pull_V2 = mkVX "tira8egin" ;
-- lin rain_V0 = mkVX "euria8ari8edun" ;
-- lin run_V = mkVX "korrika8egin" ;
-- lin sleep_V = mkVX "lo8egin" ;
-- lin smell_V = mkVX "usain8hartu" ;
-- lin speak_V2 = mkVX "hitz8egin" ;
-- lin spit_V = mkVX "txistua8bota" ;
-- lin swim_V = mkVX "igeri8egin" ;
-- lin talk_V3 = mkVX "hitz8egin" ;
-- lin think_V = mkVX "gogoeta8egin" ;
-- lin throw_V2 = mkVX "tira8egin" ;
-- lin vomit_V = mkVX "oka8egin" ;
-- lin wait_V2 = mkVX "zain8egon" ;

-- SECTION: Verbs amb izan

-- lin die_V = mkVX "hil8izan<per>" ;
-- lin fear_V2 = mkVX "beldur8izan<per>" ;
-- lin hate_V2 = mkVX "gorroto8izan<per>" ;
-- lin hope_VS = mkVX "espero8izan<per>" ;
-- lin like_V2 = mkVX "atsegin8izan<per>" ;
-- lin like_V2 = mkVX "gogoko8izan<per>" ;
-- lin live_V = mkVX "bizi8izan<per>" ;
-- lin love_V2 = mkVX "maite8izan<per>" ;
-- lin love_V2 = mkVX "nahi8izan<per>" ;
-- lin stand_V = mkVX "ari8izan<per>" ;

-- SECTION: Aditz trinkoak 

-- lin buy_V2 = mkV2 "erosi" ;
-- lin buy_V2 = mkVX "erosi<sint>" ;

-- lin come_V = mkVX "etorri" ;
-- lin come_V = mkVX "etorri<sint>" ;

-- lin do_V2 = mkVX "egin" ;
-- lin do_V2 = mkVX "egin<sint>" ;
-- lin do_V2 = mkVX "jardun<sint>" ;

-- lin fight_V2 = mkVX "iharduki<sint>" ;
-- lin flow_V = mkVX "jario<sint>" ;

-- lin give_V3 = mkVX "eman" ;
-- lin give_V3 = mkVX "eman<sint>" ;

-- lin go_V = mkVX "joan" ;
-- lin go_V = mkVX "joan<sint>" ;

-- lin hold_V2 = mkVX "eutsi<sint>" ;
-- lin know_V2 = mkVX "ezagutu<sint>" ;
-- lin know_V2 = mkVX "jakin<sint>" ;
-- lin leave_V2 = mkVX "utzi<sint>" ;
-- lin listen_V2 = mkVX "entzun<sint>" ;
-- lin say_VS = mkVX "erran<sint>" ;

-- lin say_VS = mkVX "esan" ;
-- lin say_VS = mkVX "esan<sint>" ;

-- lin see_V2 = mkVX "ikusi<sint>" ;
-- lin send_V3 = mkVX "igorri<sint>" ;
-- lin think_V = mkVX "iritzi<sint>" ;

-- lin understand_V2 = mkVX "aditu" ;
-- lin understand_V2 = mkVX "ulertu" ;
-- lin understand_V2 = mkVX "aditu<sint>" ;

-- lin walk_V = mkVX "ibili" ;
-- lin walk_V = mkVX "ibili<sint>" ;

}

