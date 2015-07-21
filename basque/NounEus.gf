concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    --UseN : N -> CN
    UseN n = lin CN n  ;

    --UsePN   : PN -> NP ;          -- John
    UsePN pn = { s = table { _ => pn.s } ; agr = Hau }  ;

    NumSg = {s = [] ; n = Sg ; isNum = False} ; 
    NumPl = {s = [] ; n = Pl ; isNum = False} ; 

    --DefArt, IndefArt : Quant
    --Notation explanation: The string in s will start with BIND,
    --and a string from artA. The parameters n,c,p will eventually come
    --from later functions, and they will be used to extract the wanted
    --string from artA.
    --This is equivalent to having written
    --  artA = table { Sg =>
    --                  table { Abs =>
    --	                         table { FinalA = BIND ++ "a" ;
    --                                   FinalR = BIND ++ "ra" ; ...
    DefArt, IndefArt = { s = \\n,c,p => BIND ++ artA ! n ! c ! p };


    -- AdjCN   : AP -> CN  -> CN 
    AdjCN ap cn = {s    = cn.s ++ ap.stem ; 
		   stem = cn.s ++ ap.stem ; 
		   ph   = ap.ph} ;
    
    -- DetCN : Det -> CN -> NP
    DetCN det cn = {
      s = \\cas => cn.stem ++ det.s ! cas ! cn.ph ;
      agr = case det.nbr of {
	      Sg => Hau ;
	      Pl => Hauek 
	    }
    } ;

    DetQuant quant num = {
        s = \\cas,ph => quant.s ! num.n ! cas ! ph ;
        nbr = num.n 
    } ;



oper
  artA : Number => Case => Phono => Str =
   table { Sg => table {Abs => table {FinalA => "a"  ;
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

          } ; 

}
