resource ParadigmsEus = GrammarEus [N,A,V] ** 
  open MorphoEus, GrammarEus, Prelude in {

oper
  mkN = overload {
    mkN : (dog : Str) -> N 
      = \n -> lin N (mkNoun n) ;
    } ;

  mkPN : (john : Str) -> PN
     = \s -> lin PN (ss s) ;  

  mkA = overload {
    mkA : (small : Str) -> A 
      = \a -> lin A (mkAdj a "") ;
    } ;

--  mkV = overload {
--    mkV : (walk : Str) -> V 
--      = \v -> lin V (regVerb v) ;
--    mkV : (go,goes,went,gone : Str) -> V 
--      = \p1,p2,p3,p4 -> lin V (mkVerb p1 p2 p3 p4) ;
--    } ;
--
--  mkV2 = overload {
--    mkV2 : Str -> V2
--      = \s -> lin V2 (regVerb s ** {c = []}) ;
--    } ;
--
}
