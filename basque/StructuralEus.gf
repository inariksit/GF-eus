concrete StructuralEus of Structural = CatEus ** open Prelude, (R=ResEus), ParadigmsEus in {

-------
-- Conj

lin and_Conj = mkConj "eta" pl ; 
lin or_Conj  = mkConj "edo" sg ; --| mkConj "ala" sg ; 
lin but_PConj  = lin PConj (ss "baina") ;

-------
-- Ad*

lin very_AdA = mkAdA "oso" ;
-- lin as_CAdv = { s = [] ; p = [] } ;
lin less_CAdv = { s = "gutxiago" ; p = [] } ;
lin more_CAdv = { s = "gehiago" ; p = [] } ;

lin how_IAdv = ss "nola" ;
lin how8much_IAdv = ss "zerbait" ;
lin when_IAdv = ss "noiz" ;
lin where_IAdv = ss "non" ;
lin why_IAdv = ss "zergatik" ;

lin everywhere_Adv = ss "nonahi" ;
lin here7from_Adv = ss "hemendik" ;
lin here7to_Adv = ss "hona" ;
lin here_Adv = ss "hemen" ;
lin quite_Adv = ss "nahiko" ;
lin somewhere_Adv = ss "nonbait" ;
lin there7from_Adv = ss "hortik" ;
lin there7to_Adv = ss "horra" ;
lin there_Adv = ss "hor" ;

-------
-- Prep

lin above_Prep = mkPrep "gainean" ;
 -- lin after_Prep : Prep ;
lin before_Prep = mkPrep "gabe" absolutive ;
lin behind_Prep = mkPrep "atzean"  ;
lin between_Prep = mkPrep "artean"  ; --`bitartean' for time
lin by8agent_Prep = mkPrep [] ergative ; -- choose just case, no separate postposition
lin by8means_Prep = mkPrep [] instrumental ;
lin during_Prep = mkPrep [] inessive ; --- ???
lin except_Prep = mkPrep "gain" sociative ;
lin for_Prep = affixPrep "tzat" genitive ;
lin from_Prep = locPrep "tik" ; --- ?
lin in8front_Prep = mkPrep "aurrean"  ;
lin in_Prep = mkPrep [] inessive ;
lin on_Prep = mkPrep "gainean"   ; 
lin part_Prep = mkPrep [] partitive ; 
lin possess_Prep = mkPrep []  ;
lin through_Prep = mkPrep "barrena" inessive  ; -- ?
lin to_Prep = mkPrep [] dative ; --"I gave it to Fran", not "I went to school"
lin under_Prep = mkPrep "azpian"   ;
lin with_Prep = mkPrep [] sociative ;
lin without_Prep = mkPrep "gabe" absolutive ; 


-------
-- Pron

-- Pronouns are closed class, no constructor in ParadigmsEus.

lin i_Pron = R.persPron "ni" "niri" "nik" "nire" "nitaz" R.Ni ;
lin we_Pron = R.persPron "gu" "guri" "guk" "gure" "gutaz" R.Gu ;
lin youSg_Pron = R.persPron "zu" "zuri" "zuk" "zure" "zutaz" R.Zu ; -- in Extra: hi/hire
lin youPl_Pron = R.persPron "zuek" "zuei" "zuen" "zuen" "zuetaz" R.Zuek ;
lin he_Pron = R.persPron "hura" "hari" "hark" "haren" "hartaz" R.Hau ;
lin she_Pron = R.persPron "hura" "hari" "hark" "haren" "hartaz" R.Hau ;
lin it_Pron = R.persPron "hau" "honi" "honek" "bere" "honetaz" R.Hau ;
lin they_Pron = R.persPron "hauek" "hauei" "hauek" "beren" "hauetaz" R.Hauek ; -- in Extra: other forms
 
lin whatPl_IP = R.inanPron "zertzuk" "zertzuei" "zertzuek" "zertzuen" "zertzuetaz" R.Hauek ;
lin whatSg_IP = R.inanPron "zer" "zeri" "zerk" "zeren" "zertaz" R.Hau ;
lin whoPl_IP = R.persPron "nortzuk" "nortzuei" "nortzuek" "nortzuen" "nortzuetaz" R.Hauek ;
lin whoSg_IP = R.persPron "nor" "nori" "nork" "noren" "zertaz" R.Hau ;

  --lin although_Subj : Subj ;
lin because_Subj  = mkSubj "lako" False ;
lin if_Subj = mkSubj "ba" True ;
lin that_Subj = mkSubj "n" False ;
  --lin when_Subj : Subj ;

--------
-- Verbs

lin have_V2 = { prc = mkPrc "" ; val = R.NorNork R.Eduki } ;


lin can8know_VV = ukanV "ahal" ; -- can (capacity)
lin can_VV = ukanV "ahal" ;      -- can (possibility)
lin must_VV = ukanV "behar" ;
lin want_VV = ukanV "nahi" ;

}
