concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    --UseN : N -> CN
    UseN n = lin CN n  ;

    --UsePN   : PN -> NP ;          -- John
    UsePN pn = { s = table { _ => pn.s } ; agr = Hau ; anim = pn.anim }  ;

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
      isPre = False
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


{-
   NOTE: This is non-optimal as really the -ko should be a node in
     the tree. We would like to have e.g. 
        [NP [AP [PP Bilbora [-ko]]] [N kale]] 
     or something similar. This way we could treat APs like [AP [A berri]] 
     and `adnominal' postpositional phrases similarly... as they both take 
     all of the article declination.
-}

    -- AdvCN   : CN -> Adv -> CN ;   -- house on the hill
--    AdvCN cn ad = {
--      s    = ad.s ++ BIND ++ "ko" ++ cn.s ; 
--      stem = ad.s ++ BIND ++ "ko" ++ cn.s ; 
--      ph   = cn.ph ;
--      anim = cn.anim } ;

    
    -- DetCN : Det -> CN -> NP
    DetCN det cn = {
      s = \\cas => cn.stem ++ det.s ! cas ! cn.ph ;
      agr = case det.nbr of {
	      Sg => Hau ;
	      Pl => Hauek 
	    } ;
      anim = cn.anim
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
