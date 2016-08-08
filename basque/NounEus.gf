concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

--2 Noun phrases

-- The three main types of noun phrases are
-- - common nouns with determiners
-- - proper names
-- - pronouns

  -- : Det -> CN -> NP
  DetCN det cn = 
    let ag = case det.nbr of {
                 Sg => Hau ;
                 Pl => Hauek 
               } ;
    in { s = \\c => cn.heavyMod ! ag
                     ++ det.pref 
                     ++ cn.s ! ag 
                     ++ det.s ! c ! cn.ph ;
          agr = ag ;
          anim = cn.anim ;
          isDef = det.isDef 
        } ;

  -- : PN -> NP ;
  UsePN pn = { s    = \\c => pn.s ++ artIndef ! c ! pn.ph;
               agr  = Hau ; 
               anim = pn.anim ; 
               isDef = True } ; --in Extra : add UsePNIndef to allow "hemen ez dago Olatzik"

  -- : Pron -> NP ; 
  UsePron pron = lin NP pron ;

-- A noun phrase can also be postmodified by the past participle of a
-- verb, by an adverb, or by a relative clause

{- TODO
    PPartNP : NP -> V2  -> NP ;    -- the man seen
    AdvNP   : NP -> Adv -> NP ;    -- Paris today
    ExtAdvNP: NP -> Adv -> NP ;    -- boys, such as ..
    RelNP   : NP -> RS  -> NP ;    -- Paris, which is here

-- Determiners can form noun phrases directly.

    DetNP   : Det -> NP ;  -- these five
-}


  -- MassNP : CN -> NP ; 
  MassNP cn =  { s = \\c => cn.heavyMod ! Hau 
                         ++ cn.s ! Hau 
                         ++ artIndef ! c ! cn.ph ;
                 agr   = Hau ;
                 anim  = Inan ;
                 isDef = False } ;


--2 Determiners

-- The determiner has a fine-grained structure, in which a 'nucleus'
-- quantifier and an optional numeral can be discerned.

    -- DetQuant : Quant -> Num -> Det ; 
  DetQuant quant num = lin Det
     { s     = \\c,ph => quant.s ! num.n ! c ! ph ;
       pref  = quant.pref ++ num.s ;
       nbr   = num.n ;
       isDef = orB quant.isDef num.isNum ;
     } ;

    -- DetQuantOrd : Quant -> Num -> Ord -> Det ;  -- these five best
--     DetQuantOrd quant num ord = lin Det {} ;

-- Whether the resulting determiner is singular or plural depends on the
-- cardinal.

-- All parts of the determiner can be empty, except $Quant$, which is
-- the "kernel" of a determiner. It is, however, the $Num$ that determines
-- the inherent number.

  NumSg = lin Num { s = [] ; n = Sg ; isNum = False } ; 
  NumPl = lin Num { s = [] ; n = Pl ; isNum = False } ; 

  -- NumCard : Card -> Num ;
  NumCard card = lin Num (card ** { isNum = True }) ;

  -- NumDigits  : Digits  -> Card ;
  NumDigits dig = lin Num (dig ** { isNum = True }) ;

  -- NumNumeral : Numeral -> Card ;
  NumNumeral num = lin Num (num ** { isNum = True }) ;
{-
    AdNum : AdN -> Card -> Card ;   -- almost 51

    OrdDigits  : Digits  -> Ord ;  -- 51st
    OrdNumeral : Numeral -> Ord ;  -- fifty-first
    OrdSuperl  : A       -> Ord ;  -- warmest

-- One can combine a numeral and a superlative.

    OrdNumeralSuperl : Numeral -> A -> Ord ; -- third largest
-}

    DefArt =
      lin Quant { s     = artA ;
                  pref  = [] ;
                  isDef = True } ; 
    IndefArt = 
      lin Quant { s     = artA ;
                  pref  = [] ;
                  isDef = False } ; --has suffix, but turns into partitive in negative!

    --PossPron : Pron -> Quant
    PossPron pron = 
      lin Quant { s    = artA ;
                  pref = pron.s ! Gen ;
                  isDef = True } ;

--2 Common nouns

    -- : N -> CN
    UseN n = n ** { s = \\_ => n.s ;
                    heavyMod = \\_ => [] } ;

{-
-- Relational nouns take one or two arguments.

    ComplN2 : N2 -> NP -> CN ;    -- mother of the king
    ComplN3 : N3 -> NP -> N2 ;    -- distance from this city (to Paris)

-- Relational nouns can also be used without their arguments.
-- The semantics is typically derivative of the relational meaning.

    UseN2   : N2 -> CN ;          -- mother
    Use2N3  : N3 -> N2 ;          -- distance (from this city)
    Use3N3  : N3 -> N2 ;          -- distance (to Paris)
-}

  -- : AP -> CN -> CN 
  AdjCN ap cn =
    let a : Str = artIndef ! Abs ! cn.ph ; --`a' for FinalA, [] for other
        result : {s : Agr => Str ; ph : Phono} =
          case ap.typ of {
                Ko => { s = \\agr => ap.s ++ cn.s ! agr ;
                        ph = cn.ph } ;
                Bare => { s = \\agr => cn.s ! agr ++ a ++ ap.s ;
                          ph = ap.ph }
             } ;
      in cn ** { s  = result.s ;
                 ph = result.ph } ; 

  -- : CN -> RS  -> CN ;
  RelCN cn rs = cn ** { heavyMod = \\agr => cn.heavyMod ! agr ++ rs.s ! agr } ;


  -- : CN -> Adv -> CN ;
  AdvCN cn adv = cn ** { heavyMod = \\agr => cn.heavyMod ! agr ++ adv.s } ;

{-
-- Nouns can also be modified by embedded sentences and questions.
-- For some nouns this makes little sense, but we leave this for applications
-- to decide. Sentential complements are defined in VerbEus.

    SentCN  : CN -> SC  -> CN ;   -- question where she sleeps

--2 Apposition

-- This is certainly overgenerating.

    ApposCN : CN -> NP -> CN ;    -- city Paris (, numbers x and y)

--2 Possessive and partitive constructs

    PossNP  : CN -> NP -> CN ;     -- house of Paris, house of mine
    PartNP  : CN -> NP -> CN ;     -- glass of wine

-- This is different from the partitive, as shown by many languages.

    CountNP : Det -> NP -> NP ;    -- three of them, some of the boys

--3 Conjoinable determiners and ones with adjectives

    AdjDAP : DAP -> AP -> DAP ;    -- the large (one)
    DetDAP : Det -> DAP ;          -- this (or that) 
-}

}