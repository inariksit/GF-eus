concrete NounEus of Noun = CatEus ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lin

--2 Noun phrases

-- The three main types of noun phrases are
-- - common nouns with determiners
-- - proper names
-- - pronouns
--
--
      -- DetCN : Det -> CN -> NP
    DetCN det cn = 
      let ag = case det.nbr of {
                 Sg => Hau ;
                 Pl => Hauek 
               } ;

      in lin NP { s = \\cas => cn.stem ! ag ++ det.s ! cas ! cn.ph ;
                  agr = ag ;
                  anim = cn.anim ;
                  nbr = det.nbr
                } ;

    --UsePN   : PN -> NP ;
    UsePN pn = lin NP  { s = table { Erg => pn.s ++ BIND ++ "ek" ; 
                                     Dat => pn.s ++ BIND ++ "i" ;
                                     Par => pn.s ++ BIND ++ "ik" ;
                                     Abs => pn.s } ; 
                         agr = Hau ; 
                         anim = pn.anim ; nbr = Sg }  ;

    -- UsePron : Pron -> NP ; 
--    UsePron pron np = lin NP {} ;

-- A noun phrase can also be postmodified by the past participle of a
-- verb, by an adverb, or by a relative clause

{- TODO
    PPartNP : NP -> V2  -> NP ;    -- the man seen
    AdvNP   : NP -> Adv -> NP ;    -- Paris today
    ExtAdvNP: NP -> Adv -> NP ;    -- boys, such as ..
    RelNP   : NP -> RS  -> NP ;    -- Paris, which is here

-- Determiners can form noun phrases directly.

    DetNP   : Det -> NP ;  -- these five

-- Nouns can be used without an article as mass nouns. The resource does
-- not distinguish mass nouns from other common nouns, which can result
-- in semantically odd expressions.

    MassNP     : CN -> NP ; 
-}


--2 Determiners

-- The determiner has a fine-grained structure, in which a 'nucleus'
-- quantifier and an optional numeral can be discerned.

    -- DetQuant : Quant -> Num -> Det ; 
    DetQuant quant num = 
      lin Det { s     = \\cas,ph => quant.s ! num.n ! cas ! ph ;
                nbr   = num.n ;
                isPre = quant.isPre
              } ;

    -- DetQuantOrd : Quant -> Num -> Ord -> Det ;  -- these five best
--     DetQuantOrd quant num ord = lin Det {} ;

-- Whether the resulting determiner is singular or plural depends on the
-- cardinal.

