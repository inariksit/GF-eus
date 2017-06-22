--# -path=.:../abstract:../common:../prelude

concrete SymbolEus of Symbol = CatEus ** open Prelude, ParadigmsEus in {

lin

  --  : Symb -> PN ;                -- x
  SymbPN i = mkPNoun "A" ; --i.s ; 

  -- : Int -> PN ;                 -- 27
--  IntPN i  = ;

  -- : Float -> PN ;               -- 3.14159
--  FloatPN i = {s = } ;

  -- : Card -> PN ;                -- twelve [as proper name]
--  NumPN i = {s = i.s } ;

--  CNIntNP cn i = {} ;

--  -- : Det -> CN -> [Symb] -> NP ; -- (the) (2) numbers x and y
--  CNSymbNP det cn xs = {   } ;

--  -- : CN -> Card -> NP ;          -- level five ; level 5
--  CNNumNP cn i = {    } ;



  SymbS sy = { beforeAux = sy.s ; 
               aux = {indep = "da" ; stem = "de" } ;
               afterAux = [] } ;

  --SymbNum sy = { s = []} ;
  --SymbOrd sy = { s = []} ;

lincat 

  Symb, [Symb] = SS ;

lin
  MkSymb s = s ;

  BaseSymb = infixSS "eta" ;
  ConsSymb = infixSS "," ;



}
