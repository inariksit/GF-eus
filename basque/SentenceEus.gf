concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, VerbEus, Prelude in {

  flags optimize=all_subs ;

  lin   

    --PredVP : NP -> VP -> Cl
    PredVP np vp = mkClause np vp ;

    --UseCl  : Temp -> Pol -> Cl -> S ;
    UseCl temp pol cl = {s = cl.s ! temp.t ! pol.p } ;

    -- UseRCl   : Temp -> Pol -> RCl -> RS ;  -- that had not slept
    UseRCl temp pol cl = {s = cl.s ! temp.t ! pol.p } ;

    -- RelS     : S -> RS -> S ;              -- she sleeps, which is good
    -- RelS s rs = ;
}
