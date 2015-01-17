concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    --UseN : N -> CN
    UseN n = n ;

    NumSg = {s = []; n = Sg ; isNum = False} ; 
    NumPl = {s = []; n = Pl ; isNum = False} ; 

    --DefArt : Quant
    DefArt = {
      s = table {
                 Sg => table {_ => "a"  } ; 
                 Pl => table {_ => "ak" } 
                } ;
    };

    -- DetCN : Det -> CN -> NP
    DetCN det cn = {
      s = \\cas => cn.s ++ BIND ++ det.s ! det.nbr ! cas  ;
      agr = SgP3 ; --TODO choose agreement based on det.nbr
    } ;

    DetQuant quant num = {
        s = \\nbr,cas => quant.s ! num.n ! Abs ;
        nbr = num.n ;
        cas = Abs 
    } ;


}
