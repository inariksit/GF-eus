resource ResEus = ParamX ** open TenseX, Prelude in {

  flags optimize=all ;
  coding=utf8 ;

param 
{-
   Type of copula used, e.g. 
 
     Miren lorategi a n dago [CopulaType = Egon]
     Miren irakasle a da [CopulaType = Izan]
-}
    CopulaType = Egon | Izan  ; 

{-
   Type of the complement of a postposition. e.g.

      diru gabe [ComplType = AbsNP]
      dirurik gabe [ComplType = ParNP]
      hormaren kontra [ComplType = GenNP]
-}
    ComplType = ParNP | GenNP | AbsNP ;  

{-
   Type of adjectival phrase, e.g.
 
      kale txiki+a [APType = Bare]
      itsaso+ra+ko kale+a [APType = Ko]
-}
    APType = Ko | Bare ; 

    Bizi = Inan | Anim ;

    Case = Erg | Abs | Dat | Par ;

--    Gender = Masc | Fem ; 
--    Degree = Posit | Compar | Superl | Excess ;
--    CardOrd = NCard | NOrd ;
--    DForm = unit | teen | ten  ;

    Agr = Ni | Hi | Zu | Hau | Gu | Zuek | Hauek ;
    AgrValency = Nor | NorNork | NorNori | NorNoriNork ;
    Phono = FinalA | FinalR | FinalCons | FinalVow ; 

oper 

    getNum : Agr -> Number = \np ->
      case np of {
        (Ni|Hi|Zu|Hau)  => Sg ;
        (Gu|Zuek|Hauek) => Pl 
      } ;

    getPers : Agr -> Person = \np ->
      case np of {
        (Ni|Gu)      => P1 ;
        (Hi|Zu|Zuek) => P2 ;
        (Hau|Hauek)  => P3
      } ;

-- Noun stuffs

    Noun : Type = { s    : Str ;
                    stem : Str ;   -- If the stem has `a', don't add the `a' for the definite article
                    ph   : Phono ; 
                    anim : Bizi } ;

    CNoun : Type = { s    : Agr => Str ;   -- When we combine CN with RS, we introduce Agr distinction
                     stem : Agr => Str ; 
                     ph   : Phono ; 
                     anim : Bizi } ;

    Complement : Type = {s : Agr => Str ; copula : CopulaType } ;
    NounPhrase : Type = {s : Case => Str ; agr : Agr ; anim : Bizi ; nbr : Number } ;

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

    buru_NP : NounPhrase = {s = \\_ => "buru" ; agr = Hau ; anim = Anim ; nbr = Sg } ;

-- 

   Postposizio : Type = {s : Str ; complType : ComplType ; attached : Bool } ;

-- Pronoun stuffs

    Pronoun : Type = NounPhrase ** { poss : Str };

    mkPron : Str -> Str -> Str -> Str -> Agr -> Pronoun = \nor,nori,nork,poss,a->
     { s = table { Erg => nork ;
                   Abs => nor ;
                   Dat => nori ;
                   Par => Prelude.nonExist 
                 } ;
       agr  = a ;
       anim = Anim ;
       nbr  = getNum a ;
       poss = poss 
     } ;

--    reflPron : NounPhrase = { s = case agr of {
--        Ni => "nire buru" ;
--        Hi => "hire buru" ;
--        Zu => "zure buru" ;
--        Hau => "bere buru" ;
--        Gu => "gure buru" ;
--        Zuek => "zuen buru" ;
--        Hauek => "beren buru" } ;
--      agr = agr ; 
--      anim = Anim ; 
--      nbr = Sg;
--    } ;


-- Adjective stuffs

    Adjective : Type = {s : Degree => Str ; ph : Phono} ;



-- Verb stuffs

    Verb : Type = { prc : Tense => Str ;
                    ph  : Phono  --for relative clause
                  } ;
    Verb1 : Type = Verb ** {s : Tense => Agr => Str} ;
    Verb2 : Type = Verb ** {s : Agr => Tense => Agr => Str ; sc : Case} ; --grammatical subject can be nork or nori
    Verb3 : Type = Verb ; --for Verb3, verb is always nor nori nork, and sc is Erg

    VerbPhrase : Type = { s     : Tense => Agr => Str ; --head of VP
                          prc   : Tense => Str ;
                          sc    : Case ; -- subject case can be Erg or Dat
                          compl : Agr => Str ;  -- complement case will be always Abs; 
                                               -- need Agr for AP to agree with subject.
                          adv   : Str ;
                          ph    : Phono --for making relative clause
                        } ; 

    VPSlash : Type = Verb2 ** {adv : Str}; --TODO do we need something else?


    predV : Verb1 -> VerbPhrase = \v -> {s     = v.s ; 
                                         sc    = Abs ; 
                                         prc   = v.prc ; 
                                         compl = table {_ => []}; 
                                         adv   = [] ;
                                         ph    = v.ph } ;

    {- Syntax note: 
          vp ** {adv = "hargle"} 
       means: take the original VP except for the field adv, which is replaced by "hargle"
       Same as \vp -> { s     = vp.s ; 
                        sc    = vp.sc ; 
                        prc   = vp.prc ; 
                        compl = vp.compl ;
                        adv   = "hargle" } ;
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
       adv   = [] ;
       ph    = vps.ph } ;

  


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
              Pos => vp.adv ++ subject ++ vp.compl ! np.agr ++ vp.prc ! tense ++ vp.s ! tense ! np.agr | 
                     subject ++ vp.compl ! np.agr ++ vp.prc ! tense ++ vp.s ! tense ! np.agr ++ vp.adv ;
              Neg => vp.adv ++ subject ++ "ez" ++ vp.s ! tense ! np.agr ++ vp.prc ! tense ++ vp.compl ! np.agr
              }
          }
      } ;


    -- Relative clause
    -- We need to keep agreement, because a RS may be attached to a CN or NP,
    -- and we need to produce correct agreement:
    -- `gorria den tzakurra' vs. `gorriak diren tzakurrak'

    RClause : Type = {s : Tense => Polarity => Agr => Str} ;

    mkRCl : {s : Phono => Str} -> VerbPhrase -> RClause = \rp,vp ->
    let en  = rp.s ! vp.ph  ; --TODO phono may be different for different tenses
    in 
    { s = table {
        t => table {        
           Pos => table {                             
             agr => vp.adv ++ vp.compl ! agr                    -- John 
                           ++ vp.prc ! t                        -- maite 
                           ++ vp.s ! t ! agr ++ BIND ++ en } ;  -- duen
           Neg => table {
             agr => vp.adv ++ vp.compl ! agr                 -- John 
                           ++ vp.prc ! t                     -- maite 
                           ++ "ez"                           -- ez
                           ++ vp.s ! t ! agr ++ BIND ++ en } -- duen
            }
        }
    } ;


}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past
