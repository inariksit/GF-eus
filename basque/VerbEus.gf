concrete VerbEus of Verb = CatEus ** open ResEus, NounEus, AditzTrinkoak, Prelude in {


  lin
    UseV = predV ; -- {s = v.s ; sc = Abs ; prc = v.prc ; compl = []; adv = []} ; 

{-
    ComplVV  : VV  -> VP -> VP ;  -- want to run
    ComplVS  : VS  -> S  -> VP ;  -- say that she runs
    ComplVQ  : VQ  -> QS -> VP ;  -- wonder who runs
-}

    -- : VA -> AP -> VP ;  -- they become red
    ComplVA v ap = lin VP (insertComp (CompAP ap) (predV v)) ;


    -- : V2 -> VPSlash
    SlashV2a v2 = lin VPSlash (v2 ** {adv = []}) ;

    -- : V3 -> NP -> VPSlash ;  -- give it (to her)
    Slash2V3 v3 np = lin VPSlash { s   = AditzTrinkoak.copulaNoriNorNork ! np.agr ;
				                   prc = v3.prc ;
                                   sc = Erg ;
                                   adv = [] ;
                                   ph  = v3.ph 
                                 } ;

{-
    -- : V3  -> NP -> VPSlash ;  -- give (it) to her
    Slash3V3 v3 np = lin VPSlash {s = AditzTrinkoak.copulaNorNoriNork ! np.agr ;
    				  prc = v3.prc ;
    				  sc = Erg } ;

    SlashV2V : V2V -> VP -> VPSlash ;  -- beg (her) to go
    SlashV2S : V2S -> S  -> VPSlash ;  -- answer (to him) that it is good
    SlashV2Q : V2Q -> QS -> VPSlash ;  -- ask (him) who came
    SlashV2A : V2A -> AP -> VPSlash ;  -- paint (it) red
-}

    -- : VPSlash -> NP -> VP
    ComplSlash vps np = lin VP (complSlash vps np) ;
{-
    SlashVV    : VV  -> VPSlash -> VPSlash ;       -- want to buy
    SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash ; -- beg me to buy
-}

--2 Other ways of forming verb phrases

-- Verb phrases can also be constructed reflexively and from
-- copula-preceded complements.

    -- : VPSlash -> VP ;
    ReflVP vps = lin VP (complSlash vps buru_NP) ; ------ TODO

    --  : Comp -> VP ;

    UseComp comp = let copulaChoice = case comp.copula of { 
                      Izan => copulaVP ; 
                      Egon => copulaEgonVP  
                   } in 
                   lin VP (insertComp comp copulaChoice) ;

{-
    PassV2   : V2 -> VP ;               -- be loved

-}
    -- : VP -> Adv -> VP ;  -- sleep here
    AdvVP vp adv = lin VP (insertAdv adv vp) ;

    -- : VP -> Adv -> VP ;  -- sleep , even though ...
    ExtAdvVP vp adv = lin VP (insertAdv (postfixSS "," adv) vp) ;

    -- : AdV -> VP -> VP ;  -- always sleep
    AdVVP adv vp = lin VP (insertAdv adv vp) ;

    -- : VPSlash -> Adv -> VPSlash ;  -- use (it) here
    AdvVPSlash vps adv = lin VPSlash (vps ** { adv = adv.s }) ;

    -- : AdV -> VPSlash -> VPSlash ;  -- always use (it)
    AdVVPSlash adv vps = lin VPSlash (vps ** { adv = adv.s }) ;

    --- VPSlash assumes that complement is a core complement;
    --- TODO: generalise the type and allow adverbial complements to be inserted
    -- : VP -> Prep -> VPSlash ;  -- live in (it)
    VPSlashPrep vp prep = lin VPSlash 
      (vp ** { s     = copulaNorNork; 
               compl = \\agr => vp.compl ! agr ++ BIND ++ prep.s }) ;


--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

    -- the house is big   = etxea handia da
    -- the houses are big = etxeak handiak dira

    -- Complement : Type = {s : Agr => Str ; copula : CopulaType } ;

--  CompAP   : AP  -> Comp ;
    CompAP  ap  = lin Comp { s = table { agr => ap.stem ++ DefArt.s ! getNum agr ! Abs ! ap.ph } ;
                             copula = Izan };
--  CompNP   : NP  -> Comp ;
    CompNP  np  = lin Comp { s = table {_ => np.s ! Abs} ; 
                             copula = Izan } ; 
--  CompAdv  : Adv  -> Comp ;
    CompAdv adv = lin Comp { s = table {_ => adv.s} ; 
                             copula = Egon } ;

--  CompCN   : CN  -> Comp ;
    CompCN cn   = lin Comp { s = cn.s ;
                             copula = Izan } ; 

-- Copula alone


                            
-- choose copula based on transitivity(argstruct) of main verb.

    UseCopula = lin VP copulaVP ;


oper 
    copulaVP : VP = lin VP { s     = \\pol => AditzTrinkoak.copulaNor ; 
                             prc   = table {_ => []} ; 
		                     sc    = Abs ; 
                             compl = table {_ => table {_ => []}} ; 
                             adv   = [] ;
                             ph    = FinalA 
                            } ;

    copulaEgonVP : VP = lin VP { s     = \\pol => AditzTrinkoak.copulaEgonNor ; 
                                 prc   = table {_ => []} ; 
                                 sc    = Abs ; 
                                 compl = table {_ => table {_ => []}} ; 
                                 adv   = [] ;
                                 ph    = FinalCons 
                               } ;


}
