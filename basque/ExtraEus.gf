concrete ExtraEus of ExtraEusAbs = CatEus ** open ResEus, AdjectiveEus, Prelude, ParadigmsEus in {

flags coding = utf8 ;

lincat 

  Attr = { s : Str } ;

oper

  mkAttr : Str -> Attr = \s -> lin Attr { s = s } ; 

lin

--	AdvAP : Adv -> Attr -> AP ;  -- Bilbo ra ko 

  AdvAP adv attr = {
      s    = adv.s ++ BIND ++ attr.s ; 
      stem = adv.s ++ BIND ++ attr.s ; 
      ph = FinalVow ;
      typ = Ko 
  } ;

} ;
