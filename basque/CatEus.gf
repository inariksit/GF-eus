concrete CatEus of Cat = 
  CommonX **
  open ResEus, Prelude in {
  flags optimize=all_subs ;

  lincat

    Det = {s : Number => Case => Phono => Str ; cas : Case ; nbr : Number } ;

-- Noun
    N = ResEus.Noun ;       --{s : Str ; ph = Phono} ;

    CN = ResEus.Noun ;

    NP = ResEus.NounPhrase ; --{s : Case => Str ; agr : Agr} ;

    

    Comp = ResEus.Complement ; --{s : Case => Str } ;

    Num = {s : Str ; n : Number ; isNum : Bool} ;

    Quant = {
      s  : Number => Case => Phono => Str 
    } ;

-- Adjective
    A = ResEus.Adjective ; 
    AP = ResEus.Noun ; 

-- Verb
    V  = ResEus.Verb1 ;
    V2 = ResEus.Verb2 ;
    VP = ResEus.VerbPhrase ; 
    VPSlash = ResEus.VPSlash ;

-- Clause
    Cl = ResEus.Clause ;

}
