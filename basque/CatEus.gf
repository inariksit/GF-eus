concrete CatEus of Cat = CommonX ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lincat

--2 Sentences and clauses
-- Constructed in SentenceEus, and also in IdiomEus

    S  = ResEus.Sentence ; --must keep words separate, because we may add Subj particles for Adv
    QS = ClType => ResEus.Sentence ;
    RS = { s : Agr => Str } ; -- relative sentence. Tense and polarity fixed,
                              -- but agreement may depend on the CN/NP it modifies:
                              -- `gorriak diren txakurrak' vs. `gorria den txakurra'

    Cl = ResEus.Clause ; 
    ClSlash = ResEus.ClSlash ;
    SSlash  = { s : Str } ;   -- sentence missing NP           e.g. "she has looked at"
    Imp     = { s : Str } ;   -- imperative                    e.g. "look at this"

--2 Questions and interrogatives

-- Constructed in QuestionEus.

    QCl = ResEus.Clause ;
    IP = ResEus.NounPhrase ;
{-    IComp ; -- interrogative complement of copula  e.g. "where"
    IComp ; -- interrogative complement of copula  e.g. "where"
    IDet ;  -- interrogative determiner            e.g. "how many"
    IQuant; -- interrogative quantifier            e.g. "which"
-}



--2 Relative clauses and pronouns

-- Constructed in RelativeEus.

    RCl = ResEus.RClause ;
    RP = { s : Str } ;



--2 Verb phrases

-- Constructed in VerbEus.

    VP = ResEus.VerbPhrase ; 
    VPSlash = ResEus.VPSlash ;
    Comp = ResEus.Complement ;


--2 Adjectival phrases

-- Constructed in AdjectiveEus.

    AP = ResEus.AdjPhrase ; 


--2 Nouns and noun phrases

-- Constructed in NounEus.
-- Many atomic noun phrases e.g. "everybody"
-- are constructed in StructuralEus.
-- The determiner structure is
-- ``` Predet (QuantSg | QuantPl Num) Ord
-- as defined in NounEus.

    CN = ResEus.CNoun ;
    NP = ResEus.NounPhrase ; --{s : Case => Str ; agr : Agr} 
    Pron = ResEus.Pronoun ; --Pronouns need enough info to turn it into NP or Quant.
    Det = { s     : Case => Phono => Str ;   -- hauek
            pref  : Str ;                    -- nire
            nbr   : Number ;
            isDef : Bool } ;
    Predet = {s : Str} ; 
    Quant = { s    : Number => Case => Phono => Str ;
              pref : Str ;
              isDef : Bool } ;
    Num = { s : Str ; n : Number ; isNum : Bool } ;
    Card, Ord = { s : Str ; n : Number } ;
    DAP = {s : Str} ;


--2 Numerals

-- Constructed in NumeralEus.

    Numeral = { s : Str ; n : Number } ; 
    Digits  = { s : Str ; n : Number } ; 



--2 Structural words

-- Constructed in StructuralEus.

    Conj = { s : Str ; nbr : Number } ; --Ni eta Inari gara/*naiz ; Fran edo Mikel da/*dira
    Subj = { s : Str ; isPre : Bool } ; --ba+dut vs. dut+en
    Prep = ResEus.Postposizio ;



--2 Words of open classes

-- These are constructed in LexiconEus and in 
-- additional lexicon modules.

    V  = ResEus.Verb ;
    V2 = ResEus.Verb ;
    V3 = ResEus.Verb ;

    VV = ResEus.Verb ;    -- verb-phrase-complement verb         e.g. "want"
    VS = ResEus.Verb ;    -- sentence-complement verb            e.g. "claim"
    VQ = ResEus.Verb ;    -- question-complement verb            e.g. "wonder"  
    VA = ResEus.Verb ;    -- adjective-complement verb           e.g. "look"
    --V2V ;   -- verb with NP and V complement       e.g. "cause"
    --V2S ;   -- verb with NP and S complement       e.g. "tell"
    --V2Q ;   -- verb with NP and Q complement       e.g. "ask"
    --V2A ;   -- verb with NP and AP complement      e.g. "paint"

    A = ResEus.Adjective ;
    --A2 ;    -- two-place adjective                 e.g. "divisible"

    N = ResEus.Noun ;       --{s : Str ; ph = Phono} ;
    --N2 ;    -- relational noun                     e.g. "son"
    --N3 ;    -- three-place relational noun         e.g. "connection"
    PN = ResEus.PNoun ; 


linref

    S = linS ;
    Cl = linCl ;
    VP = linVP ;
}
