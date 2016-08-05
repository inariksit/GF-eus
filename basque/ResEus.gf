resource ResEus = ParamEus ** open TenseX, AditzTrinkoak, Prelude in {

flags optimize=all ;
coding=utf8 ;


--------------------------------------------------------------------
-- Articles 
oper

  artA : Number => Case => Phono => Str =
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
         <Abs,FinalA> => artA ! Sg ! Abs ! FinalA ; --TODO: added this to fix MassNP; may break other things
         <Abs,_>      => [] ;
         <c,ph>       => artA ! Pl ! c ! ph } ;


  finalR : Str -> (Phono => Str) = \ak ->
   let rak : Str = "r" + ak ;
   in  table {FinalR => BIND ++ rak ;
              _      => BIND ++ ak } ;

--------------------------------------------------------------------
-- Nouns and NPs

  Noun : Type = { s    : Str ; --for nouns ending in -a, we chop off the -a, and add it in the article + cases.
                  ph   : Phono ;
                  anim : Bizi } ;

  CNoun : Type = { s    : Agr => Str ; -- When we combine CN with RS, we introduce Agr distinction
                   ph   : Phono ; 
                   anim : Bizi ;
                   heavyMod : Agr => Str } ; -- Relative clause or adverbial
                                    -- If it's "heavy", numbers and possessives come after.
                                    -- "Light" modifiers attach directly to the s.

  Complement : Type = { s : Agr => Str ; 
                        copula : CopulaType } ;

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
                         attached : Bool } ;

  mkPost : Str -> Case -> Bool -> Postposizio = \an,cas,b ->
   { s = an ; complCase = cas ; attached = b } ;

  noPost : Postposizio = mkPost [] Abs False ;

  glueIf : Bool -> (_,_ : Str) -> Str = \attached,a,b -> 
    if_then_Str attached (glue a b) (a ++ b) ;

  applyPost : Postposizio -> NounPhrase -> Str = \post,np ->
    glueIf post.attached (np.s ! post.complCase) post.s ;

