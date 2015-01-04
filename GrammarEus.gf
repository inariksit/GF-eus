concrete GrammarEus of Grammar = open MorphoEus, Prelude in {

  lincat  
    S  = {s : Str} ;
    Cl = {s : ClForm => TTense => Bool => Str} ; 
    NP = MorphoEus.NP ;  
      -- {s : Case => Str ; a : Agr} ; 
    VP = MorphoEus.VP ;  
      -- {v : AgrVerb ; compl : Str} ;
    -- AP = {s : Str} ;
    AP = {s : Str ; artic : Str } ;
    CN = Noun ;           -- {s : Number => Str} ;
    Det = {s : Str ; n : Number} ;
    N = Noun ;            -- {s : Number => Str} ;
    A = Adj ;             -- {s : Str} ;
    V = Verb ;            -- {s : VForm => Str} ;
    V2 = Verb ** {c : Str} ;
    AdA = {s : Str} ;
    Pol = {s : Str ; b : Bool} ;
    Tense = {s : Str ; t : TTense} ;
    Conj = {s : Str ; n : Number} ;
    Utt = {s : Str} ;
    Adv, Prep = {s : Str} ;
    VS = Verb ;
    PN = {s : Str} ;

  lin
    UttS s = s ;

    -- tense polarity clause
    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! ClDir ! t.t ! p.b} ;

    PredVP np vp = {
      s = \\d,t,b => 
        let 
          vps = vp.verb.s ! d ! t ! b ! np.a
        in case d of {
          ClDir => np.s ! Abs ++ vp.compl ++ vps ;
          ClInv => vps ++ np.s ! Abs ++ vp.compl -- Not needed
          }
      } ;


--    PredVP np vp = {
--      s = \\d,t,b => 
--        let 
--          vps = vp.verb.s ! d ! t ! b ! np.a ;
--          subjcase = case vp.trans of { 
--            Nor     => Abs ;
--            NorNork => Erg 
--          } 
--        in case d of {   -- SubjCase=Erg/Abs, ObjCase=Abs
--          ClDir => np.s ! subjcase ++ vps.fin ++ vps.inf ++ vp.compl ; -- Nik hau dakit
--          ClNeg => vps.fin ++ np.s ! subjCase ++ vps.inf ++ vp.compl -- Nik ez dakit hau
--          }
--    } ;
--
--    UseV v = {
--      verb = mkVerb v ; 
--      compl = []
--      } ;
--

    PrepNP prep np = {
      s = prep.s ++ np.s ! Abs
      } ;

    SubjCl cl subj s = {
      s = \\d,t,b => cl.s ! d ! t ! b ++ subj.s ++ s.s
      } ;

    CompAdv adv = {
      verb = copula ;
      compl = adv.s
      } ;

    CompAP ap = {
      verb = copula ;
      compl = ap.s
      } ;

    DetCN det cn = {
      s = \\_ => cn.s ++ det.s ;
      a = Ag det.n Per3
      } ;

    UseN n = n ;

    UseA adj = adj ; 

    UsePN pn = {
      s = \\_ => pn.s ;
      a = Ag Sg Per3
      } ;

    AdvNP np adv = {
      s = \\c => np.s ! c ++ adv.s ;
      a = np.a
      } ;

    ConjS  co x y = {s = x.s ++ co.s ++ y.s} ;
    --ConjAP co x y = {s = x.s ++ co.s ++ y.s } ;
    ConjAP co x y = {s = x.s ++ co.s ++ y.s ; artic = y.artic } ;

    ConjNP co nx ny = {
      s = \\c => nx.s ! c ++ co.s ++ ny.s ! c ;
      a = conjAgr co.n nx.a ny.a
      } ;


    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = [] ; t = TPres} ;
    -- Perf = {s = [] ; t = TPerf} ;
    -- Past = {s = [] ; t = TPast} ;
    -- Fut  = {s = [] ; t = TFut} ;

    ---
    -- Move to lexicon
    ---

    and_Conj = {s = "eta" ; n = Pl} ; -- TODO: move to morph 

    very_AdA = ss "oso" ;

    we_NP = pronNP "gu" Pl Per1 ;

    the_Det = mkDet "a" Sg ;
    this_Det = mkDet "hau" Sg ;
    these_Det = mkDet "hauek" Pl ;

    by_Prep = ss "z" ;
    with_Prep = ss "ekin" ;
    in_Prep = ss "n" ;



    here_Adv = ss "hemen" ;

}
