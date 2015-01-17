resource ResEus = ParamX ** open Prelude in {

  flags optimize=all ;
  coding=utf8 ;

--2 For $Noun$

param 
    Case = Erg | Abs | Dat ;
    Agr = Ni | Hi | Zu | Hau | Gu | Zuek | Hauek ;

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


    copulaNor : Agr => Str =
      table {Ni => "naiz" ; 
             Hi => "haiz" ; 
             Zu => "zara" ; 
             Hau => "da" ; 
             Gu => "gara" ; 
             Zuek => "zarete" ; 
             Hauek => "dira" 
       } ;

    copulaNorNork : Agr * Agr => Str = 
       -- Nork,Nor
       table {
              <Ni,Ni> => Prelude.nonExist ;
              <Ni,Hi> => "nauk" | "naun" ; -- FIXME: Gender
              <Ni,Zu> => "nauzu" ;
              <Ni,Hau> => "nau" ;
              <Ni,Gu> => Prelude.nonExist ; -- FIXME: Maybe this exists?
              <Ni,Zuek> => "nauzue" ;
              <Ni,Hauek> => "naute" ;
              <Hi,Ni> => "haut" ;
              <Hi,Hi> => Prelude.nonExist ; 
              <Hi,Zu> => Prelude.nonExist ;
              <Hi,Hau> => "hau" ;
              <Hi,Gu> => "haugu" ;
              <Hi,Zuek> => Prelude.nonExist ;
              <Hi,Hauek> => "haute" ;
              <Zu,Ni> => "zaitut" ;
              <Zu,Hi> => Prelude.nonExist ;
              <Zu,Zu> => Prelude.nonExist ;
              <Zu,Hau> => "zaitu" ;
              <Zu,Gu> => "zaitugu" ;
              <Zu,Zuek> => Prelude.nonExist ;
              <Zu,Hauek> => "zaituzte" ;
              <Hau,Ni> => "dut" ;
              <Hau,Hi> => "duk" | "dun" ; -- FIXME: Gender
              <Hau,Zu> => "duzu" ;
              <Hau,Hau> => "du" ;
              <Hau,Gu> => "dugu" ;
              <Hau,Zuek> => "duzue" ;
              <Hau,Hauek> => "dute" ;
              <Gu,Ni> => Prelude.nonExist ;
              <Gu,Hi> => "gaituk" | "gaitun" ;
              <Gu,Zu> => "gaituzu" ;
              <Gu,Hau> => "gaitu" ;
              <Gu,Gu> => Prelude.nonExist ;
              <Gu,Zuek> => "gaituzue" ;
              <Gu,Hauek> => "gaituzte" ;
              <Zuek,Ni> => "zaituztet" ;
              <Zuek,Hi> => Prelude.nonExist ;
              <Zuek,Zu> => Prelude.nonExist ;
              <Zuek,Hau> => "zaituzte" ;
              <Zuek,Gu> => "zaituztegu" ;
              <Zuek,Zuek> => Prelude.nonExist ;
              <Zuek,Hauek> => "zaituztete" ;
              <Hauek,Ni> => "ditut" ;
              <Hauek,Hi> => "dituk" | "ditun" ; -- FIXME: Gender
              <Hauek,Zu> => "dituzu" ;
              <Hauek,Hau> => "ditu" ;
              <Hauek,Gu> => "ditugu" ;
              <Hauek,Zuek> => "dituzue" ;
              <Hauek,Hauek> => "dituzte" 
   } ;

-- ibili, ibiltzen, ibiliko
-- amildu, amiltzen, amilduko

-- choose copula based on transitivity(argstruct) of main verb.

    copula = copulaNor ;

-- Clause stuffs
    --later: something like Tense => Anteriority => Polarity => (basque-specific parameters) => Str ;
    Clause : Type = {s : Str} ; 

    mkClause : NounPhrase -> VerbPhrase -> Clause ;
    mkClause np vp = 
      let
        presCl = vp.adv ++ np.s ! Abs ++ vp.compl ++ vp.s ! np.agr ; --later: choose present,
	someOtherTenseCl = "sentence in some other tense than present" ; -- choose some other tenses
      in ss presCl ;
      -- later:
      -- { s = table {
      --         PresentStuffs    => presCl ;
      -- 	 NonPresentStuffs => someOtherTenseCl 
      --       }
      -- } ;
}
