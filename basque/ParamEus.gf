resource ParamEus = ParamX ** {

	
param 

  ClType = Stat | Indir | Qst ;

{-
   Type of copula used, e.g. 
 
     Miren lorategi+a+n dago [CopulaType = Egon]
     Miren irakasle+a da [CopulaType = Izan]
-}
  CopulaType = Egon | Izan  ; 

  Valency = Nor | NorNork | NorNori | NorNoriNork ;

{-
   Type of adjectival phrase, e.g.
 
      kale txiki+a [APType = Bare]
      itsaso+ra+ko kale+a [APType = Ko]
-}
  APType = Ko | Bare ; 

  Bizi = Inan | Anim ;

  Case = Abs | Erg | Dat | Par  -- Core argument cases
       | Gen | Soc | Ins | Ine -- Irregular stems
       | LocStem ;  -- LocStem is inessive without -an; many other cases use same stem!


--    Degree = Posit | Compar | Superl | Excess ;
--    CardOrd = NCard | NOrd ;

  Gender = Masc | Fem ;

  Agr = Ni | Hi Gender | Zu | Hau | Gu | Zuek | Hauek ;


  Phono = FinalA | FinalR | FinalCons | FinalVow ; 


oper 
 -- Opers to manipulate params.
 -- Probably better to have Agr as Ag Number Person (and Hi, if wanted).

  sgAgr : Agr -> Agr = \agr ->
       case agr of { Gu    => Ni ;
                     Zuek  => Zu ;
                     Hauek => Hau ;
                     agr   => agr } ;

  plAgr : Agr -> Agr = \agr ->
    case agr of { Ni  => Gu ;
                  Zu  => Zuek ;
                  Hi _ => Zuek ;
                  Hau => Hauek ;
                  agr => agr } ;

  getNum : Agr -> Number = \np ->
    case np of {
        (Ni|Hi _|Zu|Hau)  => Sg ;
        (Gu|Zuek|Hauek) => Pl 
    } ;

  getPers : Agr -> Person = \np ->
    case np of {
        (Ni|Gu)      => P1 ;
        (Hi _ |Zu|Zuek) => P2 ;
        (Hau|Hauek)  => P3
    } ;

  subjCase : Valency -> Case = \val ->
    case val of {
      Nor     => Abs ;
      NorNori => Dat ;
      _       => Erg  } ;

}