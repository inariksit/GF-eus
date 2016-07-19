concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, VerbEus, Prelude in {

  flags optimize=all_subs ;

  lin   

    --PredVP : NP -> VP -> Cl
    PredVP np vp = mkClause np vp ;

    --UseCl  : Temp -> Pol -> Cl -> S ;
    UseCl temp pol cl = {s = cl.s ! temp.t ! pol.p } ;

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
