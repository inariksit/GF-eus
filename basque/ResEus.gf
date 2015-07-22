resource ResEus = ParamX ** open TenseX, Prelude in {

  flags optimize=all ;
  coding=utf8 ;

param 
--    Gender = Masc | Fem ; 
    CopulaType = Egon | Izan  ; 
    Bizi = Inan | Anim ;
    Case = Erg | Abs | Dat ;
--    Degree = Posit | Compar | Superl | Excess ;
--    CardOrd = NCard | NOrd ;
--    DForm = unit | teen | ten  ;
    APType = Ko | Bare ; 

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
    Noun : Type = {s : Str ; stem : Str ; ph : Phono ; anim : Bizi} ;
    Complement : Type = {s : Agr => Str ; copula : CopulaType } ;
    NounPhrase : Type = {s : Case => Str ; agr : Agr ; anim : Bizi} ;

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

    buru_NP : NounPhrase = {s = \\_ => "buru" ; agr = Hau ; anim = Anim} ;

-- Pronoun stuffs

    Pronoun : Type = NounPhrase ;


-- Adjective stuffs

    Adjective : Type = {s : Degree => Str ; ph : Phono} ;



-- Verb stuffs

    Verb : Type = {prc : Tense => Str} ;
    Verb1 : Type = Verb ** {s : Tense => Agr => Str} ;
    Verb2 : Type = Verb ** {s : Agr => Tense => Agr => Str ; sc : Case} ; --grammatical subject can be nork or nori
    Verb3 : Type = Verb ; --for Verb3, verb is always nor nori nork, and sc is Erg

    VerbPhrase : Type = {s     : Tense => Agr => Str ; --head of VP
                         prc   : Tense => Str ;
                         sc    : Case ; -- subject case can be Erg or Dat
                         compl : Agr => Str ;  -- complement case will be always Abs; 
                                               -- need Agr for AP to agree with subject.
                         adv   : Str } ; 

    VPSlash : Type = Verb2 ** {adv : Str}; --TODO do we need something else?


    predV : Verb1 -> VerbPhrase = \v -> {s     = v.s ; 
                                         sc    = Abs ; 
                                         prc   = v.prc ; 
                                         compl = table {_ => []}; 
                                         adv   = []} ;

    {- Syntax note: 
          vp ** {adv = "hargle"} 
       means: take the original VP except for the field adv, which is replaced by "hargle"
       Same as \vp -> {s     = vp.s ; 
                       sc    = vp.sc ; 
                              prc   = vp.prc ; 
                       compl = vp.compl ;
                       adv   = "hargle"} ;
    -}
    insertAdv : Adv -> VerbPhrase -> VerbPhrase = \adv,vp ->
      vp ** {adv = vp.adv ++ adv.s} ;


    insertComp : Complement -> VerbPhrase -> VerbPhrase = \comp,vp ->
      vp ** {compl = table {agr => vp.compl ! agr ++ comp.s ! agr}} ;

    complSlash : VPSlash -> NounPhrase -> VerbPhrase = \vps,np ->
      {s     = vps.s ! np.agr ; --(Agr => Agr => Str) to (Agr => Str) 
       prc   = vps.prc ;
       sc    = vps.sc ;
       compl = table {_ => np.s ! Abs} ;
       adv   = [] } ;

  


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
              Pos => vp.adv ++ subject ++ vp.compl ! np.agr ++ vp.prc ! tense ++ vp.s ! tense ! np.agr ;
              Neg => vp.adv ++ subject ++ "ez" ++ vp.s ! tense ! np.agr ++ vp.prc ! tense ++ vp.compl ! np.agr
              }
          }
      } ;
}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past
