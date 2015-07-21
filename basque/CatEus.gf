concrete CatEus of Cat = 
  CommonX **
  open ResEus, Prelude in {
  flags optimize=all_subs ;

  lincat

    Det = {s : Case => Phono => Str ;
	   nbr : Number } ;

-- Noun
    N = ResEus.Noun ;       --{s : Str ; ph = Phono} ;

    PN = ResEus.Noun ** { nbr : Number } ; 

    CN = ResEus.Noun ;

    NP = ResEus.NounPhrase ; --{s : Case => Str ; agr : Agr} ;

    Conj = {s : Str } ;

    Comp = ResEus.Complement ; --{s : Agr => Str } ;

    Num = {s : Str ; n : Number ; isNum : Bool} ;

    Quant = {
      s  : Number => Case => Phono => Str 
    } ;

-- Adjective
    A = ResEus.Adjective ; 
    AP = ResEus.Noun ; 

-- Verb
    V, VQ, VA = ResEus.Verb1 ;
    V2 = ResEus.Verb2 ;
    V3 = ResEus.Verb3 ;
    VP = ResEus.VerbPhrase ; 
    VPSlash = ResEus.VPSlash ;

-- Clause
    Cl = ResEus.Clause ;

}
