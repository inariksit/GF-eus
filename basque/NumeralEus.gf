concrete NumeralEus of Numeral = CatEus [Numeral,Digits] ** open Prelude, ResEus, ParamX in {
-- include numerals.Abs.gf ;

oper LinDigit = {s : DForm => Str ; even20 : Even20 ; n : Number} ;

oper mk20Ten : Str -> Str -> Str -> Str -> LinDigit = 
  \tri -> \t -> \fiche -> \h -> 
  { s = table {unit => tri ; teen => t ; twenty => fiche ; hund => h + "ehun"} ; even20 = ten ; n = Pl} ;

oper mkEven20 : Str -> Str -> Str -> Str -> LinDigit = 
  \se -> \t -> \trifichid -> \h -> 
  { s = table {unit => se ; teen => t ; twenty => trifichid ; hund => h + "ehun"} ; even20 = even ; n = Pl} ;

param Even20 = ten | even ;
param DForm = unit | teen | twenty | hund ;
 
--lincat Numeral = {s : Str} ;
lincat Digit = LinDigit ;
lincat Sub10 = LinDigit ;
lincat Sub100 = {s : Str ; n : Number } ;
lincat Sub1000 = {s : Str ; n : Number ; isHundred : Bool } ;
lincat Sub1000000 = {s : Str ; n : Number} ;

--  num : Sub1000000 -> Numeral ;
lin num x0 = lin Numeral x0 ;

lin n2  = mkEven20 "bi" "hamabi" "hogei" "berr" ; 
lin n3  = mk20Ten "hiru" (variants {"hamahiru" ; "hamahirur"}) "hogei" "hirur";
lin n4  = mkEven20 "lau" (variants {"hamalau" ; "hamalaur"}) "berrogei" "laur";
lin n5  = mk20Ten "bost" (variants {"hamabost" ; "hamabortz"}) "berrogei" "bost"; 
lin n6  = mkEven20 "sei" "hamasei" "hirurogei" "seir" ;
lin n7  = mk20Ten "zazpi" "hamazazpi" "hirurogei" "zazpi" ;
lin n8  = mkEven20 "zortzi" "hemezortzi" "laurogei" "zortzi" ;
lin n9  = mk20Ten "bederatzi" "hemeretzi" "laurogei" "bederatzi" ;

lin pot01  =
  {s = table {unit => "bat" ; hund => "ehun" ; _ => "dummy"} ; even20 = ten ; n = Sg};
lin pot0 d = {s = d.s ; even20 = d.even20 ; n = d.n} ;
lin pot110 = {s = "hamar" ; n = Pl} ;
lin pot111 = {s = variants {"hamaika" ; "hameka"} ; n = Pl} ;
lin pot1to19 d = {s = d.s ! teen ; n = Pl} ;
lin pot0as1 n = {s = n.s ! unit ; n = n.n} ;
lin pot1 d =
  {s = table {even => d.s ! twenty ;  
              ten => d.s ! twenty ++ "tahamar"} ! d.even20 ; -- glue
   n = Pl} ;
lin pot1plus d e =
  {s = table {even => d.s ! twenty ++ "ta" ++ e.s ! unit;  
              ten => d.s ! twenty ++ "ta" ++ e.s ! teen} ! (d.even20) ; 
   n = Pl} ;

lin pot1as2 n = n ** { isHundred = False } ; 
lin pot2 d = {s = d.s ! hund ; n = Pl ; isHundred = True } ;
lin pot2plus d e =
  { s = d.s ! hund ++ "ta" ++ e.s ;
    n = Pl ;
    isHundred = True } ;
lin pot2as3 n = n ;
lin pot3 n =
  {s = table {Sg => [] ; Pl => n.s } ! n.n ++ "mila" ;
   n = n.n } ;

  --TODO: no ta between 1000 and 100
lin pot3plus n m =
  let ta = if_then_Str m.isHundred [] "ta" ;
  in 
    { s = table {Sg => [] ; Pl => n.s } ! n.n ++ "mila" ++ ta ++ m.s ;
      n = n.n } ;

}
