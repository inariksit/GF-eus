concrete AdjectiveEus of Adjective = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    --PositA  : A  -> AP ;
    --A  : {s : Degree => Str ; ph : Phono} 
    --AP : {s : Str ; stem : Str ; ph : Phono}  
    PositA a = lin AP {s    = a.s ! Posit ; 
		       stem = a.s ! Posit ; 
		       ph   = a.ph} ;


    --ComparA : A  -> NP -> AP ;  -- euskara ingelesa baino errazagoa da.
     ComparA a np = lin AP {s    = np.s ! Abs ++ "baino" ++ a.s ! Compar ; 
			    stem = np.s ! Abs ++ "baino" ++ a.s ! Compar ; 
			    ph   = a.ph
			    } ;
}