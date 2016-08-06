concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, AditzTrinkoak, Prelude in {

flags optimize=all_subs ;

lin   

  -- : NP -> VP -> Cl
  PredVP np vp = mkClause np vp ;

  -- : Temp -> Pol -> Cl -> S ;
  UseCl temp pol cl = cl.s ! temp.t ! temp.a ! pol.p ! Stat ;

  -- : Temp -> Pol -> RCl -> RS ;
  UseRCl temp pol cl = { s = cl.s ! temp.t ! pol.p } ;

  -- : Temp -> Pol -> QCl -> QS ;
  UseQCl temp pol qcl = qcl.s ! temp.t ! temp.a ! pol.p ;

  --  : S -> RS -> S ;              -- she sleeps, which is good
  RelS sent rs = sent ** { beforeAux = rs.s ! Hau ++ "," ++ sent.beforeAux } ;

  -- : NP -> VPSlash -> ClSlash ;
  SlashVP np vps = mkClSlash np vps ;

{-    AdvSlash  : ClSlash -> Adv -> ClSlash ;     -- (whom) he sees today
    SlashPrep : Cl -> Prep -> ClSlash ;         -- (with whom) he walks 
    SlashVS   : NP -> VS -> SSlash -> ClSlash ; -- (whom) she says that he loves
    UseSlash : Temp -> Pol -> ClSlash -> SSlash ; -- (that) she had not seen
-}


}