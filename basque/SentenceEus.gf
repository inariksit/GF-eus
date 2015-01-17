concrete SentenceEus of Sentence = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    Clause : Type = {
      s : Tense => Anteriority => Polarity => Order => Str
    } ;


    --PredVP np vp = mkClause (np.s ! Abs) np.a vp ;
    PredVP np vp = mkClause (np.s ! Abs) np.a vp ;


}
