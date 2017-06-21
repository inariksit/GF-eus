--# -path=.:../abstract:../basque

concrete ExtensionsEus of Extensions = 
  CatEus ** open ResEus, ParadigmsEus, ExtraEus, SentenceEus, Prelude in {


lin

   MkVPS = ExtraEus.MkVPS ;


   UttAdV adv = adv ;


  --GerundCN    : VP -> CN ;          -- publishing of the document (can get a determiner)
  --GerundNP    : VP -> NP ;          -- publishing the document (by nature definite)
  --GerundAdv   : VP -> Adv ;         -- publishing the document (prepositionless adverb)

  --ByVP        : VP -> Adv ;         -- by publishing the document  
  -- asko ibiltzeaz

  -- WithoutVP   : VP -> Adv ;         -- without publishing the document  
  -- Artzain zaharra  atera zen  mendirantz       inori      ezer     esan gabe.
  -- shepherd old     went       mountain.toward  to.nobody  nothing  said without
  WithoutVP vp = { s = vp.prc ++ "gabe" } ; 

  --InOrderToVP : VP -> Adv ;         -- (in order) to publish the document
  -- hemen ibiltzeko ‘in order to walk here’,
  -- ongi hiltzeko ‘in order to die well’, ona izateko ‘in order to be good’.
  -- haurra noratzen zuten ikusteko ‘in order to see where they took the child’.]
  -- corresponding interrogative is zertarako ‘what for’

}
