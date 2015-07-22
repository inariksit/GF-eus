concrete AdverbEus of Adverb = CatEus ** open ResEus, Prelude in {

lin
    PrepNP post np = {
      s = case post.attached of {
                   True => np.s ! Abs ++ BIND ++ post.s ;
                   False => np.s ! Abs ++ post.s 
                   } ;
    };

} ;
