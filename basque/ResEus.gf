resource ResEus = ParamX ** open Prelude in {

  flags optimize=all ;
  coding=utf8 ;

--2 For $Noun$

param
    Case = Erg | Abs | Dat ;
    Agr  = SgP3 | Hargle | Bargle ; --TODO 

oper 
-- Noun stuffs
    Noun : Type = {s : Str } ;
    Complement : Type = {s : Case => Str } ;
    NounPhrase : Type = {s : Case => Str ; agr : Agr} ;

-- Verb stuffs

    Verb : Type = {s : Agr => Str} ;
    Verb2 : Type = Verb  ** {cas : Case} ;
    VerbPhrase : Type = {s     : Str ;
			 verb  : Agr => Str ;
                         compl : Str ; --chosen by the compl field of V2
                         adv   : Str } ; 

    complV2 : Verb2 -> NounPhrase -> VerbPhrase = \v2,np ->
     {s = "hargle" ; verb = v2.s ; compl = np.s ! v2.cas ; adv = [] } ;




-- Clause stuffs
    --later: something like Tense => Anteriority => Polarity => (basque-specific parameters) => Str ;
    Clause : Type = {s : Tense => Str} ; 

    mkClause : NounPhrase -> VerbPhrase -> Clause ;
    mkClause np vp = 
      let
        presCl = np.s ! Abs ++ vp.compl ++ vp.verb ! np.agr ; --later: choose present,
	someOtherTenseCl = "sentence in some other tense than present" ; -- choose some other tenses
      in 
      { s = table {
              TPres => presCl ;
      	       _    => someOtherTenseCl 
            }
      } ;
}
