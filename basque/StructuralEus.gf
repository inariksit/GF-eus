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


  lin i_Pron = mkPron "ni" "niri" "nik" "nire" Ni ;
  lin we_Pron = mkPron "gu" "guri" "guk" "gure" Gu ;
  lin youSg_Pron = mkPron "zu" "zuri" "zuk" "zure" Zu ; -- TODO: hi/hire
  lin youPl_Pron = mkPron "zuek" "zuei" "zuen" "zuen" Zuek ;
  lin he_Pron = mkPron "hau" "honi" "honek" "bere" Hau ; -- TODO: the others
  lin she_Pron = mkPron "hau" "honi" "honek" "bere" Hau ; -- TODO: the others
  lin it_Pron = mkPron "hau" "honi" "honek" "bere" Hau ; -- TODO: the others
  lin they_Pron = mkPron "hauek" "hauei" "hauek" "beren" Hauek ; -- TODO: the others
 
  lin whatPl_IP = (mkIP "zertzuk" "zertzuei" "zertzuek")
                    ** { agr  = Hauek ;
                         anim = Inan ;
                         nbr  = Pl } ;
  lin whatSg_IP = (mkIP "zer" "zeri" "zerk")
                    ** { agr  = Hau ;
                         anim = Inan ;
                         nbr  = Sg } ;
  lin whoPl_IP = (mkIP "nortzuk" "nortzuei" "nortzuek")
                    ** { agr  = Hauek ;
                         anim = Anim ;
                         nbr  = Pl } ;
  lin whoSg_IP = (mkIP "nor" "nori" "nork")
                    ** { agr  = Hau ;
                         anim = Anim ;
                         nbr  = Sg } ;



oper 
  mkIP : Str -> Str -> Str -> {s : Case => Str ; isDef : Bool} ;
  mkIP nor nori nork = { s = table { Abs => nor ;
                                     Dat => nori ;
                                     Erg => nork ;
                                     Part => []} ;
                         isDef = True
                       } ;
}
