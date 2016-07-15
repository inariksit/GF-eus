concrete CatEus of Cat = CommonX ** open ResEus, Prelude in {

  flags optimize=all_subs ;

  lincat

--2 Sentences and clauses
-- Constructed in SentenceEus, and also in IdiomEus

    S  = {s : Str} ;
    QS = {s : Str} ;
    RS = {s : Agr => Str} ; -- relative sentence. Tense and polarity fixed,
                            -- but agreement may depend on the CN/NP it modifies:
                            -- `gorriak diren txakurrak' vs. `gorria den txakurra'

    Cl = ResEus.Clause ;    -- declarative clause, with all tenses e.g. "she looks at this"
    ClSlash = {s : Str} ;   -- clause missing NP (S/NP in GPSG)    e.g. "she looks at"
    SSlash  = {s : Str} ;   -- sentence missing NP                 e.g. "she has looked at"
    Imp     = {s : Str} ;   -- imperative                          e.g. "look at this"

--2 Questions and interrogatives

-- Constructed in QuestionEus.

{-    QCl ;   -- question clause, with all tenses    e.g. "why does she walk"
    IP ;    -- interrogative pronoun               e.g. "who"
    IComp ; -- interrogative complement of copula  e.g. "where"
    IDet ;  -- interrogative determiner            e.g. "how many"
    IQuant; -- interrogative quantifier            e.g. "which"
-}



--2 Relative clauses and pronouns

-- Constructed in RelativeEus.

    RCl = ResEus.RClause ;
    RP = {s : ResEus.Phono => Str} ;



--2 Verb phrases

-- Constructed in VerbEus.

    VP = ResEus.VerbPhrase ; 
    VPSlash = ResEus.VPSlash ;
    Comp = ResEus.Complement ;



--2 Adjectival phrases

-- Constructed in AdjectiveEus.

    AP = {s : Str ; stem : Str ; ph : Phono ; typ : APType } ; 


--2 Nouns and noun phrases

-- Constructed in NounEus.
-- Many atomic noun phrases e.g. "everybody"
-- are constructed in StructuralEus.
-- The determiner structure is
-- ``` Predet (QuantSg | QuantPl Num) Ord
-- as defined in NounEus.

    CN = ResEus.CNoun ;
    NP = ResEus. NounPhrase ; --{s : Case => Str ; agr : Agr} 
    Pron = ResEus.Pronoun ; --Pronouns need enough info to turn it into NP or Quant.
    Det = { s     : Case => Phono => Str ;
            nbr   : Number ;
            isPre : Bool } ;
    Predet = {s : Str} ; -- predeterminer (prefixed Quant)      e.g. "all"
    Quant = { s : Number => Case => Phono => Str ;
              isPre : Bool } ;
    Num = {s : Str ; n : Number ; isNum : Bool} ;
    Card, Ord, DAP = {s : Str} ;


--2 Numerals

-- Constructed in NumeralEus.

    Numeral = {s : Str}; -- cardinal or ordinal in words       e.g. "five/fifth"
    Digits = {s : Str} ;  -- cardinal or ordinal in digits      e.g. "1,000/1,000th"



--2 Structural words

-- Constructed in StructuralEus.

    Conj = {s : Str} ;
    Subj = {s : Str} ;
    Prep = ResEus.Postposizio ;



--2 Words of open classes

-- These are constructed in LexiconEus and in 
-- additional lexicon modules.

    V  = ResEus.Verb1 ;
    V2 = ResEus.Verb2 ;
    V3 = ResEus.Verb3 ;

    --VV ;    -- verb-phrase-complement verb         e.g. "want"
    --VS ;    -- sentence-complement verb            e.g. "claim"
    VQ = ResEus.Verb1 ;
    VA = ResEus.Verb1 ;
    --V2V ;   -- verb with NP and V complement       e.g. "cause"
    --V2S ;   -- verb with NP and S complement       e.g. "tell"
    --V2Q ;   -- verb with NP and Q complement       e.g. "ask"
    --V2A ;   -- verb with NP and AP complement      e.g. "paint"

    A = ResEus.Adjective ;
    --A2 ;    -- two-place adjective                 e.g. "divisible"

    N = ResEus.Noun ;       --{s : Str ; ph = Phono} ;
    --N2 ;    -- relational noun                     e.g. "son"
    --N3 ;    -- three-place relational noun         e.g. "connection"
    PN = ResEus.Noun ** { nbr : Number } ; 
}
