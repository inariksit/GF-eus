concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, VerbEus, Prelude in {

  flags optimize=all_subs ;

  lin   

    --PredVP : NP -> VP -> Cl
    PredVP np vp = mkClause np vp ;

    --UseCl  : Temp -> Pol -> Cl -> S ;
    UseCl temp pol cl = {s = cl.s ! temp.t ! temp.a ! pol.p ! Dir } ;

    -- UseRCl   : Temp -> Pol -> RCl -> RS ;
    UseRCl temp pol cl = {s = cl.s ! temp.t ! pol.p } ;

    -- RelS     : S -> RS -> S ;              -- she sleeps, which is good
    --RelS sent rs = {s = sent.s ++ rs.s ! Hau } ;

    -- SlashVP   : NP -> VPSlash -> ClSlash ;
    SlashVP np vps = mkClSlash np vps ;

{-    AdvSlash  : ClSlash -> Adv -> ClSlash ;     -- (whom) he sees today
    SlashPrep : Cl -> Prep -> ClSlash ;         -- (with whom) he walks 
    SlashVS   : NP -> VS -> SSlash -> ClSlash ; -- (whom) she says that he loves
    UseSlash : Temp -> Pol -> ClSlash -> SSlash ; -- (that) she had not seen
-}
}

{-
  Pres  Simul  Pos  Dir  : lo egiten da        -- s ! Pres, prc ! Pres
  Pres  Simul  Neg  Dir  : ez da lo egiten
  Pres  Anter  Pos  Dir  : lo egin da          -- s ! Pres, prc ! Past
  Pres  Anter  Neg  Dir  : ez da lo egin

  Past  Simul  Pos  Dir  : lo egiten nintzen   -- s ! Past, prc ! Pres
  Past  Simul  Neg  Dir  : ez nintzen lo egin
  Past  Anter  Pos  Dir  : lo egin nintzen     -- s ! Past, prc ! Past
  Past  Anter  Neg  Dir  : ez nintzen lo egin

  Fut   Simul  Pos  Dir  : lo egingo da        -- s ! Pres, prc ! Fut
  Fut   Simul  Neg  Dir  : ez da lo egingo
  Fut   Anter  Pos  Dir  : lo egingo nintzen   -- s ! Past , prc ! Fut
  Fut   Anter  Neg  Dir  : ez nintzen lo egingo

  Cond  Simul  Pos  Dir  : lo egiteko nintzateke  -- s ! Cond , prc ! Fut
  Cond  Simul  Neg  Dir  : ez nintzateke lo egiteko
  Cond  Anter  Pos  Dir  : lo egin nintzateke     -- s ! Cond , prc ! Past
  Cond  Anter  Neg  Dir  : ez nintzateke lo egin
-}