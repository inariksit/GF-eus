concrete GrammarEus of Grammar = open MorphoEus, Prelude in {
  lincat  
    S  = {s : Str} ;
    Cl = {s : ClForm => TTense => Bool => Str} ; 
    NP = ResEng.NP ;  
      -- {s : Case => Str ; a : Agr} ; 
    VP = ResEng.VP ;  
      -- {v : AgrVerb ; compl : Str} ;
    AP = {s : Str} ;
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
  lin
    UseCl t p cl = {s = t.s ++ p.s ++ cl.s ! ClDir ! t.t ! p.b} ;

    -- 

    PredVP np vp = {
      s = \\d,t,b => 
        let 
          vps = vp.verb.s ! d ! t ! b ! np.a ;
          subjcase = case vp.trans of { 
            Nor     => Abs ;
            NorNork => Erg 
          } 
        in case d of { -- SubjCase=Erg/Abs, ObjCase=Abs
          ClDir => np.s ! subjcase ++ vps.fin ++ vps.inf ++ vp.compl ; -- Nik hau dakit
          ClNeg => vps.fin ++ np.s ! subjCase ++ vps.inf ++ vp.compl -- Nik ez dakit hau
          }
    } ;

    UseV v = {
      verb = agrV v ; 
      compl = []
      } ;

    DetCN det cn = {
      s = \\_ => cn.s ! det.n ++ det.s ;
      a = Ag det.n Per3
      } ;

    UseN n = n ;

    UseA adj = adj ;




    Pos  = {s = [] ; b = True} ;
    Neg  = {s = [] ; b = False} ;
    Pres = {s = [] ; t = TPres} ;
    Perf = {s = [] ; t = TPerf} ;
    Past = {s = [] ; t = TPast} ;
    Fut  = {s = [] ; t = TFut} ;




}