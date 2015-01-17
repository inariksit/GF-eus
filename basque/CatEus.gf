concrete CatEus of Cat = 
  CommonX **
  open ResEus, Prelude in {
  flags optimize=all_subs ;

  lincat

    Det = {s : Number => Case => Str ; cas : Case ; nbr : Number } ;

-- Noun

    CN = {s : Str } ;

    NP = {s : Number => Case => Str } ;

    Num = {s : Str ; n : Number ; isNum : Bool} ;

    Quant = {
      s  : Number => Case => Str 
    } ;


    N  = Noun ;

}
