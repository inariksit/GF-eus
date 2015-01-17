resource ResEus = ParamX ** open Prelude in {

  flags optimize=all ;
  coding=utf8 ;

--2 For $Noun$

param
    Case = Erg | Abs | Dat ;

  oper 
    Noun = {s : Str } ;

  mkClause : (Polarity -> Str) -> Agr -> VP -> Clause = 
    \sub,agr,vp -> {
      s = \\t,a,b => 
      let
        c = (mkClausePlus sub agr vp).s ! t ! a ! b ;
        --                 saan              sinust     aru    0
        --       ma        olen     täna     sinust     aru    saanud
        declCl = c.subj ++ c.fin ++ c.adv ++ c.compl ++ c.p ++ c.inf ++ c.ext ;
        --                                [sind näha]  0      tahtnud
        --      täna     olen     ma        sinust     aru    saanud
        invCl = c.adv ++ c.fin ++ c.subj ++ c.compl ++ c.p ++ c.inf ++ c.ext
      in 
         table {
           SDecl  => declCl ;
           SQuest => "al" ++ declCl ;
           SInv   => invCl 
         }
      } ;

}
