concrete PhraseEus of Phrase = CatEus ** open Prelude, ResEus in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = { s = wordOrder s ! Stat } ;
    UttQS qs = { s = qs.s ! Qst } ;
{-    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p } ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p } ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p } ;
-}
    UttIP ip = {s = ip.s ! Abs} ;
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! Abs} ;
    UttVP vp = {s = vp.adv 
                  ++ vp.iobj.s ++ vp.dobj.s ! Pos ++ vp.comp ! Hau  --all the compls!
                  ++ vp.prc ! Pres 
                  ++ chooseAux vp ! Pres ! Hau } ;
    UttAdv adv = adv ;
    UttCN n = {s = n.s ! Hau ++ artA ! Sg ! Abs ! n.ph } ;
--    UttCard n = {s = n.s ! } ;
--    UttAP ap = {s = ap.s ! } ;
    UttInterj i = i ;

    NoPConj = {s = []} ;
    PConjConj conj = {s = conj.s} ;

    NoVoc = {s = []} ;
    VocNP np = { s = "," ++ np.s ! Abs } ;

}