-- All parts of the determiner can be empty, except $Quant$, which is
-- the "kernel" of a determiner. It is, however, the $Num$ that determines
-- the inherent number.

    NumSg        = { s = [] ; n = Sg ; isNum = False} ; 
    NumPl        = { s = [] ; n = Pl ; isNum = False} ; 

    --  NumCard : Card -> Num ;
{-    NumCard card = { s = card.s ; n = isNum = True } ;

    NumDigits  : Digits  -> Card ;  -- 51
    NumNumeral : Numeral -> Card ;  -- fifty-one
    AdNum : AdN -> Card -> Card ;   -- almost 51

    OrdDigits  : Digits  -> Ord ;  -- 51st
    OrdNumeral : Numeral -> Ord ;  -- fifty-first
    OrdSuperl  : A       -> Ord ;  -- warmest

-- One can combine a numeral and a superlative.

    OrdNumeralSuperl : Numeral -> A -> Ord ; -- third largest
-}


    --DefArt, IndefArt : Quant
    --Notation explanation: The string in s will start with BIND,
    --and a string from artA. The parameters n,c,p (number, case, phonology) 
    --will eventually come
    --from later functions, and they will be used to extract the wanted
    --string from artA.
    --This is equivalent to having written
    --  artA = table { Sg =>
    --                  table { Abs =>
    --                           table { FinalA = BIND ++ "a" ;
    --                                   FinalR = BIND ++ "ra" ; ...
    DefArt, IndefArt = 
      lin Quant { s     = \\n,c,p => BIND ++ artA ! n ! c ! p ;
                  isPre = False } ;


    --PossPron : Pron -> Quant
    PossPron pron = lin Quant { s     = \\n,c,p => pron.s ! c ; --TODO number?
                                isPre = True } ;

--2 Common nouns

-- Simple nouns can be used as nouns outright.

    --UseN : N -> CN
    UseN n = lin CN { s    = \\_ => n.s ;
                      stem = \\_ => n.stem ;
                      ph   = n.ph ;
                      anim = n.anim } ;

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

    -- AdjCN : AP -> CN  -> CN 
    AdjCN ap cn =
      let result : Agr => Str 
           = case ap.typ of {
                     Ko => \\agr => ap.stem ++ cn.s ! agr; 
                     Bare => \\agr => cn.s ! agr ++ ap.stem 
                   } ;
      in lin CN { s,stem = result ;
                  ph     = ap.ph ; --AP goes rightmost
                  anim   = cn.anim } ;

    -- RelCN : CN -> RS  -> CN ;
    RelCN cn rs = lin CN { s,stem = \\agr => rs.s ! agr ++ cn.s ! agr  ;
                           ph     = cn.ph ; --CN stays rightmost
                           anim   = cn.anim } ;


    -- AdvCN   : CN -> Adv -> CN ;
    AdvCN cn adv = lin CN { s,stem = \\agr => adv.s ++ cn.s ! agr ;
                            ph     = cn.ph ; --CN stays rightmost
                            anim   = cn.anim } ; 

{-
-- Nouns can also be modified by embedded sentences and questions.
-- For some nouns this makes little sense, but we leave this for applications
-- to decide. Sentential complements are defined in [Verb Verb.html].

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

oper
  artA : Number => Case => Phono => Str =
   table { Sg => table {Abs => table {FinalA   => "a"  ;
                                      FinalR   => "ra" ;
                                      _        => "a" } ;
                        Erg => table {FinalA   => "ak"  ;
                                      FinalR   => "rak" ;
                                      _        => "ak" } ;
                        Dat => table {FinalA   => "ri" ;
                                      FinalR   => "rari" ;
                                      _        => "ari" } ;
                        Par => table {FinalA   => "rik" ;
                                      FinalR   => "rarik" ;
                                      FinalVow => "rik" ;
                                      FinalCons => "ik" } 
                        }; 

           Pl => table {Abs => table {FinalA => "ak"  ;
                                      FinalR => "rak" ;
                                      _      => "ak" } ;
                        Erg => table {FinalA => "ek"  ;
                                      FinalR => "rek" ;
                                      _      => "ek" } ;
                        Dat => table {FinalR => "rei" ;
                                      _      => "ei" } ;
                        Par => table {FinalA   => "rik" ;
                                      FinalR   => "rarik" ;
                                      FinalVow => "rik" ;
                                      FinalCons => "ik" } 
                        }
          } ; 

{- We can also write the artA table shorter, like this:

     \\num,cas,pho => case <num,cas,pho> of {
        <Sg,Abs,FinalR> => "ra" ;
        <Sg,Abs,_>      => "a" ;
        <Sg,Erg,FinalR> => "rak" ;
        <Sg,Erg,_>      => "ak" ;
        <Sg,Dat,FinalA> => "ri" ;
        <Sg,Dat,FinalR> => "rari" ;
        <Sg,Dat,_>      => "ari" ;
        <Pl,Abs,FinalR> => "rak" ;
        <Pl,Abs,_>      => "ak" ;
        <Pl,Erg,FinalE> => "rek" ;
        <Pl,Erg,_>      => "ek" ;
        <Pl,Dat,FinalR> => "rei" ;
        <Pl,Det,_>      => "ei" ;
        <(Sg|Pl),Par,FinalR>    => "rarik" ;
        <(Sg|Pl),Par,FinalCons> => "ik" ;
        <(Sg|Pl),Par,_>         => "rik" ;
      } ; 
-}
}