--------------------------------------------------------------------
-- Pronoun stuffs

  Pronoun : Type = NounPhrase ;

  persPron : (x1,_,_,_,x5 : Str) -> Agr -> Pronoun = \nor,nori,nork,nore,zertaz,a->
    { s = table { Erg => nork ;
                  Abs => nor ;
                  Dat => nori ;
                  Par => [] ;
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
-- Adjective stuffs

  Adjective : Type = {s : Degree => Str ; ph : Phono} ;

  AdjPhrase : Type = {s : Str ; ph : Phono ; typ : APType} ; 


--------------------------------------------------------------------
-- Verbs and VPs


oper

  Verb : Type = { prc : Tense => Str ;
                  --ph  : Phono ; --for relative clause
                  val : Valency --TODO: synthetic verbs
                 } ;


  VerbPhrase : Type = 
    Verb ** { dobj : { a : Agr ; 
                       s : Polarity => Str ;
                       isDef : Bool } ; --Indefinite direct object turns into Partitive with negative polarity.
              iobj : { a : Agr ; 
                       s : Str } ; 
              comp : Agr => Str ; -- Comps depend on Agr; Valency is always Nor.
              adv : Str } ;


  VPSlash : Type = 
    VerbPhrase ** { post : Postposizio ; --VPSlashPrep may specify a postposition to use (for adv slot)
                    missing : MissingArg } ;  
param 
  MissingArg = MissingAdv | MissingDObj | MissingIObj ;

oper 
  predV : Verb -> VerbPhrase = \v -> 
    v ** { dobj = { a = Hau ;
                    s = \\agr => [] ; 
                    isDef = False } ;
           iobj = { a = Hau ;
                    s = [] } ;
           adv  = [] ;
           comp = \\agr => [] } ;

    {- Syntax note: 
          vp ** {adv = "hargle"} 
       means: take the original VP except for the field adv, which is replaced by "hargle"
       Same as \vp -> { s     = vp.s ; 
                        sc    = vp.sc ; 
                        prc   = vp.prc ; 
                        compl = vp.compl ;
                        adv   = "hargle" } ;
    -}
  insertAdv : Adv -> VerbPhrase -> VerbPhrase = \adv,vp ->
    vp ** { adv = vp.adv ++ adv.s } ;


  insertComp : Complement -> VerbPhrase -> VerbPhrase = \comp,vp ->
    vp ** { comp = \\agr => vp.comp ! agr ++ comp.s ! agr  } ; 
    --TODO: retain Izan vs. Egon difference.

  negAgr : NounPhrase -> TransV -> IntransV = \np,v ->
    case np.isDef of { True  => v ! np.agr ;
                       False => v ! sgAgr np.agr } ;

  negDObj : NounPhrase -> Str = \np ->
    case np.isDef of { True  => np.s ! Abs ;
                       False => np.s ! Par } ;


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


  




--------------------------------------------------------------------
-- Clause and sentence 

  Sentence : Type = { pol : Polarity ;
                      --ph : Phono ; --needed for Subj? 
                      adv : Str ; --heavyAdv and lightAdv?
                      subj : Str ;
                      compl : Str ; --DObj/Comp and IObj together: "mutilari garagardoa"
                      prc : Str ;
                      aux : Str } ;

  Clause : Type = { s : Tense => Anteriority => Polarity => Sentence } ; 

-- ez al duzu katu beltza ikusi? / ez al duzu katu beltzik ikusi? (MassNP)
-- ez dut katu beltza ikusi / ez dut katu beltzik ikusi (MassNP)
-- ibiltzen al zara ;  garagardoa edaten al duzu? 
-- mutilari garagardoa ematen al diozu?
--  txakurrari abesten al diozu?


    --QClause : Type = {s : Tense => Anteriority => Polarity => Str} ; 

  mkClause : NounPhrase -> VerbPhrase -> Clause = \subj,vp ->
    { s = \\t,a,pol =>
        let tns : {aux : Tense ; prc : Tense} = case <t,a> of {
              <Pres,Simul> => {aux=Pres ; prc=Pres} ; --lo egiten da
              <Pres,Anter> => {aux=Pres ; prc=Past} ; --lo egin da
              <Past,Simul> => {aux=Past ; prc=Pres} ; --lo egiten nintzen
              <Past,Anter> => {aux=Past ; prc=Past} ; --lo egin nintzen
              <Fut,Simul>  => {aux=Pres ; prc=Fut} ; --lo egingo da 
              <Fut,Anter>  => {aux=Past ; prc=Fut} ; --lo egingo nintzen
              <Cond,Simul> => {aux=Cond ; prc=Fut} ; --lo egiteko nintzateke
              <Cond,Anter> => {aux=Cond ; prc=Past}  } ;--lo egin nintzateke
            aux : Str = chooseAux vp ! t ! subj.agr ;
            sc : Case = subjCase vp.val ;
        in { pol = pol ;
             adv = vp.adv ;
             subj = subj.s ! sc ;
             compl = vp.iobj.s               -- mutilari
                    ++ vp.dobj.s ! pol        -- garagardoa / garagardorik
                    ++ vp.comp ! subj.agr ; 
             prc = vp.prc ! tns.prc ;
             aux = negAgr2 pol aux ; -- TODO: singular agreement for 
                                     -- negative clause with indef dObj
            }
    } ;

  chooseAux : VerbPhrase -> IntransV = \vp -> 
    case vp.val of {
      Nor         => AditzTrinkoak.copulaNor ;
      NorNork     => AditzTrinkoak.copulaNorNork ! vp.dobj.a ;
      NorNoriNork => AditzTrinkoak.copulaNoriNorNork ! vp.iobj.a ! vp.dobj.a ;
      _  => AditzTrinkoak.copulaNor } ; ----TODO NorNori

  negAgr2 : Polarity -> Str -> Str = \_,str -> str ; --TODO

  wordOrder : Sentence -> (ClType => Str) = \s -> 
    \\ct => 
      let al = case ct of { Qst => "al" ; _ => [] } ;
      in case s.pol of {
           Pos => s.adv ++ s.subj ++ s.compl ++ s.prc ++ al ++ s.aux ;
           Neg => s.adv ++ s.subj ++ "ez" ++ al ++ s.aux ++ s.compl ++ s.prc 
         } ;

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

  mkRCl : {s : Phono => Str} -> VerbPhrase -> RClause = \rp,vp ->
  let en = table { Past => [] ; --past tenses end in n; 0 relative morpheme.
                   _    => BIND ++ rp.s ! FinalVow } ; --- TODO: phono should differ between individual forms
      ez = table { Pos => "" ; Neg => "ez" } ;
  in { s = \\tns,pol,agr => vp.adv 
                          ++ vp.iobj.s
                          ++ vp.dobj.s ! pol              -- John 
                          ++ vp.prc ! tns                 -- maite 
                          ++ ez ! pol                     -- (ez)
                          ++ chooseAux vp ! tns ! agr     -- d(it)u
                          ++ en ! tns                     -- en
    } ;

  mkRClSlash : {s : Phono => Str} -> ClSlash -> RClause = \rp,cls ->
    { s = \\tns,pol,objAgr =>
        let en = case tns of { Past => [] ; --past tenses end in n; 0 relative morpheme.
                               _    => BIND ++ rp.s ! FinalCons } ; --- TODO
            ez = case pol of { Pos => [] ;
                               Neg => "ez" } ;
            --clsWithObj = cls ** { dobj = cls.dobj ** { a = objAgr } };

        in  cls.adv 
            ++ cls.subj.s                               -- Johnek
            ++ cls.prc ! tns                            -- maite 
            ++ ez                                       -- (ez)
            ++ chooseAux cls ! tns ! cls.subj.a  -- d(it)u
            ++ en                                       -- en
    } ;

}

-- Nik ikusi dut. past-pres
-- Nik ikusi nuen. past-past
