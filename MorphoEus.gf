resource MorphoEus = open Prelude in {

-- zu p2.frm.sg
-- hi p2.fam.sg
-- zuek p2.pl

param
  Number = Sg | Pl ;
  Case   = Erg | Abs | Dat ;
  Agr    = Ag Number Person Case | FamSg2 ;
  TTense = TPres ; --| TPerf | TPast | TFut ;
  Person = Per1 | Per2 | Per3 ;

  VForm = VPres ; -- | VInf | VPast | VPart ;

  ClForm = ClDir | ClInv ;
  QForm = QDir | QIndir ;

-- parts of speech

oper
  VP = {
    verb  : AgrVerb ; 
    compl : Str
    } ;

  NP = {
    s : Case => Str ;
    a : Agr
    } ; 

  i_NP = pronNP "ni" "nik" 

-- dakizu ? badakit!

  AgrVerb : Type = {
    s : ClForm => TTense => Bool => Agr => Str ;
  } ;

  

}