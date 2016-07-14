concrete StructuralEus of Structural = CatEus ** open Prelude, ResEus, ParadigmsEus in {

  lin and_Conj = mkConj "eta" ; 
  lin or_Conj  = mkConj "edo" | mkConj "ala" ; 
  lin but_PConj    = lin PConj (ss "baina") ;

  lin for_Prep = mkPrep "rentzat" ;
  lin from_Prep = mkPrep "tik" ;
  lin in_Prep = mkPrep "n" ;
  lin to_Prep = mkPrep "ra" ;
  lin with_Prep = mkPrep "z" ;
  lin without_Prep = mkPrep "gabe" ParNP False | mkPrep "gabe" AbsNP False ; 


  lin i_Pron = mkPron "ni" "niri" "nik" Ni ;
  lin we_Pron = mkPron "gu" "guri" "guk" Gu ;
  lin youSg_Pron = mkPron "zu" "zuri" "zuk" Zu ; -- TODO: hi/hire
  lin youPl_Pron = mkPron "zuek" "zuei" "zuen" Zuek ;
  lin he_Pron = mkPron "hau" "honi" "honek" Hau ; -- TODO: the others
  lin she_Pron = mkPron "hau" "honi" "honek" Hau ; -- TODO: the others
  lin it_Pron = mkPron "hau" "honi" "honek" Hau ; -- TODO: the others
  lin they_Pron = mkPron "hauek" "hauei" "hauek" Hauek ; -- TODO: the others


  
}
