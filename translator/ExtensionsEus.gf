--# -path=.:../abstract:../basque

concrete ExtensionsEus of Extensions = 
  CatEus ** open ResEus, ParadigmsEus, ExtraEus, SentenceEus, Prelude in {


lin

   MkVPS = ExtraEus.MkVPS ;


   UttAdV adv = adv ;

{-
     Artzain zaharra atera zen mendirantz inori ezer esan gabe.
-}

   WithoutVP vp = { s = vp.prc ++ "gabe" } ; 


}
