concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, VerbEus, Prelude in {

  flags optimize=all_subs ;

  lin   

    --PredVP : NP -> VP -> Cl
    PredVP np vp = mkClause np vp ;

    --UseCl    : Temp -> Pol -> Cl  -> S ;
    UseCl temp pol cl = {s = cl.s ! temp.t ! pol.p } ;
}
