concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    --UseN : N -> CN
    UseN n = n  ;

    NumSg = {s = []; n = Sg ; isNum = False} ; 
    NumPl = {s = []; n = Pl ; isNum = False} ; 

    --DefArt : Quant
    DefArt = {
      s = table {
                 Sg => table {Abs => table {FinalA => "a"  ;
					    FinalR => "ra" ;
					    _      => "a" } ;
		              Erg => table {FinalA => "ak"  ;
					    FinalR => "rak" ;
					    _      => "ak" } ;
		              Dat => table {FinalA => "ri" ;
					    FinalR => "rari" ;
					    _      => "ari" } }; 

                 Pl => table {Abs => table {FinalA => "ak"  ;
					    FinalR => "rak" ;
					    _      => "ak" } ;
		              Erg => table {FinalA => "ek"  ;
					    FinalR => "rek" ;
					    _      => "ek" } ;
		              Dat => table {FinalR => "rei" ;
					    _      => "ei" } }

                } 
    };

    -- AdjCN   : AP -> CN  -> CN 
    AdjCN ap cn = {s    = cn.s ++ ap.stem ; 
		   stem = cn.s ++ ap.stem ; 
		   ph   = ap.ph} ;
    
    -- DetCN : Det -> CN -> NP
    DetCN det cn = {
      s = \\cas => cn.stem ++ BIND ++ det.s ! det.nbr ! cas ! cn.ph ;
      agr = case det.nbr of {
	      Sg => Hau ;
	      Pl => Hauek 
	    }
    } ;

    DetQuant quant num = {
        s = \\nbr,cas,ph => quant.s ! num.n ! cas ! ph ;
        nbr = num.n ;
        cas = Abs 
    } ;


}
