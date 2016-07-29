concrete StructuralEus of Structural = CatEus ** open Prelude, ResEus, ParadigmsEus in {

  lin and_Conj = mkConj "eta" ; 
  lin or_Conj  = mkConj "edo" | mkConj "ala" ; 
  lin but_PConj    = lin PConj (ss "baina") ;



  lin above_Prep = mkPrep "gainean" Abs False ;
 -- lin after_Prep : Prep ;
  lin before_Prep = mkPrep "gabe" Abs False ;
  lin behind_Prep = mkPrep "atzean" Gen False ;
  lin between_Prep = mkPrep "artean" Gen False ; --`bitartean' for time
  lin by8agent_Prep = casePrep Erg ;
  lin by8means_Prep = casePrep Ins ;
  lin during_Prep = mkPrep "an" LocStem ; --- ???
  lin except_Prep = mkPrep "gain" Soc False ;
  lin for_Prep = mkPrep "tzat" Gen ;
  lin from_Prep = mkPrep "tik" LocStem ; --- ?
  lin in8front_Prep = mkPrep "aurrean" Gen False ;
  lin in_Prep = casePrep Ine ;
  lin on_Prep = mkPrep "gainean" Gen False ; 
  lin part_Prep = casePrep Par ; 
  lin possess_Prep = casePrep Gen ;
  lin through_Prep = mkPrep "an barrena" LocStem ; -- ?
  lin to_Prep = casePrep Dat ; --"I gave it to Fran", not "I went to school"
  lin under_Prep = mkPrep "azpian" Gen False ;
  lin with_Prep = casePrep Soc ;
  lin without_Prep = mkPrep "gabe" Abs False ; 


  lin i_Pron = persPron "ni" "niri" "nik" "nire" "nitaz" Ni ;
  lin we_Pron = persPron "gu" "guri" "guk" "gure" "gutaz" Gu ;
  lin youSg_Pron = persPron "zu" "zuri" "zuk" "zure" "zutaz" Zu ; -- TODO: hi/hire
  lin youPl_Pron = persPron "zuek" "zuei" "zuen" "zuen" "zuetaz" Zuek ;
  lin he_Pron = persPron "hura" "hari" "hark" "haren" "hartaz" Hau ;
  lin she_Pron = persPron "hura" "hari" "hark" "haren" "hartaz" Hau ;
  lin it_Pron = persPron "hau" "honi" "honek" "bere" "honetaz" Hau ;
  lin they_Pron = persPron "hauek" "hauei" "hauek" "beren" "hauetaz" Hauek ; -- TODO: the others
 
  lin whatPl_IP = inanPron "zertzuk" "zertzuei" "zertzuek" "zertzuen" "zertzuetaz" Hauek ;
  lin whatSg_IP = inanPron "zer" "zeri" "zerk" "zeren" "zertaz" Hau ;
  lin whoPl_IP = persPron "nortzuk" "nortzuei" "nortzuek" "nortzuen" "nortzuetaz" Hauek ;
  lin whoSg_IP = persPron "nor" "nori" "nork" "noren" "zertaz" Hau ;

}
