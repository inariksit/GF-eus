concrete StructuralEus of Structural = CatEus ** open Prelude, ResEus, ParadigmsEus in {

  lin and_Conj = mkConj "eta" ; 
  lin or_Conj  = mkConj "edo" | mkConj "ala" ; 
  lin but_PConj    = lin PConj (ss "baina") ;






  lin above_Prep = mkPrep "gainean" Abs False ;
 -- lin after_Prep : Prep ;
  lin before_Prep = mkPrep "gabe" Abs False ;
  lin behind_Prep = mkPrep "atzean" Gen False ;
  lin between_Prep = mkPrep "artean" Gen False ; --`bitartean' for time
  lin by8agent_Prep = mkPrep [] Erg False ;  -- choose Erg case, add empty string without BIND
  lin by8means_Prep = mkPrep "z" ; -- by (means of)
  lin during_Prep = mkPrep "n" ; --- ???
  lin except_Prep = mkPrep "z gain" ; --- ???
  lin for_Prep = mkPrep "tzat" Gen ;
  lin from_Prep = mkPrep "tik" ;
  lin in8front_Prep = mkPrep "aurrean" Gen False ;
  lin in_Prep = mkPrep "n" ;
  lin on_Prep = mkPrep "gainean" Gen False ; 
  lin part_Prep = mkPrep [] Par False ; -- choose Par case, add empty string without BIND
  lin possess_Prep = mkPrep [] Gen False ; -- choose Gen case, add empty string without BIND
  lin through_Prep = mkPrep "n barrena" ; -- ???
  lin to_Prep = mkPrep "ra" ;
  lin under_Prep = mkPrep "azpian" Gen False ;
  lin with_Prep = mkPrep "kin"  ;
  lin without_Prep = mkPrep "gabe" Abs False ; 


  lin i_Pron = mkPron "ni" "niri" "nik" "nire" Ni ;
  lin we_Pron = mkPron "gu" "guri" "guk" "gure" Gu ;
  lin youSg_Pron = mkPron "zu" "zuri" "zuk" "zure" Zu ; -- TODO: hi/hire
  lin youPl_Pron = mkPron "zuek" "zuei" "zuen" "zuen" Zuek ;
  lin he_Pron = mkPron "hau" "honi" "honek" "bere" Hau ; -- TODO: the others
  lin she_Pron = mkPron "hau" "honi" "honek" "bere" Hau ; -- TODO: the others
  lin it_Pron = mkPron "hau" "honi" "honek" "bere" Hau ; -- TODO: the others
  lin they_Pron = mkPron "hauek" "hauei" "hauek" "beren" Hauek ; -- TODO: the others
 
  lin whatPl_IP = (mkIP "zertzuk" "zertzuei" "zertzuek" "zertzuk.GEN")
                    ** { agr  = Hauek ;
                         anim = Inan ;
                         nbr  = Pl } ;
  lin whatSg_IP = (mkIP "zer" "zeri" "zerk" "zeren")
                    ** { agr  = Hau ;
                         anim = Inan ;
                         nbr  = Sg } ;
  lin whoPl_IP = (mkIP "nortzuk" "nortzuei" "nortzuek" "nortzuk.GEN")
                    ** { agr  = Hauek ;
                         anim = Anim ;
                         nbr  = Pl } ;
  lin whoSg_IP = (mkIP "nor" "nori" "nork" "noren")
                    ** { agr  = Hau ;
                         anim = Anim ;
                         nbr  = Sg } ;



oper 
  mkIP : (_,_,_,x4 : Str) -> {s : Case => Str ; isDef : Bool} ;
  mkIP nor nori nork noren  = { s = table
                                   { Abs => nor ;
                                     Dat => nori ;
                                     Erg => nork ;
                                     Gen => noren ;
                                     Part => []} ;
                         isDef = True
                       } ;
}
