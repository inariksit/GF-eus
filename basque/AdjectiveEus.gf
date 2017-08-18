concrete AdjectiveEus of Adjective = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

  -- : A  -> AP ;
  PositA a = a ** { s    = a.s ! Posit ; 
                    typ  = Bare } ;


  -- : A  -> NP -> AP ;  -- euskara ingelesa baino errazagoa da.
  ComparA a np = a ** {
       s    = np.s ! Abs ++ "baino" ++ a.s ! Compar ; 
       typ  = Bare
     } ;


    --AdAP    : AdA -> AP -> AP ; 
  AdAP ada ap = ap ** {
      s = ada.s ++ ap.s ; 
      typ = Bare  
    } ;

  -- : CAdv -> AP -> NP -> AP ; -- as cool as John
  CAdvAP adv ap np = ap ** {
      s = np.s ! Abs ++ adv.s ++ ap.s
    } ;
}
