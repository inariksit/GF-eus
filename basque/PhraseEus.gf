concrete PhraseEus of Phrase = CatEus ** open Prelude, ResEus in {

  lin
    PhrUtt pconj utt voc = {s = pconj.s ++ utt.s ++ voc.s} ;

    UttS s = s ;
    UttQS qs = qs ;
{-    UttImpSg pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg False} ;
    UttImpPl pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Pl False} ;
    UttImpPol pol imp = {s = pol.s ++ imp.s ! pol.p ! ImpF Sg True} ;
-}
    UttIP ip = {s = ip.s ! Abs} ;
    UttIAdv iadv = iadv ;
    UttNP np = {s = np.s ! Abs} ;
    UttVP vp = {s = vp.compl ! Pos ! Hau ++ vp.s ! Pos ! Pres ! Hau } ;
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