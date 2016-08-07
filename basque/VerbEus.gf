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
    let q : Sentence = qs ! Stat ; -- choose the version without al
        auxFull : Str = glue q.aux.stem "n" ; --de+n
        qcomp : Complement = mkComp (q.beforeAux ++ auxFull ++ q.afterAux) ;
    in insertComp qcomp (predV vq) ;

  -- : VA -> AP -> VP ;  -- they become red
  ComplVA v ap = insertComp (CompAP ap) (predV v) ;


  -- : V2 -> VPSlash
  SlashV2a v2 = v2 ** 
   { dobj = { s = \\pol => [] ;
              a = Hau ;
              isDef = False } ;
     iobj = { s = [] ;
              a = Hau } ;
     adv  = [] ;
     comp = \\_ => [] ;
     post = noPost ;
     missing = MissingDObj } ;

  -- : V3 -> NP -> VPSlash ;  -- give it (to her)
  Slash2V3 v3 npNor = v3 **
    { dobj = { s = table { Pos => npNor.s ! Abs ; 
                           Neg => negDObj npNor } ;
               a = npNor.agr ;
               isDef = npNor.isDef } ;
      iobj = { s = [] ;
               a = Hau } ;
      adv = [] ;
      comp = \\agr => [] ;
      post = noPost ;
      missing = MissingIObj } ;


  -- : V3  -> NP -> VPSlash ;  -- give (it) to her
  Slash3V3 v3 npNori = v3 **
    { dobj = { s = \\pol => [] ; 
               a = Hau ;
               isDef = False } ;
      iobj = { s = npNori.s ! Dat ;
               a = npNori.agr } ;
      comp = \\agr => [] ;
      adv = [] ;
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

    UseComp comp = let copulaChoice : VP = case comp.copula of { 
                      Izan => copulaVP ;
                      Egon => copulaVP } --Egon
                   in insertComp comp copulaChoice ;

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

    -- Complement : Type = {s : Agr => Str ; copula : CopulaType } ;

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

-- Copula alone


                            
-- choose copula based on transitivity(argstruct) of main verb.

    UseCopula = copulaVP ;


oper 

  copulaVP : VP = lin VP (predV { prc  = \\tns => [] ; 
                                  val  = Nor ;
                                  ph   = FinalCons }) ;
} 



