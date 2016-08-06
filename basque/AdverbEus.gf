concrete AdverbEus of Adverb = CatEus ** open ResEus, Prelude in {

lin

    --PositAdvAdj : A -> Adv ;
    PositAdvAdj adj = { s = glue (adj.s ! Posit) "an" } ; --?????? no idea, got it from google translate :-D

--    ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
--    ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs

  -- : Prep -> NP -> Adv ;
  PrepNP post np = { s = ResEus.applyPost post np } ;
 
-- Adverbs can be modified by 'adadjectives', just like adjectives.

    --AdAdv  : AdA -> Adv -> Adv ;             -- very quickly
  AdAdv ada adv = { s = ada.s ++ adv.s } ;
-- Like adverbs, adadjectives can be produced by adjectives.

    --PositAdAAdj : A -> AdA ;                 -- extremely

-- Subordinate clauses can function as adverbs.

    --: Subj -> S -> Adv ;
  SubjS subj s = 
  	let auxFull : Str = 
  		if_then_Str subj.isPre (glue subj.s s.aux.indep)  -- badator
  		 				       (glue s.aux.stem subj.s) ; -- datorrenean

    in { s = s.beforeAux ++ auxFull ++ s.afterAux } ;

-- Comparison adverbs also work as numeral adverbs.

    --AdnCAdv : CAdv -> AdN ;                  -- less (than five)
    --AdnCAdv cadv = {s = } ;
} ;

{-
gt PrepNP in_Prep (DetCN (DetQuant DefArt ?) (UseN ?) | l -bind
gt PrepNP from_Prep (DetCN (DetQuant DefArt ?) (UseN ?)) | l -bind
-}