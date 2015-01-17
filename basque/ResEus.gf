resource ResEus = ParamX ** open Prelude in {

  flags optimize=all ;
  coding=utf8 ;

--2 For $Noun$

param 
    Case = Erg | Abs | Dat ;
    Agr  = SgP3 | Hargle | Bargle ; --TODO Ag Number Person ; 
--    Number = Sg | Pl ;
--    Person  P1 | P2 | P3 
oper 
-- Noun stuffs
    Noun : Type = {s : Str } ;
    Complement : Type = {s : Case => Str } ;
    NounPhrase : Type = {s : Case => Str ; agr : Agr} ;

-- NounPhrase is a record
-- a record is a thing with fields
-- fields can be any type
-- exempelvis, NounPhrase is a record with two fields
-- the two fields are .s. and .agr.
-- the field .s. is a table from Case => Str ... e.g. it has two columns, first column is Case and second column is Str
-- last column is return type, all other columns are arguments
-- exempelvis: 
---      { Abs => "hargle"; Erg => "bargle" }
-- the field .agr. is of type Agr.           

-- Verb stuffs

    Verb : Type = {s : Agr => Str} ;
    Verb2 : Type = Verb  ** {cas : Case} ;
    VerbPhrase : Type = {s     : Agr => Str ; --head of VP
                         compl : Str ; --chosen by the compl field of V2
                         adv   : Str } ; 

    --will need something like this later
    complV2 : Verb2 -> NounPhrase -> VerbPhrase = \v2,np ->
     {s = v2.s ; compl = np.s ! v2.cas ; adv = [] } ;


    addCopula : Complement -> VerbPhrase = \comp ->
     lin VP {s    = copula ; compl = comp.s ! Abs ; adv = [] } ;

    copula : Agr => Str =
      table {SgP3 => "da" ; 
             Hargle => "hargle" ; 
             Bargle => "bargle" } ;


-- Clause stuffs
    --later: something like Tense => Anteriority => Polarity => (basque-specific parameters) => Str ;
    Clause : Type = {s : Str} ; 

    mkClause : NounPhrase -> VerbPhrase -> Clause ;
    mkClause np vp = 
      let
        presCl = np.s ! Abs ++ vp.compl ++ vp.s ! np.agr ; --later: choose present,
	someOtherTenseCl = "sentence in some other tense than present" ; -- choose some other tenses
      in ss presCl ;
      -- later:
      -- { s = table {
      --         PresentStuffs    => presCl ;
      -- 	 NonPresentStuffs => someOtherTenseCl 
      --       }
      -- } ;
}
