--# -path=.:../english:../common:../abstract:../prelude

resource TryEus = SyntaxEus-[mkAdN], LexiconEus, ParadigmsEus - [mkAdv,mkAdN,mkOrd,mkQuant] ** 
  open (P = ParadigmsEus) in {

oper

  mkAdv = overload SyntaxEus {
    mkAdv : Str -> Adv = P.mkAdv ;
  } ;

  mkAdN = overload {
    mkAdN : CAdv -> AdN = SyntaxEus.mkAdN ;
    mkAdN : Str -> AdN = P.mkAdN ;
  } ;

  mkOrd = overload SyntaxEus {
    mkOrd : Str -> Ord = P.mkOrd ;
  } ;


}
