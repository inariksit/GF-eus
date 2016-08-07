concrete VerbEus of Verb = CatEus ** open ResEus, AditzTrinkoak, Prelude in {


lin
  UseV = predV ; -- {s = v.s ; sc = Abs ; prc = v.prc ; compl = []; adv = []} ; 

{-
    ComplVV  : VV  -> VP -> VP ;  -- want to run
-}

  -- : VS  -> S  -> VP ;  -- uste dut [neska etorriko dela]
  ComplVS vs s =
    let auxFull : Str = glue s.aux.stem "la" ; --de+la
        scomp : Complement = mkComp (s.beforeAux ++ auxFull ++ s.afterAux) ;
    in insertComp scomp (predV vs) ;

  -- : VQ -> QS -> VP ;   -- ez dakit [nor den]
  ComplVQ vq qs = 
    let qi : Sentence = qs ! Indir ; -- choose the version without al
        auxFull : Str = glue qi.aux.stem "n" ; --de+n
        qcomp : Complement = mkComp (qi.beforeAux ++ auxFull ++ qi.afterAux) ;
    in insertComp qcomp (predV vq) ;

  -- : VA -> AP -> VP ;  -- they become red
  ComplVA v ap = insertComp (CompAP ap) (predV v) ;


  -- : V2 -> VPSlash
  SlashV2a v2 = predV v2 ** 
    { post = noPost ;
     missing = MissingDObj } ;

  -- : V3 -> NP -> VPSlash ;  -- give it (to her)
  Slash2V3 v3 npNor = predV v3 **
    { dobj = { s = table { Pos => npNor.s ! Abs ; 
                           Neg => negDObj npNor } ;
               a = npNor.agr ;
               isDef = npNor.isDef } ;
      post = noPost ;
      missing = MissingIObj } ;


  -- : V3  -> NP -> VPSlash ;  -- give (it) to her
  Slash3V3 v3 npNori = predV v3 **
    { iobj = { s = npNori.s ! Dat ;
               a = npNori.agr } ;
      post = noPost ;
      missing = MissingDObj } ;
{-
    SlashV2V : V2V -> VP -> VPSlash ;  -- beg (her) to go
    SlashV2S : V2S -> S  -> VPSlash ;  -- answer (to him) that it is good
    SlashV2Q : V2Q -> QS -> VPSlash ;  -- ask (him) who came
    SlashV2A : V2A -> AP -> VPSlash ;  -- paint (it) red
-}

    -- : VPSlash -> NP -> VP
    ComplSlash vps np = ResEus.complSlash vps np ;
{-
    SlashVV    : VV  -> VPSlash -> VPSlash ;       -- want to buy
    SlashV2VNP : V2V -> NP -> VPSlash -> VPSlash ; -- beg me to buy
-}

--2 Other ways of forming verb phrases

-- Verb phrases can also be constructed reflexively and from
-- copula-preceded complements.

    -- : VPSlash -> VP ;
    ReflVP vps = ResEus.complSlash vps buru_NP ; ------ TODO

    --  : Comp -> VP ;
    UseComp comp = insertComp comp (copulaVP comp.copula) ;

{-
    PassV2   : V2 -> VP ;               -- be loved

-}
    -- : VP -> Adv -> VP ;  -- sleep here
    AdvVP vp adv = ResEus.insertAdv adv vp ;

    -- : VP -> Adv -> VP ;  -- sleep , even though ...
    ExtAdvVP vp adv = ResEus.insertAdv (postfixSS "," adv) vp ;

    -- : AdV -> VP -> VP ;  -- always sleep
    AdVVP adv vp = ResEus.insertAdv adv vp ;

    -- : VPSlash -> Adv -> VPSlash ;  -- use (it) here
    AdvVPSlash vps adv = vps ** { adv = vps.adv ++ adv.s } ;

    -- : AdV -> VPSlash -> VPSlash ;  -- always use (it)
    AdVVPSlash adv vps = vps ** { adv = adv.s ++ vps.adv } ;

    -- : VP -> Prep -> VPSlash ;  -- live in (it)
    VPSlashPrep vp prep = vp ** 
     { post = prep ; 
       missing = MissingAdv } ;


lin

--2 Complements to copula

-- Adjectival phrases, noun phrases, and adverbs can be used.

    -- the house is big   = etxea handia da
    -- the houses are big = etxeak handiak dira

    -- Complement : Type = {s : Agr => Str ; copula : SyntVerb } ;

  -- : AP  -> Comp ;
  CompAP ap = { s = \\agr => ap.s ++ artA ! getNum agr ! Abs ! ap.ph  ;
                copula = Izan };
  --  NP  -> Comp ;
  CompNP np = { s = \\agr => np.s ! Abs ; copula = Izan } ; 

  -- : Adv  -> Comp ;
  CompAdv adv = { s = \\agr => adv.s ; copula = Egon } ;

  --: CN  -> Comp ;
  CompCN cn = { s = \\agr => cn.s ! agr ++ artA ! getNum agr ! Abs ! cn.ph ;
                copula = Izan } ; 

-- Copula alone; intransitive and Izan by default
  UseCopula = copulaVP Izan ;


oper 

  copulaVP : SyntVerb1 -> VP = \izan ->
    lin VP (predV { prc = \\tns => [] ; 
                    val = Nor izan }) ;
} 



