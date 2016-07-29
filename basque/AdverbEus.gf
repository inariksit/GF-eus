concrete AdverbEus of Adverb = CatEus ** open ResEus, Prelude in {

lin

    --PositAdvAdj : A -> Adv ;
    PositAdvAdj adj = lin Adv { s = adj.s ! Posit ++ BIND ++ "an"} ; --?????? no idea, got it from google translate :-D

--    ComparAdvAdj  : CAdv -> A -> NP -> Adv ; -- more warmly than John
--    ComparAdvAdjS : CAdv -> A -> S  -> Adv ; -- more warmly than he runs

    --PrepNP      : Prep -> NP -> Adv ;
    PrepNP post np = 
    let bd : Str = if_then_Str post.attached  BIND  [] ;
    in lin Adv { s = np.s ! post.complCase ++ bd ++ post.s ! np.nbr } ;
 
-- Adverbs can be modified by 'adadjectives', just like adjectives.

    --AdAdv  : AdA -> Adv -> Adv ;             -- very quickly
    AdAdv ada adv = { s = ada.s ++ adv.s } ;
-- Like adverbs, adadjectives can be produced by adjectives.

    --PositAdAAdj : A -> AdA ;                 -- extremely

-- Subordinate clauses can function as adverbs.

    --SubjS  : Subj -> S -> Adv ;              -- datorrenean, egiten duenean
    --SubjS subj s = { s = } ;
-- Comparison adverbs also work as numeral adverbs.

    --AdnCAdv : CAdv -> AdN ;                  -- less (than five)
    --AdnCAdv cadv = {s = } ;
} ;

{-
gt PrepNP in_Prep (DetCN (DetQuant DefArt ?) (UseN ?) | l -bind
gt PrepNP from_Prep (DetCN (DetQuant DefArt ?) (UseN ?)) | l -bind
-}