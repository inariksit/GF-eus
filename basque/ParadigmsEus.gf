resource ParadigmsEus = open Prelude, AditzTrinkoak, ResEus, CatEus in {

oper

--2 Parameters 
--
-- To abstract over number, valency and (some) case names, 
-- we define the following identifiers. The application programmer
-- should always use these constants instead of the constructors
-- defined in $ResEus$.
  Number : Type ;
  sg : Number ;
  pl : Number ;


  Valency : Type ; -- Only restricted to izan and ukan, no other synthetic verbs. If you need to add a new synthetic verb, look at AditzTrinkoak.
  nor : Valency ;
  norNork : Valency ;
  norNori : Valency ;
  norNoriNork : Valency ;

  Case : Type ;
  absolutive : Case ;
  ergative : Case ;
  dative : Case ;
  genitive : Case ;
  partitive : Case ;
  inessive : Case ;
  instrumental : Case ; -- Instrumental : 
  sociative : Case ; -- Sociative/comitative : txakurrarekin `with the dog'

  Animacy : Type ;
  animate : Animacy ;
  inanim : Animacy ;

--2 Nouns

  mkN = overload {
    mkN : Str -> N = \s -> lin N (mkNoun s) ;
    mkN : Str -> Bizi -> N = \s,bizi -> lin N (mkNoun s ** { anim = bizi }) ;
  } ;

  mkPN : Str -> PN = \s -> lin PN (mkPNoun s) ;
  
  mkN2 = overload {
    mkN2 : Str -> N2 = \s -> lin N2 (mkNoun2 s genitive) ; 
    mkN2 : Str -> Case -> N2 = \s,cas -> lin N2 (mkNoun2 s cas) ;
  } ;

--2 Adjectives

  mkA : Str -> A = \s -> lin A (mkAdj s) ;

--  mkA2 : Str -> A2 = \s -> lin A2 (mkAdj s) ;



--2 Verbs

  mkV = overload {

    mkV : Str -> V = \s -> lin V (mkVerbNor s) ;  -- 

    mkV : Str -> V -> V = \lo,egin -> 
      lin V (egin ** { prc = \\t => lo ++ egin.prc ! t }) ;

  } ;

  mkV2 = overload {
    mkV2 : Str -> V2 = \s -> lin V2 (mkVerbNorNork s) ;

    mkV2 : Str -> Valency -> V2 = \s,val -> lin V2 (mkVerbNor s ** { val = val }) ;

    mkV2 : Str -> V -> V2 = \lo,egin -> 
      lin V2 (egin ** { prc = \\t => lo ++ egin.prc ! t ;
                        val = norNork }) ;

  } ;


  --mkV* : Str -> (VT : Type) -> VT = \s,VT -> lin VT (mkVerbNorNork s) ;

  mkVA : Str -> VA = \s -> lin VA (mkVerbNor s) ; -- Nor

  mkV2A : Str -> V2A = \s -> lin V2A (mkVerbNorNork s) ;  -- Nor-nork   
  mkVQ : Str -> VQ = \s -> lin VQ (mkVerbNorNork s) ;  -- Nor-nork 
  mkVS : Str -> VS = \s -> lin VS (mkVerbNorNork s) ;  -- Nor-nork


  mkV2V : Str -> V2V = \s -> lin V2V (mkVerbNorNoriNork s) ; -- ??? TODO check valency
  mkV2S : Str -> V2S = \s -> lin V2S (mkVerbNorNoriNork s) ; -- Nor-nori-nork: (mutilari) (neska datorrela) erantzun diot
  mkV2Q : Str -> V2Q = \s -> lin V2Q (mkVerbNorNoriNork s) ; -- Nor-nori-nork: (mutilari) (neska datorren) galdetu diot
  mkV3 : Str -> V3 = \s -> lin V3 (mkVerbNorNoriNork s) ; -- Nor-nori-nork: (mutilari) (garagardoa) edan diot


  -----
  -- Verbs with non-inflecting participle
  -- These are just Verb, use izanV for Nor and ukanV for NorNork.

  izanV : Str -> Verb = \bizi -> 
    mkVerbNor bizi ** { prc = \\_ => bizi } ; -- Non-inflecting participle, valency is nor: e.g. "bizi naiz", "beldur naiz"

  egonV : Str -> Verb = \zain -> 
    mkVerbNorEgon zain ** { prc = \\_ => zain } ; -- Non-inflecting participle, valency is nor, but with egon: e.g. "zain nago"


  ukanV : Str -> Verb = \maite -> 
    mkVerbNorNork maite ** { prc = \\_ => maite } ; -- Non-inflecting participle, valency is nor-nork: e.g, "maite zaitut"


--2 Structural categories

  mkPrep = overload { 
    mkPrep : Str -> Prep = \s -> 
       lin Prep (mkPost s genitive False) ; -- Default postposition: complement case genitive, not affixed; e.g. "nire atzean"

    mkPrep : Str -> (complCase : Case) -> Prep = \s,compl -> 
       lin Prep (mkPost s compl False) ; -- Specify complement case; not affixed

    mkPrep : Str -> (complCase : Case) -> (affixed : Bool) -> Prep = \s,compl,konf -> 
       lin Prep (mkPost s compl konf) ; -- Specify complement case and whether it is affixed
  } ; 
 
  affixPrep : Str -> Case -> Prep = \str,cas ->
    mkPrep str cas True ; -- Specify case, affix postposition to chosen case; e.g. neskaren+tzat `for the girl'

  
  locPrep : Str -> Prep = \str ->
    affixPrep str ResEus.LocStem ; -- Locative postpositions/cases attach to the same stem: mutile+tik, mutile+ra. Inessive is split into its own case, because of its behaviour with nouns ending in A.
 

  mkConj : Str -> Number -> Conj = \s,num -> lin Conj { s = s ; nbr = num } ; 
  mkSubj : Str -> Bool -> Subj   = \s,b   -> lin Subj { s = s ; isPre = b } ;

  mkAdv : Str -> Adv = \s -> lin Adv {s = s} ;

  mkAdV : Str -> AdV = \s -> lin AdV {s = s} ;

  mkAdA : Str -> AdA = \s -> lin AdA {s = s} ;


--.
-------------------------------------------------------------------------------
-- The definitions should not bother the user of the API. So they are
-- hidden from the document.

  Number = ResEus.Number ;
  sg = Sg ;
  pl = Pl ;

  Valency = ResEus.Valency ;
  nor = Nor Izan ;
  norNork = NorNork Ukan ;
  norNori = NorNori ;
  norNoriNork = NorNoriNork ;

  Case = ResEus.Case ;
  absolutive = Abs ;
  ergative = Erg ;
  dative = Dat ;
  genitive = Gen ;
  partitive = Par ;
  inessive = Ine ;
  instrumental = Ins ;
  sociative = Soc ;

  Animacy = ResEus.Bizi ;
  animate = Anim ;
  inanim = Inan ;

--------------------------------------------------------------------------------

  mkVerbNor : Str -> Verb = \s -> { val = nor ;
                                    prc = mkPrc s } ;  

  mkVerbNorEgon : Str -> Verb = \s -> { val = ResEus.Nor ResEus.Egon ;
                                        prc = mkPrc s } ; 

  mkVerbNorNork : Str -> Verb = \s -> { val = norNork ; 
                                        prc = mkPrc s } ; 

  mkVerbNorNoriNork : Str -> Verb = \s -> { val = norNoriNork ; 
                                            prc = mkPrc s } ; 

  syntVerbNor : Str -> SyntVerb1 -> Verb = \sEtorri,pEtorri ->
    let etorri = mkVerbNor sEtorri ; 
     in etorri ** { prc = table { Pres => [] ; -- synthetic forms for present in AditzTrinkoak.jakin!
                                  tns  => etorri.prc ! tns } ;
                     val = Nor pEtorri } ;

  syntVerbNorNork : Str -> SyntVerb2 -> Verb = \sJakin,pJakin ->
    syntVerbNor sJakin Izan ** { val = NorNork pJakin } ;


  -- egin, egiten, egingo
  -- amildu, amiltzen, amilduko
  mkPrc : Str -> (ResEus.Tense => Str) = \ikusi ->
    let ikus : Str = case ikusi of {
                      _ + "du" => init (init ikusi) ; 
                      _        => init ikusi } ;
        ikusten : Str = case last ikus of {
                         "l" => ikus + "tzen" ; --amil+tzen, ibil+tzen
                         _   => ikus + "ten" } ;--ikus+ten, egi+ten
        ikusiko : Str = case last ikusi of {
                         "n" => ikusi + "go" ;
                         _   => ikusi + "ko" } ;
    in table { Pres => ikusten ;
               Fut  => ikusiko ;
               _    => ikusi } ;

  mkAdj : Str -> Adjective = \s -> 
    let stem : Str = case last s of {
               "a" => init s ; 
               _   => s                } ;
        phono : Phono = case last s of {
               "a"               => FinalA ;
               "r"               => FinalR ;
               ("e"|"i"|"o"|"u") => FinalVow ;
               _                 => FinalCons } 
    in { s = table { Posit  => stem ;
                     Compar => stem + "ago" ;
                     Superl => stem + "en" } ;
                  -- Excess => stem + "egi" } ;
         ph = phono } ; 

  mkNoun : Str -> Noun = \s ->
    let stem : Str = case last s of {
               "a" => init s ; 
               _   => s } ;
        phono : Phono = case last s of {
               "a"               => FinalA ;
               "r"               => FinalR ;
               ("e"|"i"|"o"|"u") => FinalVow ;
               _                 => FinalCons } 
    in { s = stem ; ph = phono ; anim=Inan } ; 

  mkNoun2 : Str -> Case -> Noun2 = \s,cas -> mkNoun s ** { compl1 = mkPrep [] cas } ;

  mkPNoun : Str -> PNoun = \s -> mkNoun s ** {nbr = Sg ; anim=Anim} ; 

}

