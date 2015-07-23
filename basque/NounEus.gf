concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    --UseN : N -> CN
    UseN n = lin CN n  ;


{-
    NOTE: This is horrible, cases should probably go somewhere better :D
-}

    --UsePN   : PN -> NP ;          -- John
    UsePN pn = { s = table { Erg => pn.s ++ BIND ++ "ek" ; 
                             Dat => pn.s ++ BIND ++ "i" ;
                             Par => pn.s ++ BIND ++ "ik" ;
                             Abs => pn.s ;
                             _ => pn.s } ; 
                 agr = Hau ; 
                 anim = pn.anim ; nbr = Sg }  ;

    NumSg = {s = [] ; n = Sg ; isNum = False} ; 
    NumPl = {s = [] ; n = Pl ; isNum = False} ; 

    --DefArt, IndefArt : Quant
    --Notation explanation: The string in s will start with BIND,
    --and a string from artA. The parameters n,c,p (number, case, phonology) 
    --will eventually come
    --from later functions, and they will be used to extract the wanted
    --string from artA.
    --This is equivalent to having written
    --  artA = table { Sg =>
    --                  table { Abs =>
    --	                         table { FinalA = BIND ++ "a" ;
    --                                   FinalR = BIND ++ "ra" ; ...
    DefArt, IndefArt = {
      s = \\n,c,p => BIND ++ artA ! n ! c ! p ;
      isPre = False ;
      nbr = Sg
    };


    -- AdjCN   : AP -> CN  -> CN 
    AdjCN ap cn =
      let result = case ap.typ of {
                     Ko => ap.stem ++ cn.s ; 
                     Bare => cn.s ++ ap.stem 
                   } ;
      in { s,stem = result ;
           ph     = ap.ph ;
           anim   = cn.anim } ;


    -- DetCN : Det -> CN -> NP
    DetCN det cn = {
      s = \\cas => cn.stem ++ det.s ! cas ! cn.ph ;
      agr = case det.nbr of {
	      Sg => Hau ;
	      Pl => Hauek 
	    } ;
      anim = cn.anim ;
      nbr = det.nbr
    } ;

    DetQuant quant num = {
      s = \\cas,ph => quant.s ! num.n ! cas ! ph ;
      nbr = num.n ;
      isPre = quant.isPre
    } ;


    --PossPron : Pron -> Quant
    PossPron pron = {
      s     = \\_,_,_ => "" ;
      isPre = True
    } ;


oper
  artA : Number => Case => Phono => Str =
   table { Sg => table {Abs => table {FinalA   => "a"  ;
                                      FinalR   => "ra" ;
                                      _        => "a" } ;
                        Erg => table {FinalA   => "ak"  ;
                                      FinalR   => "rak" ;
                                      _        => "ak" } ;
                        Dat => table {FinalA   => "ri" ;
                                      FinalR   => "rari" ;
                                      _        => "ari" } ;
                        Par => table {FinalA   => "rik" ;
                                      FinalR   => "rarik" ;
                                      FinalVow => "rik" ;
                                      FinalCons => "ik" } 
                        }; 

           Pl => table {Abs => table {FinalA => "ak"  ;
                                      FinalR => "rak" ;
                                      _      => "ak" } ;
                        Erg => table {FinalA => "ek"  ;
                                      FinalR => "rek" ;
                                      _      => "ek" } ;
                        Dat => table {FinalR => "rei" ;
                                      _      => "ei" } ;
                        Par => table {_ => Prelude.nonExist } 
                        }

          } ; 

}
