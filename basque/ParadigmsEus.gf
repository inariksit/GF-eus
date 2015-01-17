resource ParadigmsEus = open Prelude,  ResEus, CatEus in {

oper
  mkN : Str -> N = \s -> lin N {s = s} ;
  mkA : Str -> A = \s -> lin A {s = s} ;
  mkV : Str -> V = \s -> lin V {s = table {_ => s}} ;


  mkV2 = overload {
   mkV2 : Str -> V2 = \s -> lin V2 {s = table {_ => s} ; cas = Abs} ;
   mkV2 : Str -> Case -> V2 = \s,cas -> lin V2 {s = table {_ => s} ; cas = cas} ;
  } ;

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;
  mkPrep : Str -> Prep = \s -> lin Prep {s = s} ;

}