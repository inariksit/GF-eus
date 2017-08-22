concrete SentenceEus of Sentence = CatEus ** open TenseX, ResEus, AditzTrinkoak, (AE=AdverbEus), Prelude in {

flags optimize=all_subs ;

lin   

--2 Clauses

  -- : NP -> VP -> Cl
  PredVP = mkClause ;

  -- : SC -> VP -> Cl ;         -- that she goes is good
  PredSCVP sc vp = 
    let subjSC : NounPhrase =
         { s = \\c => sc.s ;
           stem = sc.s ;
           agr = Hau ;
           anim = Inan ;
           isDef = True } ;
    in mkClause subjSC vp ;

--2 Clauses missing object noun phrases
  -- : NP -> VPSlash -> ClSlash ;
  SlashVP = mkClSlash ;

  -- : ClSlash -> Adv -> ClSlash ;     -- (whom) he sees today
  AdvSlash cls adv = cls ** insertAdv adv cls ; 

--    SlashPrep : Cl -> Prep -> ClSlash ;         -- (with whom) he walks 
--    SlashVS   : NP -> VS -> SSlash -> ClSlash ; -- (whom) she says that he loves
--    UseSlash : Temp -> Pol -> ClSlash -> SSlash ; -- (that) she had not seen


--2 Imperatives
  -- : VP -> Imp ; 
 ImpVP vp = { s = linVPPrc vp } ; --TODO: check negation

--2 Embedded sentences


  -- : S  -> SC ;
  EmbedS s = { s = linSSub s "la" } ; -- datorrela

  -- : QS -> SC ;
  EmbedQS qs = { s = linSSub (qs ! Indir) "la" } ; --???

  -- : VP -> SC ;                     -- ikusi
  EmbedVP vp = { s = linVPPrc vp } ;

--2 Sentences


  -- : Temp -> Pol -> Cl -> S ;
  UseCl temp pol cl = cl.s ! temp.t ! temp.a ! pol.p ! Stat ;

  -- : Temp -> Pol -> RCl -> RS ;
  UseRCl temp pol cl = { s = cl.s ! temp.t ! temp.a ! pol.p } ;

  -- : Temp -> Pol -> QCl -> QS ;
  UseQCl temp pol qcl = qcl.s ! temp.t ! temp.a ! pol.p ;

-- An adverb can be added to the beginning of a sentence, either with comma ("externally")
-- or without:

  -- : Adv -> S  -> S ;            -- then I will go home
  AdvS adv = insertBeforeAux adv.s ;

  -- : Adv -> S  -> S ;            -- next week, I will go home
  ExtAdvS adv = insertBeforeAux (adv.s ++ SOFT_BIND ++ ",") ;

-- There's an SubjS already in AdverbEus -- should this be deprecated?
  -- : S -> Subj -> S -> S ; 
  SSubjS s1 subj s2 = AdvS (AE.SubjS subj s2) s1 ; 


-- A sentence can be modified by a relative clause referring to its contents.

  --  : S -> RS -> S ;              -- she sleeps, which is good
  RelS sent rs = insertBeforeAux (rs.s ! Hau ++ SOFT_BIND ++ ",") sent ;

oper 
  insertBeforeAux : Str -> Sentence -> Sentence = \str,sent -> 
    sent ** { beforeAux = str ++ sent.beforeAux } ;


}