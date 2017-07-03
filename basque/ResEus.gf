resource ResEus = ParamEus ** open TenseX, AditzTrinkoak, Prelude in {

flags optimize=all ;
coding=utf8 ;


--------------------------------------------------------------------
-- Articles 
oper

  artDef : Number => Case => Phono => Str =
    let artASg = table {Abs => finalR "a" ; --itsaso+a ; txakur+ra
                        Erg => finalR "ak" ;
                        Dat => finalR "ari" ;
                        Gen => finalR "aren"  ;
                        Soc => finalR "arekin" ;
                        Ins => finalR "az" ;

                        Par => table {FinalA    => BIND ++ "arik" ; --nesk+arik
                                      FinalCons => BIND ++ "ik" ;  --mutil+ik
                                      _         => BIND ++ "rik" } ; --txakur+rik, itsaso+rik

                        Ine => table {FinalCons => BIND ++ "ean" ; --mutil+ean
                                      FinalR    => BIND ++ "rean" ; --txakur+rean
                                      _         => BIND ++ "an" } ;--itsaso+an, nesk+an

                        LocStem => table {FinalCons => BIND ++ "e" ; --mutile+tik
                                          FinalR    => BIND ++ "re" ; --txakurre+tik
                                          FinalA    => BIND ++ "a" ; --neska+tik
                                          _         => [] } --itsaso+tik 
                       }; 
     in table {Sg => artASg ;
               Pl => table {Abs => finalR "ak" ;
                            Erg => finalR "ek" ;
                            Dat => finalR "ei" ;
                            Gen => finalR "en" ;
                            Soc => finalR "ekin" ;
                            Ins => finalR "ez" ;
                            Ine => finalR "etan" ;
                            LocStem => finalR "eta" ; --txakur+ret+atik
                            Par => artASg ! Par --invariant number in partitive
                       } 
          } ;

  artIndef : Case => Phono => Str = 
    \\cas,pho => case <cas,pho> of {
         <Abs,FinalA> => artDef ! Sg ! Abs ! FinalA ; --
         <Abs,_>      => [] ;
         <c,ph>       => artDef ! Pl ! c ! ph } ;


  finalR : Str -> (Phono => Str) = \ak ->
   let rak : Str = "r" + ak ;
   in  table {FinalR => BIND ++ rak ;
              _      => BIND ++ ak } ;



--------------------------------------------------------------------
-- Det, Quant

  Determiner : Type = { s     : Case => Phono => Str ;   -- hauek
                        pref  : Str ;                    -- nire
                        nbr   : Number ;
                        isDef : Bool } ;

  indefDet : Str -> Number -> Determiner = \zenbait,num -> 
    { s = artIndef ;
      nbr = num ;
      pref = zenbait ;
      isDef = False } ;


  Quant : Type = { s    : Number => Case => Phono => Str ;
                   pref : Str ;
                   isDef : Bool } ;

  quantHau : Number => Case => Phono => Str = 
   \\num,cas,ph => 
    let a = case ph of { FinalA => BIND ++ "a" ; _ => [] } ;
    in case <num,cas> of {
       <Sg,Abs> => a ++ "hau" ;
       <Sg,Erg> => a ++ "honek" ;
       <Sg,Dat> => a ++ "honi" ;
       <Sg,Gen> => a ++ "honen" ;
       <Sg,Soc> => a ++ "honekin" ;
       <Sg,Ins> => a ++ "honetaz" ;
       <Sg,Ine> => a ++ "honetan" ;
       <Sg,LocStem> => a ++ "honeta" ;
       <Pl,Abs> => a ++ "hauek" ;
       <Pl,Erg> => a ++ "hauek" ;
       <Pl,Dat> => a ++ "hauei" ;
       <Pl,Gen> => a ++ "hauen" ;
       <Pl,Soc> => a ++ "hauekin" ;
       <Pl,Ins> => a ++ "hauetaz" ;
       <Pl,Ine> => a ++ "hauetan" ;
       <Pl,LocStem> => a ++ "haueta" ;
       <_,Par>  => artIndef ! Par ! ph ++ "hau" --TODO: check how to handle partitive
    } ;

  quantHori : Number => Case => Phono => Str =
   \\num,cas,ph => 
    let a = case ph of { FinalA => BIND ++ "a" ; _ => [] } ;
    in case <num,cas> of {
       <Sg,Abs> => a ++ "hori" ;
       <Sg,Erg> => a ++ "horrek" ;
       <Sg,Dat> => a ++ "horri" ;
       <Sg,Gen> => a ++ "horren" ;
       <Sg,Soc> => a ++ "horrekin" ;
       <Sg,Ins> => a ++ "horretaz" ;
       <Sg,Ine> => a ++ "horretan" ;
       <Sg,LocStem> => a ++ "horreta" ;
       <Pl,Abs> => a ++ "horiek" ;
       <Pl,Erg> => a ++ "horiek" ;
       <Pl,Dat> => a ++ "horiei" ;
       <Pl,Gen> => a ++ "horien" ;
       <Pl,Soc> => a ++ "horiekin" ;
       <Pl,Ins> => a ++ "horietaz" ;
       <Pl,Ine> => a ++ "horietan" ;
       <Pl,LocStem> => a ++ "horieta" ;
       <_,Par>  => artIndef ! Par ! ph ++ "hori"  
    } ;

--------------------------------------------------------------------
-- Nouns and NPs

  Noun : Type = { s    : Str ; --for nouns ending in -a, we chop off the -a, and add it in the article + cases.
                  ph   : Phono ;
                  anim : Bizi } ;

  Noun2 : Type = Noun ** { compl1 : Postposizio } ; -- "mother of X": genitive?
  Noun3 : Type = Noun2 ** { compl2 : Postposizio } ; -- "mother of X": genitive?

  PNoun : Type = Noun ** { nbr : Number } ;

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

  mkNoun2 : Str -> Case -> Noun2 = \s,cas -> mkNoun s ** { compl1 = mkPost [] cas False } ;

  mkPNoun : Str -> PNoun = \s -> mkNoun s ** {nbr = Sg ; anim=Anim} ; 



  CNoun : Type = { s    : Agr => Str ; -- When we combine CN with RS, we introduce Agr distinction
                   ph   : Phono ; 
                   anim : Bizi ;
                   heavyMod : Agr => Str } ; -- Relative clause or adverbial
                                    -- If it's "heavy", numbers and possessives come after.
                                    -- "Light" modifiers attach directly to the s.

  useN : Noun -> CNoun = \n -> n ** { s = \\_ => n.s ;
                                      heavyMod = \\_ => [] } ;

  Complement : Type = { s : Agr => Str ; 
                        copula : SyntVerb1 } ;


  NounPhrase : Type = { s    : Case => Str ;
                        agr  : Agr ;
                        anim : Bizi ; 
                        isDef : Bool } ;

-- NounPhrase is a record
-- a record is a thing with fields
-- fields can be any type
-- exempelvis, NounPhrase is a record with two fields
-- the two fields are .s. and .agr.
-- the field .s. is a table from Case => Str ... e.g. it has two columns, first column is Case and second column is Str
-- last column is return type, all other columns are arguments
-- exempelvis: 
---      { Abs => "hargle"; Erg => "bargle" }
-- the field .agr. is of type Agr.   

  buru_NP : NounPhrase = { s = \\_ => "buru" ;
                           agr = Hau ; 
                           anim = Anim ; 
                           isDef = True } ;

--------------------------------------------------------------------
-- Postpositions

  Postposizio : Type = { s : Str ; 
                         complCase : Case ;  -- dirurik gabe : Par 
                                             -- hormaren kontra : Gen
                         affixed : Bool } ;

  mkPost : Str -> Case -> Bool -> Postposizio = \ko,loc,b ->
   { s = ko ; complCase = loc ; affixed = b } ;

  noPost : Postposizio = mkPost [] Abs False ;

  glueIf : Bool -> (_,_ : Str) -> Str = \affixed,a,b -> 
    if_then_Str affixed (glue a b) (a ++ b) ;

  applyPost : Postposizio -> NounPhrase -> Str = \post,np ->
    glueIf post.affixed (np.s ! post.complCase) post.s ;

--------------------------------------------------------------------
-- Pronoun

  Pronoun : Type = NounPhrase ;

  persPron : (x1,_,_,_,x5 : Str) -> Agr -> Pronoun = \nor,nori,nork,nore,zertaz,a->
    { s = table { Erg => nork ;
                  Abs => nor ;
                  Dat => nori ;
                  Par => nonExist ;
                  Gen => nore ;
                  Soc => nore + "kin" ;
                  Ins => zertaz ;
                  Ine => init zertaz + "n" ;
                  LocStem => init zertaz 
                 } ;
      agr  = a ;
      anim = Anim ;
      isDef = True } ;

  inanPron : (x1,_,_,_,x5 : Str) -> Agr -> Pronoun = \zer,zeri,zerk,zere,zertaz,a ->
    persPron zer zeri zerk zere zertaz a ** { anim = Inan } ;


--------------------------------------------------------------------
-- Adjective and AP

  Adjective : Type = {s : Degree => Str ; ph : Phono} ;

  AdjPhrase : Type = {s : Str ; ph : Phono ; typ : APType} ; 

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

--------------------------------------------------------------------
-- Verbs 


oper

  Verb : Type = { prc : Tense => Str ;
                  nstem : Str ; -- Nominal stem : ibiltze
                  val : AuxType  --TODO change name of the field
                } ;

  mkVerbDa : Str -> Verb = \s -> { val = Da Izan ;
                                   nstem = mkNStem s ;
                                   prc = mkPrc s } ;  

  mkVerbDaEgon : Str -> Verb = \s -> { val = Da Egon ;
                                       nstem = mkNStem s ;
                                       prc = mkPrc s } ; 

  mkVerbDu : Str -> Verb = \s -> { val = Du Ukan ; 
                                   nstem = mkNStem s ;
                                   prc = mkPrc s } ; 

  mkVerbDio : Str -> Verb = \s -> { val = Dio ; 
                                    nstem = mkNStem s ;
                                    prc = mkPrc s } ; 

  -- Synthetic verbs 
  syntVerbDa : Str -> SyntVerb1 -> Verb = \sEtorri,pEtorri ->
    mkVerbDa sEtorri ** { val = Da pEtorri } ;

  syntVerbDu : Str -> SyntVerb2 -> Verb = \sJakin,pJakin ->
    mkVerbDu sJakin ** { val = Du pJakin } ;

  mkNStem : Str -> Str = \ikusi ->
    let ikus : Str = case ikusi of {
                      _ + ("du"|"tu") => init (init ikusi) ; -- ager+tu
                      _ + ("p"|"t"|"k"
                          |"b"|"d"|"g")
                        + "i"         => ikusi ;             -- jaiki
                      _ + "ri"        => init (init ikusi) ; -- etor+ri
                      _ + "i"         => init ikusi ;        -- ibil+i
                      _ + "l"         => ikusi ;             -- hil
                      _ + "n"         => ikusi ; --init ikusi ;        -- jan
                      _               => init ikusi } ;
    in  case ikus of {  x + "n"        => x + "te" ;
                        x + "ts"       => x + "ste" ; 
                        _ + ("s"|"z")  => ikus + "te" ;
                        _              => ikus + "tze" } ;

  mkPrc : Str -> (ResEus.Tense => Str) = \ikusi ->
    let ikuste = mkNStem ikusi ;
        ikusiko : Str = case last ikusi of {
                         "n" => ikusi + "go" ;
                         _   => ikusi + "ko" } ;
    in table { Pres => ikuste + "n" ;
               Fut  => ikusiko ;
               _    => ikusi } ;


--------------------------------------------------------------------
-- VP and VPSlash 

  VerbPhrase : Type = 
    Verb ** { dobj : { a : Agr ; 
                       s : Polarity => Str ;
                       isDef : Bool } ; --Indefinite direct object turns into Partitive with negative polarity.
              iobj : { a : Agr ; 
                       s : Str } ; 
              comp : Agr => Str ; -- Comps depend on Agr; AuxType is always Nor.
              adv : Str } ;


  VPSlash : Type = 
    VerbPhrase ** { post : Postposizio ; --VPSlashPrep may specify a postposition to use (for adv slot)
                    missing : MissingArg } ;  
param 
  MissingArg = MissingAdv | MissingDObj | MissingIObj ;

oper
  --to be used in linref, PhraseEus ... anything where a VP is turned into string!
  linVP : VerbPhrase -> Str = linVPTense Pres Pres ;

  linVPTense : Tense -> Tense -> VerbPhrase -> Str = \tnsPrc,tnsAux,vp ->
    vp.adv 
    ++ vp.iobj.s ++ vp.dobj.s ! Pos ++ vp.comp ! Hau  --all the compls!
    ++ vp.prc ! tnsPrc 
    ++ (chooseAux vp ! tnsAux ! Hau).indep ;

  -- Used in ComplVV : does not include aux!
  linVPPrc : VerbPhrase -> Str = \vp ->
    vp.adv 
    ++ vp.iobj.s ++ vp.dobj.s ! Pos ++ vp.comp ! Hau  --all the compls!
    ++ vp.prc ! Past ; --If we choose Past, then it will work with Jakin ...
                       --TODO make it less of a hack.

  -----
  -- Create VP or VPSlash from various Verbs

  useV : Verb -> VerbPhrase = \v -> 
    v ** { dobj = { a = Hau ; -- This will be used for *all* V* becoming VP! 
                              -- e.g. VQ, VS, ... will use a Du copula, but 
                              -- the sentence complement will be stored in comp field.
                              -- This is because of V2Q, V2S versions you need both!
                              --
                              -- In the VQ, VS... version, dObj agreement is always Hau. (No exceptions?)
                              -- So this function, while looking dangerous, should do the Right Thing.
                    s = \\agr => [] ; 
                    isDef = True } ; --so that we don't choose singular agreement with negative polarity
           iobj = { a = Hau ;
                    s = [] } ;
           adv  = [] ;
           comp = \\agr => [] } ;

  slashV : MissingArg -> Verb -> VPSlash = \missingArg,vstar -> useV vstar ** 
    { post = noPost ;
      missing = missingArg } ;

  slashDObj : Verb -> VPSlash = slashV MissingDObj ; --works for V2, V2V, V2S, V2Q, V2A.

  slashIObj : Verb -> VPSlash = slashV MissingIObj ; --only Slash3V3

  -----
  -- Modify existing VPs

  insertAdv : SS -> VerbPhrase -> VerbPhrase = \a,vp ->
    vp ** { adv = vp.adv ++ a.s } ;


  insertComp = overload {

    insertComp : (Agr => Str) -> VerbPhrase -> VerbPhrase = \c,vp ->
      vp ** { comp = \\agr => vp.comp ! agr ++ c ! agr } ; 

    insertComp : Str -> VerbPhrase -> VerbPhrase = \cStr,vp ->
      vp ** { comp = \\agr => vp.comp ! agr ++ cStr } ;
  } ;

  -----
  -- Complete VPSlash into VP

  complSlash : VPSlash -> NounPhrase -> VerbPhrase = \vps,np ->
    case vps.missing of {
              MissingAdv  => vps ** { adv = applyPost vps.post np } ;
              MissingIObj => vps ** { iobj = { s = np.s ! Dat ;
                                               a = np.agr } } ;
              MissingDObj => vps ** { dobj = { s = table { Pos => np.s ! Abs ;
                                                           Neg => negDObj np } ;
                                               a = np.agr ;
                                               isDef = np.isDef } } 
          } ;

  negDObj : NounPhrase -> Str = \np ->
    case np.isDef of { True  => np.s ! Abs ;
                       False => np.s ! Par } ;

--------------------------------------------------------------------
-- Clause and sentence 

  Sentence : Type = { beforeAux : Str ;
                      aux : VForms ; -- Need to keep this open for SubjS
                      afterAux : Str } ;

  -- to be used for linref, PhraseEus, etc.
  linS : Sentence -> Str = \sent -> 
    sent.beforeAux ++ sent.aux.indep ++ sent.afterAux ;

  linSSub : Sentence -> Str -> Str = \sent,subj ->
    sent.beforeAux ++ glue sent.aux.stem subj ++ sent.afterAux ;

  Clause : Type = { s : Tense => Anteriority => Polarity => ClType => Sentence } ; 

  linCl : Clause -> Str = \clause ->
    linS (clause.s ! Pres ! Simul ! Pos ! Stat) ;

-- ez al duzu katu beltza ikusi? / ez al duzu katu beltzik ikusi? (MassNP)
-- ez dut katu beltza ikusi / ez dut katu beltzik ikusi (MassNP)
-- ibiltzen al zara ;  garagardoa edaten al duzu? ; nor dabil?
-- mutilari garagardoa ematen al diozu?
--  txakurrari abesten al diozu?

  mkClause = mkClauseIP False ;
  mkQClause = mkClauseIP True ;

  mkClauseIP : (isIP : Bool) -> NounPhrase -> VerbPhrase -> Clause = \isIP,subj,vp ->
    { s = \\t,a,pol =>
        let verb = case isSynthetic vp.val of {
                      True  => verbformSynthetic t a vp ;
                      False => verbformPeriphrastic t a vp 
            } ;
            sc : Case = subjCase vp.val ;
        in wordOrder isIP 
                     { pol = pol ;
                       adv = vp.adv ;
                       subj = subj.s ! sc ;
                       compl = vp.iobj.s             -- mutilari
                             ++ vp.dobj.s ! pol       -- garagardoa / garagardorik
                             ++ vp.comp ! subj.agr ;  -- etorriko dela / nor den / handi(ak) / ...
                       prc = verb.prc ;
                       aux = verb.aux ! subj.agr }
    } ;

  verbformPeriphrastic : Tense -> Anteriority -> VerbPhrase -> {aux : Agr => VForms ; prc : Str} = \t,a,vp ->
    let adl : IntransV = chooseAux vp ;
    in case <t,a> of {
      <Pres,Simul> => {aux = adl ! Pres ; prc = vp.prc ! Pres} ; --noa / lo egiten da
      <Pres,Anter> => {aux = adl ! Pres ; prc = vp.prc ! Past} ; --joan da / lo egin da
      <Past,Simul> => {aux = adl ! Past ; prc = vp.prc ! Pres} ; --nindoan / lo egiten zen
      <Past,Anter> => {aux = adl ! Past ; prc = vp.prc ! Past} ; --joan nintzen / ...
      <Fut,Simul>  => {aux = adl ! Pres ; prc = vp.prc ! Fut} ;  --joango da
      <Fut,Anter>  => {aux = adl ! Pres ; prc = vp.prc ! Fut} ; --joango nintzen
      <Cond,Simul> => {aux = adl ! Cond ; prc = vp.prc ! Fut} ;  --joango nintzateke
      <Cond,Anter> => {aux = adl ! Cond ; prc = vp.prc ! Past} } ;--joan nintzateke
  
  verbformSynthetic : Tense -> Anteriority -> VerbPhrase -> {aux : Agr => VForms ; prc : Str} = \t,a,vp ->
    let adt : IntransV = chooseAux vp ;
    in case <t,a> of {
      <Pres,Simul> => {aux = adt ! Pres ; prc = []} ;         --noa 
      <Past,Simul> => {aux = adt ! Past ; prc = []} ;         --nindoan
      _            => verbformPeriphrastic t a (vp ** {val = defaultAux vp.val}) } ;



  chooseAux : VerbPhrase -> IntransV = chooseAuxPol Pos ;

  --TODO: add other synthetic transitive verbs
  chooseAuxPol : Polarity -> VerbPhrase -> IntransV = \pol,vp -> 
    case vp.val of {
      Da x     => AditzTrinkoak.syntIntransVerb (Da x) ;

      Zaio   => AditzTrinkoak.ukanZaio ! vp.iobj.a ; --are there other Zaio (nor-nori) verbs?

      Du x =>
        let aux = AditzTrinkoak.syntTransVerb (Du x) 
        in case <pol,vp.dobj.isDef> of {
             <Neg,False> => aux ! sgAgr vp.dobj.a;
             _           => aux ! vp.dobj.a } ;

      Dio => 
        case <pol,vp.dobj.isDef> of {
          <Neg,False> => AditzTrinkoak.ukanDio ! vp.iobj.a ! sgAgr vp.dobj.a ;
          _           => AditzTrinkoak.ukanDio ! vp.iobj.a ! vp.dobj.a } 

} ;



  wordOrder : (isIP : Bool) -> SentenceLight -> (ClType => Sentence) = \isIP,s -> 
    \\ct => 
      let al = case ct of { Qst => if_then_Str isIP [] "al" ; 
                            _   => [] } ;
      in case s.pol of {
           Pos => { beforeAux = s.adv ++ s.subj ++ s.compl ++ s.prc ++ al ;
                    aux = s.aux ;
                    afterAux = [] } ;
           Neg => { beforeAux = s.adv ++ s.subj ++ "ez" ++ al ;
                    aux = s.aux ;
                    afterAux = s.compl ++ s.prc }
         } ;

  --just an internal type, to give as an argument to wordOrder
  SentenceLight : Type = { pol : Polarity ;
                           adv : Str ; --heavyAdv and lightAdv?
                           subj : Str ;
                           compl : Str ; 
                           prc : Str ;
                           aux : VForms } ;

--TODO: how do we stack adverbs?
--Lang> p "I think that she will come today"
--PhrUtt NoPConj (UttS (UseCl (TTAnt TPres ASimul) PPos (PredVP (UsePron i_Pron) (AdvVP (UseV think_V) (SubjS that_Subj (UseCl (TTAnt TFut ASimul) PPos (PredVP (UsePron she_Pron) (AdvVP (UseV come_V) today_Adv)))))))) NoVoc
--PhrUtt NoPConj (UttS (UseCl (TTAnt TPres ASimul) PPos (PredVP (UsePron i_Pron) (AdvVP (AdvVP (UseV think_V) (SubjS that_Subj (UseCl (TTAnt TFut ASimul) PPos (PredVP (UsePron she_Pron) (UseV come_V))))) today_Adv)))) NoVoc

------------------------------------------------
-- ClSlash: has verb and subject, missing object
  ClSlash : Type = VerbPhrase ** { subj : {s : Str ; a : Agr } } ;
 

  mkClSlash : NounPhrase -> VPSlash -> ClSlash = \np,vps ->
    let sc : Case = subjCase vps.val ;
    in vps ** { subj = { s = np.s ! sc ;
                         a = np.agr } };

------------------------------------------------
-- Relative clause
-- We need to keep agreement, because a RS may be attached to a CN or NP,
-- and we need to produce correct agreement:
-- `gorria den txakurra' vs. `gorriak diren txakurrak'


  RClause : Type = {s : Tense => Polarity => Agr => Str} ;

  mkRCl : Str -> VerbPhrase -> RClause = \en,vp ->
    { s = \\tns,pol,agr => 
        let ez = case pol of { Neg => "ez" ; _ => [] } ;
        in vp.adv 
           ++ vp.iobj.s
           ++ vp.dobj.s ! pol              -- John 
           ++ vp.prc ! tns                 -- maite 
           ++ ez                           -- (ez)
           ++ (chooseAux vp ! tns ! agr).stem   -- d(it)u
           ++ en                           -- en
    } ;

  mkRClSlash : Str -> ClSlash -> RClause = \en,cls ->
    { s = \\tns,pol,objAgr =>
        let ez = case pol of { Neg => "ez" ; _ => [] } ;
            clsWithObj = cls ** { dobj = cls.dobj ** { a = objAgr } };

        in  cls.adv 
            ++ cls.subj.s                               -- Johnek
            ++ cls.prc ! tns                            -- maite 
            ++ ez                                       -- (ez)
            ++ (chooseAux clsWithObj ! tns ! cls.subj.a).stem -- d(it)u
            ++ en                                       -- en
    } ;

  --TODO: some nice synergy between RCl(Slash) and ComplVQ? It's the same morphology.

}
