resource ResEus = ParamX ** open TenseX, Prelude in {

  flags optimize=all ;
  coding=utf8 ;

param 
    Case = Erg | Abs | Dat ;
--    Degree = Posit | Compar | Superl | Excess ;
    Agr = Ni | Hi | Zu | Hau | Gu | Zuek | Hauek ;
    AgrValency = Nor | NorNork | NorNori | NorNoriNork ;
    Phono = FinalA | FinalR | FinalCons | FinalVow ; 

oper 

    getNum : Agr -> Number = \np ->
      case np of {
        (Ni|Hi|Zu|Hau)      => Sg ;
        (Gu|Zuek|Hauek) => Pl 
      } ;

    getPers : Agr -> Person = \np ->
      case np of {
        (Ni|Gu)      => P1 ;
        (Hi|Zu|Zuek) => P2 ;
        (Hau|Hauek)  => P3
      } ;

-- Noun stuffs
    Noun : Type = {s : Str ; stem : Str ; ph : Phono} ;
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


-- Adjective stuffs

    Adjective : Type = {s : Degree => Str ; ph : Phono} ;

-- Verb stuffs

    Verb : Type = {prc : Tense => Str} ;
    Verb1 : Type = Verb ** {s : Tense => Agr => Str} ;
    Verb2 : Type = Verb ** {s : Agr => Tense => Agr => Str ; sc : Case} ; --grammatical subject can be nork or nori
    Verb3 : Type = Verb ** {s : Agr => Agr => Tense => Agr => Str} ; --for Verb3 it's always nor nori nork

    VerbPhrase : Type = {s     : Tense => Agr => Str ; --head of VP
			 prc   : Tense => Str ;
			 sc    : Case ; -- subject case can be Erg or Dat
                         compl : Str ;  -- complement will be always in Abs, so plain Str is enough
                         adv   : Str } ; 

    VPSlash : Type = Verb2 ; --TODO do we need something else?


    predV : Verb1 -> VerbPhrase = \v -> {
      s = v.s ; sc = Abs ; prc = v.prc ; compl = []; adv = []} ;
  


-- ibili, ibiltzen, ibiliko
-- amildu, amiltzen, amilduko



-- Clause stuffs
    --later: something like Tense => Anteriority => Polarity => (basque-specific parameters) => Str ;
    Clause : Type = {s : Tense => Polarity => Str} ; 

    mkClause : NounPhrase -> VerbPhrase -> Clause = \np,vp ->
      let
        subject : Str = np.s ! vp.sc ;
      in 
      { s = table {
          tense => table {
              Pos => vp.adv ++ subject ++ vp.compl ++ vp.prc ! tense ++ vp.s ! tense ! np.agr ;
	      Neg => vp.adv ++ subject ++ "ez" ++ vp.s ! tense ! np.agr ++ vp.prc ! tense ++ vp.compl 
              }
          }
      } ;
}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past
