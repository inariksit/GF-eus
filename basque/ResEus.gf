resource ResEus = ParamX ** open TenseX, Prelude in {

  flags optimize=all ;
  coding=utf8 ;

param 
    ClType = Dir | Qst ;

{-
   Type of copula used, e.g. 
 
     Miren lorategi+a+n dago [CopulaType = Egon]
     Miren irakasle+a da [CopulaType = Izan]
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

    Case = Abs | Erg | Dat | Par ;

--    Gender = Masc | Fem ; -- We will need this for hika
--    Degree = Posit | Compar | Superl | Excess ;
--    CardOrd = NCard | NOrd ;
--    DForm = unit | teen | ten  ;

    Agr = Ni | Hi | Zu | Hau | Gu | Zuek | Hauek ;
    AgrValency = Nor | NorNork | NorNori | NorNoriNork ;
    Phono = FinalA | FinalR | FinalCons | FinalVow ; 

oper 


    sgAgr : Agr -> Agr = \agr ->
       case agr of { Gu    => Ni ;
                     Zuek  => Zu ;
                     Hauek => Hau ;
                     agr   => agr } ;

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


-- Articles 
  artA : Number => Case => Phono => Str =
   let withoutBind : Number => Case => Phono => Str =
    table { Sg => table {Abs => table {FinalA   => "a"  ;
                                  FinalR   => "ra" ;
                                  _        => "a" } ;
                        Erg => table {FinalA   => "ak"  ;
                                  FinalR   => "rak" ;
                                  _        => "ak" } ;
                        Dat => table {FinalA   => "ri" ;
                                  FinalR   => "rari" ;
                                  _        => "ari" } ;
                        Par => table {FinalA   => "rik" ;
                                  FinalR   => "rarik" ;
                                  FinalVow => "rik" ;
                                  FinalCons => "ik" } 
                        }; 

           Pl => table {Abs => table {FinalA => "ak"  ;
                                  FinalR => "rak" ;
                                  _      => "ak" } ;
                        Erg => table {FinalA => "ek"  ;
                                  FinalR => "rek" ;
                                  _      => "ek" } ;
                        Dat => table {FinalR => "rei" ;
                                  _      => "ei" } ;
                        --TODO: make the partitive force singular agr
                        Par => table {FinalA   => "rik" ;
                                  FinalR   => "rarik" ;
                                  FinalVow => "rik" ;
                                  FinalCons => "ik" } 
                       }
          } ;
    in \\n,c,p => BIND ++ withoutBind ! n ! c ! p  ;


 artIndef : Case => Phono => Str = 
   \\cas,pho => case <cas,pho> of {
        <Abs,_> => [] ;
        <c,ph>  => artA ! Pl ! c ! ph } ;



-- Noun stuffs

    Noun : Type = { s    : Str ;
                    stem : Str ;   -- If the stem has `a', don't add the `a' for the definite article
                    ph   : Phono ; 
                    anim : Bizi } ;

    CNoun : Type = { s    : Agr => Str ; -- When we combine CN with RS, we introduce Agr distinction
                     stem : Agr => Str ; 
                     ph   : Phono ; 
                     anim : Bizi ;
                     heavyMod : Agr => Str } ; -- Relative clause or adverbial
                                    -- If it's "heavy", numbers and possessives come after.
                                    -- "Light" modifiers attach directly to the s and stem.

    Complement : Type = { s : Agr => Str ; copula : CopulaType } ;

    NounPhrase : Type = { s    : Case => Str ;
                          agr  : Agr ;
                          anim : Bizi ; 
                          nbr  : Number ;
                          isDef : Bool } ;

-- NounPhrase is a record
-- a record is a thing with fields ^__^
-- fields can be any type
-- exempelvis, NounPhrase is a record with two fields
-- the two fields are .s. and .agr.
-- the field .s. is a table from Case => Str ... e.g. it has two columns, first column is Case and second column is Str
-- last column is return type, all other columns are arguments
-- exempelvis: 
---      { Abs => "hargle"; Erg => "bargle" }
-- the field .agr. is of type Agr.   

    buru_NP : NounPhrase = { s = \\_ => "buru" ;
                             agr = Hau ; 
                             anim = Anim ; 
                             nbr = Sg ;
                             isDef = True } ;

-- 

   Postposizio : Type = {s : Str ; complType : ComplType ; attached : Bool } ;

-- Pronoun stuffs

    Pronoun : Type = NounPhrase ** { poss : Str };

    mkPron : Str -> Str -> Str -> Str -> Agr -> Pronoun = \nor,nori,nork,poss,a->
     { s = table { Erg => nork ;
                   Abs => nor ;
                   Dat => nori ;
                   Par => []  
                 } ;
       agr  = a ;
       anim = Anim ;
       nbr  = getNum a ;
       isDef = True ;
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
    Verb1 : Type = Verb ** { s : Tense => Agr => Str } ;

    Verb2 : Type = Verb ** { s  : Agr => Tense => Agr => Str ; 
                             sc : Case } ; --grammatical subject can be nork or nori

    Verb3 : Type = Verb ; --copula is always nor-nori-nork, and sc is Erg.

    VerbPhrase : Type = 
       Verb ** { s     : Polarity -- Negative forces object agreement into Sg
                         => Tense 
                         => Agr -- Subject agreement
                         => Str ; --head of VP
                 sc    : Case ; -- subject case can be Erg or Dat
                 compl : Polarity -- Negative forces complement case into Par 
                         => Agr   -- If complement is AP, we need Agr to agree with subject.
                         => Str ;  
                 
                 
                 adv   : Str ;
               } ; 

    VPSlash : Type = Verb2 ** {adv : Str}; 


    predV : Verb1 -> VerbPhrase = \v -> { s     = \\pol => v.s ;  -- TODO is this true: neg doesn't force singular in Verb1
                                      sc    = Abs ; 
                                      prc   = v.prc ; 
                                      compl = \\_,_ => []; 
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
      vp ** { adv = vp.adv ++ adv.s } ;


    insertComp : Complement -> VerbPhrase -> VerbPhrase = \comp,vp ->
      vp ** { compl = \\pol,agr => vp.compl ! pol ! agr ++ comp.s ! agr } ;

    complSlash : VPSlash -> NounPhrase -> VerbPhrase = \vps,np ->
      let posVerb = vps.s ! np.agr ;
          negVerb = if_then_else (Tense => Agr => Str) 
                              np.isDef
                              posVerb
                                 (vps.s ! sgAgr np.agr) ;
          posComp = np.s ! Abs ;
          negComp = if_then_Str np.isDef posComp (np.s ! Par) ;

      in { s     = table { Pos => posVerb ; --(Agr => Agr) to (Polarity => Agr) 
                           Neg => negVerb } ;
           prc   = vps.prc ;
           sc    = vps.sc ;
           compl = table { Pos => \\_ => posComp ;
                           Neg => \\_ => negComp } ;
           adv   = [] ;
           ph    = vps.ph } ;

  


-- ibili, ibiltzen, ibiliko
-- amildu, amiltzen, amilduko



-- Clause stuffs

    --later: something like Tense => Anteriority => Polarity => (basque-specific parameters) => Str ;
    Clause : Type = {s : ClType => Tense => Polarity => Str} ; 

-- ez al duzu katu beltza ikusi? / ez al duzu katu beltzik ikusi? (MassNP)
-- ez dut katu beltza ikusi / ez dut katu beltzik ikusi (MassNP)
-- ibiltzen al zara ;  garagardoa edaten al duzu? 
-- mutilari garagardoa ematen al diozu?
--  txakurrari abesten al diozu?


    QClause : Type = {s : Tense => Polarity => Str} ; 



    mkClause : NounPhrase -> VerbPhrase -> Clause = \subj,vp ->
      let
        subject : Str = subj.s ! vp.sc ;
        al : ClType => Str = table { Dir => [] ; 
                                 Qst => "al" } ;

      in 
      { s = \\ct,t => 
               table { Pos => vp.adv 
                           ++ subject 
                           ++ vp.compl ! Pos ! subj.agr 
                           ++ vp.prc ! t
                           ++ al ! ct
                           ++ vp.s ! Pos ! t ! subj.agr  ;
                       Neg => vp.adv 
                           ++ subject 
                           ++ "ez" 
                           ++ al ! ct
                           ++ vp.s ! Neg ! t ! subj.agr 
                           ++ vp.compl ! Neg ! subj.agr 
                           ++ vp.prc ! t
                     }          
      } ;

    ------------------------------------------------
    -- ClSlash: has verb and object, missing subject
    ClSlash : Type = VPSlash ** { subj : Str ; subjAgr : Agr } ;
 

    mkClSlash : NounPhrase -> VPSlash -> ClSlash = \np,vps ->
      vps ** { subj = np.s ! vps.sc ;
               subjAgr = np.agr } ;

    ------------------------------------------------
    -- Relative clause
    -- We need to keep agreement, because a RS may be attached to a CN or NP,
    -- and we need to produce correct agreement:
    -- `gorria den txakurra' vs. `gorriak diren txakurrak'

    RClause : Type = {s : Tense => Polarity => Agr => Str} ;

    mkRCl : {s : Phono => Str} -> VerbPhrase -> RClause = \rp,vp ->
    let en = table { Past => [] ; --past tenses end in n; 0 relative morpheme.
                     _    => BIND ++ rp.s ! vp.ph } ; --TODO: phono should differ between individual forms
        ez = table { Pos => "" ; Neg => "ez" } ;
    in 
    { s = table {
        tense => table {        
           pol => table {
             agr => vp.adv ++ vp.compl ! pol  ! agr      -- John 
                           ++ vp.prc ! tense             -- maite 
                           ++ ez ! pol                   -- (ez)
                           ++ vp.s ! pol ! tense ! agr ++ en ! tense } -- duen
            }
        }
    } ;

    mkRClSlash : {s : Phono => Str} -> ClSlash -> RClause = \rp,cls ->
    let en = table { Past => [] ; --past tenses end in n; 0 relative morpheme.
                     _    => BIND ++ rp.s ! cls.ph } ; 
        ez = table { Pos => "" ; Neg => "ez" } ;
    in 
    { s = \\tns,pol,objAgr => cls.adv 
                              ++ cls.subj                      -- Johnek
                              ++ cls.prc ! tns                 -- maite 
                              ++ ez ! pol                      -- (ez)
                              ++ cls.s ! objAgr ! tns ! cls.subjAgr -- d(it)u
                              ++ en ! tns                      -- en
    } ;

}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past
