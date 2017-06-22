--# -path=.:../abstract:../basque

concrete ExtensionsEus of Extensions = 
  CatEus ** open ResEus, ParadigmsEus, ExtraEus, SentenceEus, Prelude in {

lincat
  VPS = SS ;

lin

   -- : Temp -> Pol -> VP -> VPS ;  -- had walked
   MkVPS t p vp = lin VPS  { s = linVP vp } ; -- TODO this just chooses present


   UttAdV adv = adv ;


  --GerundCN    : VP -> CN ;          -- publishing of the document (can get a determiner)
  --GerundNP    : VP -> NP ;          -- publishing the document (by nature definite)
  --GerundAdv   : VP -> Adv ;         -- publishing the document (prepositionless adverb)

  --ByVP        : VP -> Adv ;         -- by publishing the document  
  -- asko ibiltzeaz

  -- WithoutVP   : VP -> Adv ;         -- without publishing the document  
  -- Artzain zaharra  atera zen  mendirantz       inori      ezer     esan gabe.
  -- shepherd old     went       mountain.toward  to.nobody  nothing  said without
  WithoutVP vp = { s = vp.adv           -- gaur
                      ++ vp.iobj.s        -- mutilari
                      ++ vp.dobj.s ! Neg  -- garagardorik 
                      ++ vp.comp ! Hau
                      ++ vp.prc ! Past    -- eman 
                      ++ "gabe" } ;       -- gabe

  -- : VP -> Adv ;         -- (in order) to publish the document
  -- hemen ibiltzeko ‘in order to walk here’,
  -- ongi hiltzeko ‘in order to die well’, ona izateko ‘in order to be good’.
  -- haurra noratzen zuten ikusteko ‘in order to see where they took the child’.]
  -- corresponding interrogative is zertarako ‘what for’
  InOrderToVP vp = { s = vp.adv          -- gaur
                        ++ vp.iobj.s       -- mutilari
                        ++ vp.dobj.s ! Pos -- garagardoa
                        ++ vp.comp ! Hau
                        ++ glue vp.nstem "ko" --emateko
                     } ;

}
