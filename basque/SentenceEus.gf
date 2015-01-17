concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, VerbEus, Prelude in {

  flags optimize=all_subs ;

  lin   

    --PredVP : NP -> VP -> Cl
    PredVP np vp = mkClause np vp ;

    --UseCl    : Temp -> Pol -> Cl  -> S ;
    --later : do something with params
    UseCl temp pol cl = cl ; 
}
