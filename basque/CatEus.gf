concrete CatEus of Cat = 
  CommonX **
  open ResEus, Prelude in {
  flags optimize=all_subs ;

  lincat

    Det = {s : Number => Case => Str ; cas : Case ; nbr : Number } ;

-- Noun
    N = ResEus.Noun ;

    CN = ResEus.Noun ;       --{s : Str} ;

    NP = ResEus.NounPhrase ; --{s : Case => Str ; agr : Agr} ;

    

    Comp = ResEus.Complement ; --{s : Case => Str } ;

    Num = {s : Str ; n : Number ; isNum : Bool} ;

    Quant = {
      s  : Number => Case => Str 
    } ;

-- Adjective
    A = ResEus.Noun ; 
    AP = ResEus.NounPhrase ;

-- Verb
    V  = ResEus.Verb ;
    V2 = ResEus.Verb2 ;
    VP = ResEus.VerbPhrase ; 

-- Clause
    Cl = ResEus.Clause ;

}
