concrete QuestionEus of Question = CatEus ** open ResEus in {

-- A question can be formed from a clause ('yes-no question') or
-- with an interrogative.

  lin
    -- : Cl -> QCl ;
    QuestCl cl = cl ; --Cl and QCl are both ResEus.Clause :
                     -- { s : Tense => Anteriority => Polarity => Sentence } ; 

    -- : IP -> VP -> QCl ; 
    QuestVP ip vp = mkClause ip vp ; 
{-    
    QuestSlash  : IP -> ClSlash -> QCl ; -- whom does John love
    QuestIAdv   : IAdv -> Cl -> QCl ;    -- why does John walk
    QuestIComp  : IComp -> NP -> QCl ;   -- where is John

-- Interrogative pronouns can be formed with interrogative
-- determiners, with or without a noun.

    IdetCN    : IDet -> CN -> IP ;       -- which five songs
    IdetIP    : IDet       -> IP ;       -- which five

-- They can be modified with adverbs.

    AdvIP     : IP -> Adv -> IP ;        -- who in Paris

-- Interrogative quantifiers have number forms and can take number modifiers.

    IdetQuant : IQuant -> Num -> IDet ;  -- which (five)

-- Interrogative adverbs can be formed prepositionally.

    PrepIP    : Prep -> IP -> IAdv ;     -- with whom

-- They can be modified with other adverbs.

    AdvIAdv   : IAdv -> Adv -> IAdv ;    -- where in Paris

-- Interrogative complements to copulas can be both adverbs and
-- pronouns.

    CompIAdv  : IAdv -> IComp ;          -- where (is it)
    CompIP    : IP   -> IComp ;          -- who (is it)

-- More $IP$, $IDet$, and $IAdv$ are defined in $Structural$.

-- Wh questions with two or more question words require a new, special category.

  cat 
    QVP ;          -- buy what where
  fun
    ComplSlashIP  : VPSlash -> IP -> QVP ;   -- buys what 
    AdvQVP        : VP  ->   IAdv -> QVP ;   -- lives where 
    AddAdvQVP     : QVP ->   IAdv -> QVP ;   -- buys what where 

    QuestQVP      : IP -> QVP -> QCl ;       -- who buys what where
-}

}