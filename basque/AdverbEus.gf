concrete AdverbEus of Adverb = CatEus ** open ResEus, Prelude in {

lin
    PrepNP post np = 
    let bd : Str = if_then_Str post.attached  BIND  [] ;
    in lin Adv { s = np.s ! post.complCase ++ bd ++ post.s ! np.nbr } ;
 
} ;

{-
gt PrepNP in_Prep (DetCN (DetQuant DefArt ?) (UseN ?) | l -bind
gt PrepNP from_Prep (DetCN (DetQuant DefArt ?) (UseN ?)) | l -bind
-}