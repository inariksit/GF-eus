concrete AdverbEus of Adverb = CatEus ** open ResEus, Prelude in {

lin

    --PositAdvAdj : A -> Adv ;
    PositAdvAdj adj = { s = glue (adj.s ! Posit) "an" } ; --?????? no idea, got it from google translate :-D

--    ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
--    ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs

  -- : Prep -> NP -> Adv ;
  PrepNP post np = { s = glueIf (np.s ! post.complCase) (post.s ! np.nbr) } ;
 
-- Adverbs can be modified by 'adadjectives', just like adjectives.

    --AdAdv  : AdA -> Adv -> Adv ;             -- very quickly
  AdAdv ada adv = { s = ada.s ++ adv.s } ;
-- Like adverbs, adadjectives can be produced by adjectives.

    --PositAdAAdj : A -> AdA ;                 -- extremely

-- Subordinate clauses can function as adverbs.

    --: Subj -> S -> Adv ;              -- datorrenean ; ikasten baduzu 
  SubjS subj s = 
  	let auxFull : Str = if_then_Str subj.isPre 
  									(glue subj.s s.aux)
  		 						    (glue s.aux subj.s) ; -- ! s.ph later;
  		sent = s ** {aux = auxFull} ;
    in { s = wordOrder sent ! Stat } ;

-- Comparison adverbs also work as numeral adverbs.

    --AdnCAdv : CAdv -> AdN ;                  -- less (than five)
    --AdnCAdv cadv = {s = } ;
} ;

{-
gt PrepNP in_Prep (DetCN (DetQuant DefArt ?) (UseN ?) | l -bind
gt PrepNP from_Prep (DetCN (DetQuant DefArt ?) (UseN ?)) | l -bind
-}