resource ResEus = ParamX ** open TenseX, Prelude in {

  flags optimize=all ;
  coding=utf8 ;

--2 For $Noun$

param 
    Case = Erg | Abs | Dat ;
    Agr = Ni | Hi | Zu | Hau | Gu | Zuek | Hauek ;
    --VTense = VPres | VProg | VFut ;
    AgrValency = Nor | NorNork | NorNori | NorNoriNork ;

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

    Verb : Type = {prc : Tense => Str} ;
    Verb1 : Type = Verb ** {s : Agr => Str} ;
    Verb2 : Type = Verb ** {s : Agr => Agr => Str ; sc : Case} ; --grammatical subject can be nork or nori
    Verb3 : Type = Verb ** {s : Agr => Agr => Agr => Str} ; --for Verb3 it's always nor nori nork

    VerbPhrase : Type = {s     : Agr => Str ; --head of VP
			 prc   : Tense => Str ;
			 sc    : Case ; -- subject case can be Erg or Dat
                         compl : Str ;  -- complement will be always in Abs, so plain Str is enough
                         adv   : Str } ; 

    VPSlash : Type = Verb2 ; --TODO do we need something else?


    predV : Verb1 -> VerbPhrase = \v -> {
      s = v.s ; sc = Abs ; prc = v.prc ; compl = []; adv = []} ;
  

    addCopula : Complement -> VerbPhrase = \comp ->
     lin VP {s = copula ; prc = \\_ => [] ; 
	     sc = Abs ; compl = comp.s ! Abs ;
	     adv = [] } ;


    copulaNor : Agr => Str =
      table {Ni => "naiz" ; 
             Hi => "haiz" ; 
             Zu => "zara" ; 
             Hau => "da" ; 
             Gu => "gara" ; 
             Zuek => "zarete" ; 
             Hauek => "dira" 
       } ;

    copulaNorNork : Agr => Agr => Str = 
       -- Nor,Nork
       table {
              Ni => table {Ni  => Prelude.nonExist ;
                           Hi => "nauk" | "naun" ; -- FIXME: Gender
                           Zu => "nauzu" ;
                           Hau => "nau" ;
                           Gu => Prelude.nonExist ; -- FIXME: Maybe this exists?
                           Zuek   => "nauzue" ;
                           Hauek  => "naute"  } ;
              Hi => table {Ni    => "haut" ;
                           Hi    => Prelude.nonExist ; 
                           Zu    => Prelude.nonExist ;
                           Hau   => "hau" ;
                           Gu    => "haugu" ;
                           Zuek  => Prelude.nonExist ;
                           Hauek => "haute" } ;
              Zu => table {Ni => "zaitut" ;
                           Hi => Prelude.nonExist ;
                           Zu => Prelude.nonExist ;
                           Hau => "zaitu" ;
                           Gu => "zaitugu" ;
                           Zuek => Prelude.nonExist ;
                           Hauek => "zaituzte" };
              Hau => table {Ni => "dut" ;
                            Hi => "duk" | "dun" ; -- FIXME: Gender
                            Zu => "duzu" ;
                            Hau => "du" ;
                            Gu => "dugu" ;
                            Zuek => "duzue" ;
                            Hauek => "dute" } ;
              Gu => table {Ni => Prelude.nonExist ;
                           Hi => "gaituk" | "gaitun" ;
                           Zu => "gaituzu" ;
                           Hau => "gaitu" ;
                           Gu => Prelude.nonExist ;
                           Zuek => "gaituzue" ;
                           Hauek => "gaituzte" } ;
              Zuek => table {Ni => "zaituztet" ;
                             Hi => Prelude.nonExist ;
                             Zu => Prelude.nonExist ;
                             Hau => "zaituzte" ;
                             Gu => "zaituztegu" ;
                             Zuek => Prelude.nonExist ;
                             Hauek => "zaituztete" } ;
              Hauek => table {Ni => "ditut" ;
                              Hi => "dituk" | "ditun" ; -- FIXME: Gender
                              Zu => "dituzu" ;
                              Hau => "ditu" ;
                              Gu => "ditugu" ;
                              Zuek => "dituzue" ;
                              Hauek => "dituzte" }
   } ;

-- ibili, ibiltzen, ibiliko
-- amildu, amiltzen, amilduko

-- choose copula based on transitivity(argstruct) of main verb.

    copula = copulaNor ;

-- Clause stuffs
    --later: something like Tense => Anteriority => Polarity => (basque-specific parameters) => Str ;
    Clause : Type = {s : Tense => Str} ; 

    mkClause : NounPhrase -> VerbPhrase -> Clause = \np,vp ->
      let
        subject  = np.s ! vp.sc ;
	finverb  = vp.s ! np.agr ;
	finverbPast = "past copula or some harglebargle" ; -- vp.s ! TODO
      in 
      { s = table {
          Pres => vp.adv ++ subject ++ vp.compl ++ vp.prc ! Pres ++ finverb ;
	  Fut  => vp.adv ++ subject ++ vp.compl ++ vp.prc ! Fut ++ finverb ;
          Past => vp.adv ++ subject ++ vp.compl ++ vp.prc ! Past ++ finverbPast ;
	  _    => "conditional or something lol"
            }
      } ;
}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past