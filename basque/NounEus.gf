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
                 Sg => table {Abs => table {FinalA => []   ;
					    _      => "a" } ;
		              Erg => table {FinalA => "k"  ;
					    _      => "ak" } ;
		              Dat => table {FinalA => "ri" ;
					    _      => "ari" } }; 

                 Pl => table {Abs => table {FinalA => "k" ; _ => "ak"};
		              Erg => table {_ => "ek" } ;
		              Dat => table {_ =>"iai" } }

                } ;
    };

    -- DetCN : Det -> CN -> NP
    DetCN det cn = {
      s = \\cas => cn.s ++ BIND ++ det.s ! det.nbr ! cas ! cn.ph ;
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
