resource MorphoEus = open Prelude in {

-- zu p2.frm.sg
-- hi p2.fam.sg
-- zuek p2.pl

param
  Number = Sg | Pl ;
  Case   = Erg | Abs | Dat ;
  Agr    = Ag Number Person ; -- | FamSg2 ; -- FIXME: add case here
  TTense = TPres ; --| TPerf | TPast | TFut ;
  Person = Per1 | Per2 | Per3 ;

  VForm = VPres ; -- | VInf | VPast | VPart ;

  ClForm = ClDir | ClInv ;
  QForm = QDir | QIndir ;

-- parts of speech

oper
  VP = {
    verb  : Verb ; 
    compl : Str
    } ;

  NP = {
    s : Case => Str ;
    a : Agr
    } ; 

  pronNP : (s : Str) -> Number -> Person -> NP =
  \s,n,p -> {
    s = table {
      Abs => s ;
      Erg => s + "k" ;
      Dat => s + "ri" 
      } ;
    a =  Ag n p
    } ;

-- dakizu ? badakit!

  conjAgr : Number -> Agr -> Agr -> Agr = \n,xa,ya -> 
    case <xa,ya> of {
      <Ag xn xp, Ag yn yp> =>
        Ag (conjNumber (conjNumber xn yn) n) (conjPerson xp yp)
      } ;


  conjNumber : Number -> Number -> Number = \m,n ->
    case m of {Pl => Pl ; _ => n} ;

  conjPerson : Person -> Person -> Person = \p,q ->
    case <p,q> of {
      <Per1,_> | <_,Per1> => Per1 ;
      <Per2,_> | <_,Per2> => Per2 ;
      _                   => Per3
      } ;


  Noun : Type = {s : Str} ;
  Adj  : Type = {s : Str} ;
  Post : Type = {s : Str} ;

--  mkNoun : Str -> Noun = \katu -> {
--    s = table { 
--                                      -- KATU        | NESKA
--            Abs => katu ;             -- katu        |   neska
--            Erg => katu + "k" ;       -- katuk       |   neskak 
--            Dat => katu + "ri"        -- katuri      |   neskari
--      }
--  } ;

  mkNoun : Str -> Noun = \s -> ss s ; 

  mkAdj : Str -> Adj = \s -> ss s ;

  mkPost : Str -> Post = \s -> ss s ;

  neg : Bool -> Str = \b -> case b of {True => [] ; False => "ez"} ;

  Verb : Type = {
    s : ClForm => TTense => Bool => Agr => Str ;
  } ;

  copula : Verb = {
    s = \\d,t,p,a => case <t,a> of {
       <TPres,Ag Sg Per1> => "naiz"  ;
       <TPres,Ag Sg Per3> =>  "da"    ;
       <TPres,Ag Sg Per2> =>  "zara"  ;
       <TPres,Ag Pl Per1> =>  "gara"   ;
       <TPres,Ag Pl Per2> =>  "zarete"   ;
       <TPres,Ag Pl Per3> =>  "dira"   ;
       <TPres,_            > =>  "da"  
       } 
    } ;

}
