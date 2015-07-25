concrete ExtraEus of ExtraEusAbs = CatEus ** open ResEus, AdjectiveEus, Prelude, ParadigmsEus in {

flags coding = utf8 ;

lincat 

  Attr = { s : Str } ;

oper

  mkAttr : Str -> Attr = \s -> lin Attr { s = s } ; 

--lin

-- ko_Attr = mkAttr "ko" ;

{-
   Tokiorako bidaia bat 'a journey to Tokyo' [Tokyo-to-ko journey one]

-}

--	AdnP : Adv -> Attr -> AP ;  -- Bilbo ra ko 

--  AdnP adv attr = {
--      s    = adv.s ++ BIND ++ attr.s ; 
--      stem = adv.s ++ BIND ++ attr.s ; 
--      ph = FinalVow ;
--      typ = Ko 
--  } ;

--    MkVPS t p vp = {
--      s = \\a => 
--            let 
--              verb = vp.s ! t.t ! t.a ! p.p ! oDir ! a ;
--              verbf = verb.aux ++ verb.adv ++ verb.fin ++ verb.inf ;
--            in t.s ++ p.s ++ vp.ad ! a ++ verbf ++ vp.p ++ vp.s2 ! a ++ vp.ext
--      } ;

    MkVPS t p vp = {
      s = \\a => 
            let 
              verb = vp.s ! t.t ! t.a ! p.p ! a 
            in t.s ++ p.s ++ vp.ad ! a ++ vp.p ++ vp.s2 ! a ++ vp.ext
      } ;


} ;
