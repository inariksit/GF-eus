concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

    UseN = \n ->  n ;

    NumSg = {s = []; n = Sg ; isNum = False} ; 
    NumPl = {s = []; n = Pl ; isNum = False} ; 

    DefArt = {
      s = table {
                 Sg => table {_ => "a"  } ; 
                 Pl => table {_ => "ak" } 
                } 
    };

    DetCN det cn = {
      s = \\nbr,cas => cn.s ++ det.s ! nbr ! cas  ;
      isPron = False
    } ;

    DetQuant quant num = {
        s = \\nbr,cas => quant.s ! num.n ! Abs ;
        nbr = num.n ;
        cas = Abs 
    } ;


}
