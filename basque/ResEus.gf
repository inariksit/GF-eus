resource ResEus = ParamX ** open TenseX, Prelude in {

  flags optimize=all ;
  coding=utf8 ;

--2 For $Noun$

param 
    Case = Erg | Abs | Dat ;
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
    Noun : Type = {s : Str ; ph : Phono} ;
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
  

    addCopula : Complement -> VerbPhrase = \comp ->
     lin VP {s = copula ; prc = \\_ => [] ; 
	     sc = Abs ; compl = comp.s ! Abs ;
	     adv = [] } ;



    copulaNor : Tense => Agr => Str =
      table {Past => table {Ni => "nintzen" ; 
                    Hi => "hintzen" ; 
                    Zu => "zinen" ; 
                    Hau => "zen" ; 
                    Gu => "ginen" ; 
                    Zuek => "zineten" ; 
                    Hauek => "ziren" } ;
             Cond => table {Ni => "banintz" ; 
                    Hi => "bahintz" ; 
                    Zu => "bazina" ; 
                    Hau => "balitz" ; 
                    Gu => "bagina" ; 
                    Zuek => "bazinete" ; 
                    Hauek => "balira" } ;
             -- Present and future are identical
	     _ =>  table {Ni => "naiz" ; 
                    Hi => "haiz" ; 
                    Zu => "zara" ; 
                    Hau => "da" ; 
                    Gu => "gara" ; 
                    Zuek => "zarete" ; 
                    Hauek => "dira" }
       } ;

    copulaNorNork : Agr => Tense => Agr => Str = table {
       -- Nor,Nork
              Gu => table {
                     Past => table {
                              Gu => Prelude.nonExist ;
                              Hauek => "gintuzten" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "gintuzuen" ;
                              Hau => "gintuen" ;
                              Hi => "gintuan" | "gintunan" ;
                              Zu => "gintuzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => Prelude.nonExist ;
                              Hauek => "gaituzte" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "gaituzue" ;
                              Hau => "gaitu" ;
                              Hi => "gaituk" | "gaitun" ;
                              Zu => "gaituzu" 
                     }
              } ;
              Hauek => table {
                     Past => table {
                              Gu => "genituen" ;
                              Hauek => "zituzten" ;
                              Ni => "nituen" ;
                              Zuek => "zenituzten" ;
                              Hau => "zituen" ;
                              Hi => "hituen" ;
                              Zu => "zenituen" 
                     } ;
                     _ => table { -- Pres
                              Gu => "ditugu" ;
                              Hauek => "dituzte" ;
                              Ni => "ditut" ;
                              Zuek => "dituzue" ;
                              Hau => "ditu" ;
                              Hi => "dituk" | "ditun" ;
                              Zu => "dituzu" 
                     }
              } ;
              Ni => table {
                     Past => table {
                              Gu => Prelude.nonExist ;
                              Hauek => "ninduten" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "ninduzuen" ;
                              Hau => "ninduen" ;
                              Hi => "ninduan" | "nindunan" ;
                              Zu => "ninduzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => Prelude.nonExist ;
                              Hauek => "naute" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "nauzue" ;
                              Hau => "nau" ;
                              Hi => "nauk" | "naun" ;
                              Zu => "nauzu" 
                     }
              } ;
              Zuek => table {
                     Past => table {
                              Gu => "zintuztegun" ;
                              Hauek => "zintuzteten" ;
                              Ni => "zintuztedan" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zintuzten" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist
                     } ;
                     _ => table { -- Pres
                              Gu => "zaituztegu" ;
                              Hauek => "zaituztete" ;
                              Ni => "zaituztet" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zaituzte" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     }
              } ;
              Hau => table {
                     Past => table {
                              Gu => "genuen" ;
                              Hauek => "zuten" ;
                              Ni => "nuen" ;
                              Zuek => "zenuten" ;
                              Hau => "zuen" ;
                              Hi => "huen" ;
                              Zu => "zenuen" 
                     } ;
                     _ => table { -- Pres
                              Gu => "dugu" ;
                              Hauek => "dute" ;
                              Ni => "dut" ;
                              Zuek => "duzue" ;
                              Hau => "du" ;
                              Hi => "duk" | "dun" ;
                              Zu => "duzu" 
                     }
              } ;
              Hi => table {
                     Past => table {
                              Gu => "hindugun" ;
                              Hauek => "hinduten" ;
                              Ni => "hindudan" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "hinduen" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     } ;
                     _ => table { -- Pres
                              Gu => "haugu" ;
                              Hauek => "haute" ;
                              Ni => "haut" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "hau" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist
                     }
              } ;
              Zu => table {
                     Past => table {
                              Gu => "zintugun" ;
                              Hauek => "zintuzten" ;
                              Ni => "zintudan" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zintuen" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     } ;
                     _ => table { -- Pres
                              Gu => "zaitugu" ;
                              Hauek => "zaituzte" ;
                              Ni => "zaitut" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zaitu" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     }
              }
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
        subject : Str = np.s ! vp.sc ;
      in 
      { s = table {
          tense => vp.adv ++ subject ++ vp.compl ++ vp.prc ! tense ++ vp.s ! tense ! np.agr 
            }
      } ;
}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past
