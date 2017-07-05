resource AditzTrinkoak = open Prelude, Predef, ParamEus in {

-- Synthetic verbs are in this module

-- I have not implemented allocutive forms. 
-- For that I'd have to keep track of up to S whether there is somewhere a familiar 2nd person
-- (e.g. "I am afraid of you/your mother"; "You(r mother) is nice", "I gave an apple to you(r mother)"), 
-- and that affects the verb form of a main clause, regardless who is subject/object there.

oper

    VForms : Type = { indep : Str ; stem : Str } ;

    noVForm : VForms = { indep = Prelude.nonExist ; stem = Prelude.nonExist } ;

    -- Obs. this is pretty rough heuristic, use 2-argument version for good results
    mkVForms = overload {
      mkVForms : Str -> VForms = \du ->
        let due : Str = case du of {
            _ + "en"          => init du ;        -- zen / zen
            x + "t"           => x + "da" ;       -- dut / duda+n
            _ + "r"           => du + "re" ;      -- dator / datorre+n
            _ + ("e"|"i"|"o"|"a") 
                              => du ;             -- dio / dio+n

            _                 => du + "e" }       -- du / due+n
        in { indep = du ; stem = due } ;

      mkVForms : (_,_ : Str) -> VForms = \dut,duda ->
        { indep = dut ; stem = duda } ;
    } ;

    IntransV : Type = Tense => Agr => VForms ;  -- Agr = nori or nork
    TransV   : Type = Agr => IntransV ;         -- Agr = nor 
    DitransV : Type = Agr => TransV ;           -- Agr = nori

------------------------------------------------------------------------------

  syntIntransVerb : AuxType -> IntransV = \val ->
    case val of {
      Da Izan  => izanDa ;
      Da Egon  => egonDa ;
      Da Joan  => joanDa ;
      Da Ibili => ibiliDa ;
      Da Etorri => etorriDa ;
      _         => Predef.error "Not an intransitive verb"
    } ;

  syntTransVerb : AuxType -> TransV = \val ->
    case val of {
      Du Ukan  => ukanDu ;
      Du Jakin => jakinDu ;
      Du Eduki => edukiDu ;
      Zaio     => ukanZaio ;
      _        => Predef.error "Not a transitive verb"
    } ;

------------------------------------------------------------------------------
-- General building blocks for the forms of ukan

  norkUkanFirst : Agr => Str = table { -- Past, pot, cond etc.
    Ni   => "n" ; Gu => "gen" ;
    Hi _ => "h" ; 
    Zu => "zen" ; Zuek => "zen" ;
    Hau  => "z" ; Hauek => "z" } ;

  norkUkanLast : Agr => Str = table {
    Ni      => "t" ;  Gu      => "gu" ;
    Hi Masc => "k" ;  Hi Fem  => "n" ;
    Zu      => "zu" ; Zuek    => "zue" ;
    Hau     => [] ;   Hauek   => "te" } ;

  norkUkanMid : Agr => Str = table {
    Hi Masc => "a" ;  Hi Fem  => "na" ;
    Ni => "da" ; x => norkUkanLast ! x } ;

  noriUkanLast : Agr => Str = table {
    Hau => "o" ; x => norkUkanLast ! x } ;

  noriUkanMid : Agr => Str = table {
    Hau => "o" ; x => norkUkanMid ! x } ;

  norUkanPres : Agr => Str = table {
    Ni   => "nau" ; Gu => "gaitu" ;
    Hi _ => "hau" ; 
    Zu => "zaitu" ; Zuek => "zaituzte" ;
    Hau  => "du"  ; Hauek => "ditu" } ;

  norUkanNonpres : Agr => Str = table {
    Ni => "nindu" ; Gu => "gintu" ;
    Hi _ => "hindu" ; 
    Zu => "zintu" ; Zuek => "zintuzte" ;
    Hau => nonExist ; Hauek => nonExist } ;
{-
  =============================================================================
  Izan [NOR]
  =============================================================================
-}

    -- common copula
    izanDa : IntransV =
      table {Past => table {Ni => mkVForms "nintzen" ; 
                            Hi _ => mkVForms "hintzen" ; 
                            Zu => mkVForms "zinen" ; 
                            Hau => mkVForms "zen" ; 
                            Gu => mkVForms "ginen" ; 
                            Zuek => mkVForms "zineten" ; 
                            Hauek => mkVForms "ziren" } ;

             Cond => table {Ni => mkVForms "nintzateke" ; 
                            Hi _ => mkVForms "hintzateke" ; 
                            Zu => mkVForms "zinateke" ; 
                            Hau => mkVForms "litzateke" ; 
                            Gu => mkVForms "ginateke" ; 
                            Zuek => mkVForms "zinatekete" ; 
                            Hauek => mkVForms "lirateke" } ;
             -- Present and future are identical
	           _     => table {Ni => mkVForms "naiz" ; 
                             Hi _ => mkVForms "haiz" ; 
                             Zu => mkVForms "zara" "zare" ; 
                             Hau => mkVForms "da" "de" ; 
                             Gu => mkVForms "gara" "gare" ; 
                             Zuek => mkVForms "zarete" ; 
                             Hauek => mkVForms "dira" "dire" }
       } ;

{-
  =============================================================================
  Ukan [NOR] [NORK]
  =============================================================================
-}
{-
  ukanDu : TransV = \\nor,tns,nork => mkVForms (
    case tns of {

      Pres => let gaitu : Str = norPres ! nor ;
                  zte   : Str = norkPres ! nork ;
               in gaitu + zte ; 

      --TODO rest of the forms
      past => 
        case <nor,nork> of {
          <Hau,x>   => table { Ni => mkVForms "nuen" ; Gu => mkVForms "genuen" ;
                               Hi _ => mkVForms "huen" ;        
                               Zu => mkVForms "zenuen" ; Zuek => mkVForms "zenuten" ;
                               Hau => mkVForms "zuen" ; Hauek => mkVForms "zuten" } 
                       ! x ;
          <Hauek,x> => table { Ni => mkVForms "nituen" ; Gu => mkVForms "genituen" ;
                               Hi _ => mkVForms "hituen" ;
                               Zu => mkVForms "zenituen" ; Zuek => mkVForms "zenituzten" ;
                               Hau => mkVForms "zituen" ; Hauek => mkVForms "zituzten" } 
                        ! x ;
          <_,_>     => let nindu : Str = norPast ! nor ;
                           te    : Str = norkPast ! nork ;
                        in nindu + te + "n" }}) 
     where {

      norkPres : Agr => Str = \\nork => case <nor,nork> of {
       <Gu,Hauek>    => "zte" ; -- If Nork is Hauek and Nor is plural,
       <Zu,Hauek>    => "zte" ; -- the morpheme "te" changes into "zte"
       <Hauek,Hauek> => "zte" ;
       <_,x>         => norkUkanLast ! x } ; 

      norkPast : Agr => Str = norkUkanMid ;

      norPres : Agr => Str = norUkanPres ;    
      
      norPast : Agr => Str = norUkanNonpres ;
        
  } ;

-}

    ukanDu : TransV = table {
       -- Nor,Nork
              Ni => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => mkVForms "ninduten" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "ninduzuen" ;
                              Hau => mkVForms "ninduen" ;
                              Hi Masc  => mkVForms "ninduan" ; 
                              Hi Fem => mkVForms "nindunan" ;
                              Zu => mkVForms "ninduzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "naute" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "nauzue" ;
                              Hau => mkVForms "nau" ;
                              Hi Masc  => mkVForms "nauk" ; 
                              Hi Fem => mkVForms "naun" ;
                              Zu => mkVForms "nauzu" 
                     }
              } ;
              Gu => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => mkVForms "gintuzten" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gintuzuen" ;
                              Hau => mkVForms "gintuen" ;
                              Hi Masc => mkVForms "gintuan" ; 
                              Hi Fem => mkVForms "gintunan" ;
                              Zu => mkVForms "gintuzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gaituzte" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gaituzue" ;
                              Hau => mkVForms "gaitu" ;
                              Hi Masc => mkVForms "gaituk" ; 
                              Hi Fem => mkVForms "gaitun" ;
                              Zu => mkVForms "gaituzu" 
                     }
              } ;
              Hauek => table {
                     Past => table {
                              Gu => mkVForms "genituen" ;
                              Hauek => mkVForms "zituzten" ;
                              Ni => mkVForms "nituen" ;
                              Zuek => mkVForms "zenituzten" ;
                              Hau => mkVForms "zituen" ;
                              Hi _ => mkVForms "hituen" ;
                              Zu => mkVForms "zenituen" 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "ditugu" ;
                              Hauek => mkVForms "dituzte" ;
                              Ni => mkVForms "ditut" ;
                              Zuek => mkVForms "dituzue" ;
                              Hau => mkVForms "ditu" ;
                              Hi Masc => mkVForms "dituk" ;
                              Hi Fem => mkVForms "ditun" ;
                              Zu => mkVForms "dituzu" 
                     }
              } ;
              Zuek => table {
                     Past => table {
                              Gu => mkVForms "zintuztegun" ;
                              Hauek => mkVForms "zintuzteten" ;
                              Ni => mkVForms "zintuztedan" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zintuzten" ;
                              Hi _ => noVForm ;
                              Zu => noVForm
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zaituztegu" ;
                              Hauek => mkVForms "zaituztete" ;
                              Ni => mkVForms "zaituztet" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zaituzte" ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     }
              } ;
              Hau => table {
                     Past => table {
                              Gu => mkVForms "genuen" ;
                              Hauek => mkVForms "zuten" ;
                              Ni => mkVForms "nuen" ;
                              Zuek => mkVForms "zenuten" ;
                              Hau => mkVForms "zuen" ;
                              Hi _ => mkVForms "huen" ;
                              Zu => mkVForms "zenuen" 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "dugu" ;
                              Hauek => mkVForms "dute" ;
                              Ni => mkVForms "dut" ;
                              Zuek => mkVForms "duzue" ;
                              Hau => mkVForms "du" ;
                              Hi Masc => mkVForms "duk" "dua" ; 
                              Hi Fem => mkVForms "dun" "duna" ;
                              Zu => mkVForms "duzu" 
                     }
              } ;
              Hi _ => table {
                     Past => table {
                              Gu => mkVForms "hindugun" ;
                              Hauek => mkVForms "hinduten" ;
                              Ni => mkVForms "hindudan" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hinduen" ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "haugu" ;
                              Hauek => mkVForms "haute" ;
                              Ni => mkVForms "haut" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hau" ;
                              Hi _ => noVForm ;
                              Zu => noVForm
                     }
              } ;
              Zu => table {
                     Past => table {
                              Gu => mkVForms "zintugun" ;
                              Hauek => mkVForms "zintuzten" ;
                              Ni => mkVForms "zintudan" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zintuen" ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zaitugu" ;
                              Hauek => mkVForms "zaituzte" ;
                              Ni => mkVForms "zaitut" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zaitu" ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     }
              }
   } ;

{-
  =============================================================================
  Ukan [NOR] [NORI]
  =============================================================================
-}

  ukanZaio : TransV = table {
     -- Nori,Nor
      Hau   => table { 
                 Pres => table {
                          Ni => mkVForms "zait" ;
                          Hi Fem => mkVForms "zain" ; 
                          Hi Masc => mkVForms "zaik" ; 
                          Zu => mkVForms "zaizu" ;
                          Hau => mkVForms "zaio" ;
                          Gu => mkVForms "zaigu" ;
                          Zuek => mkVForms "zaizue" ;
                          Hauek => mkVForms "zaie" 
                        } ;
                 _    => \\agr => mkVForms "ukanNoriNor: TODO"
               } ;
      Hauek => table {
                 Pres => table {
                           Ni => mkVForms "zaizkit" ;
                           Hi Fem => mkVForms "zaizkin" ;
                           Hi Masc => mkVForms "zaizkik" ;
                           Zu => mkVForms "zaizkizu" ;
                           Hau => mkVForms "zaizkio" ;
                           Gu => mkVForms "zaizkigu" ;
                           Zuek => mkVForms "zaizkizue" ;
                           Hauek => mkVForms "zaizkie" 
                        } ;
                 _    => \\agr => mkVForms "ukanNoriNor: TODO"
               } ;
      _     => table { 
                 tns => table {
                           agr => mkVForms "ukanNoriNor: TODO"
                        }
               }
  } where {
    -- TODO: maybe use this? 
    -- For Nor-Nori inflection, map from Agr to prefix morpheme in Nor position
    norTableZaio : Agr => Str =
      table { Ni    => "na" ;
              Hi _  => "ha" ;
              Gu    => "ga" ;
              Zu    => "za" ;
              Zuek  => "za" ;
              _     => []  --Hau and Hauek
            } 
  } ;


{-
  =============================================================================
  Ukan [NOR] [NORI] [NORK]
  =============================================================================
-}
  -- OBS. Overgenerating and probably wrong in some places, TODO test properly /IL 2017-07
  ukanDio : DitransV = \\nori,nor,tns,nork => mkVForms (
    case tns of {
      Cond => "TODO:conditional" ;
      Past => let zen = norkPast ! nork ;
                  izki = norPast ! getNum nor ;
                  da = noriPast ! nori ;
                  te = norkPastTe ! nork ;
               in zen + izki + da + te + "n" ;

      _    => let dizki = norPres ! getNum nor ;
                  da    = noriPres ! nori ; --form of nori depends on nork
                  zue   = norkPres ! nork 
               in dizki + da + zue })

   where { 
    -- Map from Number to prefix morpheme in Nor position.
    -- Specific to Nor-Nori-Nork, different forms in other auxiliaries.
    norPres : Number => Str = table { Sg => "di" ;
                                      Pl => "dizki" } ;
    norPast : Number => Str = \\tns => drop 1 (norPres ! tns) ;

    ------
    -- Map from Agr to morpheme in Nori position.

    noriPres : Agr => Str = \\nori => case <nork,nori> of {
      <Hau,Ni> => "t" ; -- If nork is Hau, then the form ends in "t"
      <_,x>    => noriUkanMid ! x } ;

    noriPast : Agr => Str = noriUkanMid ;

    ------
    -- Map from Agr to morpheme in Nork position            
    norkPres : Agr => Str = norkUkanLast ;

    norkPast : Agr => Str = norkUkanFirst ;

    norkPastTe : Agr => Str = table { 
      (Zuek|Hauek) => "te" ; _ => [] } 

  } ;

{-
  =============================================================================
  Egon
  =============================================================================
-}
    -- stative copula, like Spanish estar
  egonDa : IntransV =
    table { Past => table {
                     Ni => mkVForms "nengoen" ; 
                     Hi _ => mkVForms "hengoen" ; 
                     Zu => mkVForms "zeunden" ; 
                     Hau => mkVForms "zegoen" ; 
                     Gu => mkVForms "geunden" ; 
                     Zuek => mkVForms "zeundeten" ; 
                     Hauek => mkVForms "zeuden" } ;
             -- TODO: Cond
	           _ =>  table {
                     Ni => mkVForms "nago" ; 
                     Hi _ => mkVForms "hago" ; 
                     Zu => mkVForms "zaude" ; 
                     Hau => mkVForms "dago" ; 
                     Gu => mkVForms "gaude" ; 
                     Zuek => mkVForms "zaudete" ; 
                     Hauek => mkVForms "daude" }
          } ;


{-
  =============================================================================
  Eduki
  =============================================================================
-}

   edukiDu : TransV = table {
       -- Nor,Nork
              Ni => table {
                    Pres => table {
                              Gu => noVForm ;
                              Hauek => mkVForms "naukate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "naukazue" ;
                              Hau => mkVForms "nauka" ;
                              Hi Masc => mkVForms "naukak" ;
                              Hi Fem  => mkVForms "naukan" ;
                              Zu => mkVForms "naukazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 

              } ;
              Gu => table {
                    Pres => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gauzkate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gauzkazue" ;
                              Hau => mkVForms "gauzka" ;
                              Hi _ => noVForm ;
                              Zu => mkVForms "gauzkazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Hauek => table {
                    Pres => table { -- Pres
                              Gu => mkVForms "dauzkagu" ;
                              Hauek => mkVForms "dauzkate" ;
                              Ni => mkVForms "dauzkat" ;
                              Zuek => mkVForms "dauzkazue" ;
                              Hau => mkVForms "dauzka" ;
                              Hi Masc => mkVForms "dauzkak" ; 
                              Hi Fem => mkVForms "dauzkan" ;
                              Zu => mkVForms "dauzkazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Zuek => table {
                    Pres => table { 
                              Gu => mkVForms "zauzkategu" ;
                              Hauek => mkVForms "zauzkatete" ;
                              Ni => mkVForms "zauzkatet" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzkate" ;
                              Hi _ => noVForm ;
                              Zu => noVForm } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr
              } ;
              Hau => table {
                    Pres => table { 
                              Gu => mkVForms "daukagu" ;
                              Hauek => mkVForms "daukate" ;
                              Ni => mkVForms "daukat" ;
                              Zuek => mkVForms "daukazue" ;
                              Hau => mkVForms "dauka" ;
                              Hi Masc => mkVForms "daukak" ; 
                              Hi Fem => mkVForms "daukan" ;
                              Zu => mkVForms "daukazu" } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Hi _ => table {
                    Pres => table { 
                              Gu => mkVForms "haukagu" ;
                              Hauek => mkVForms "haukate" ;
                              Ni => mkVForms "haukat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hauka" ;
                              Hi _ => noVForm ;
                              Zu => noVForm } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              } ;
              Zu => table {
                    Pres => table { 
                              Gu => mkVForms "zauzkagu" ;
                              Hauek => noVForm ;
                              Ni => mkVForms "zauzkat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzka" ;
                              Hi _ => noVForm ;
                              Zu => noVForm } ;
                    tns => \\agr => ukanDu ! Ni ! tns ! agr 
              }
   } ;

{-
  =============================================================================
  Etorri 
  =============================================================================
-}

  etorriDa : IntransV = 
    \\tns,subjAgr => 
      case <tns,subjAgr> of {
        <Pres,Ni>    => mkVForms "nator" ;
        <Pres,Hi _>  => mkVForms "hator" ;
        <Pres,Zu>    => mkVForms "zatoz" ;
        <Pres,Hau>   => mkVForms "dator" ;
        <Pres,Gu>    => mkVForms "gatoz" ;
        <Pres,Zuek>  => mkVForms "zatozte" ;
        <Pres,Hauek> => mkVForms "datoz" ;
        _            => izanDa ! tns ! subjAgr 
      } ;

{-
  =============================================================================
  Joan
  =============================================================================
-}
  joanDa : IntransV = 
    \\tns,subjAgr => 
      case <tns,subjAgr> of {
        <Pres,Ni>    => mkVForms "noa" ;
        <Pres,Hi _>  => mkVForms "hoa" ;
        <Pres,Zu>    => mkVForms "zoaz" ;
        <Pres,Hau>   => mkVForms "doa" ;
        <Pres,Gu>    => mkVForms "goaz" ;
        <Pres,Zuek>  => mkVForms "zoazte" ;
        <Pres,Hauek> => mkVForms "doaz" ;
        <Past,Ni>    => mkVForms "nindoan" ;
        <Past,Hi _>  => mkVForms "hindoan" ;
        <Past,Zu>    => mkVForms "zindoazen" ;
        <Past,Hau>   => mkVForms "zihoan" ;
        <Past,Gu>    => mkVForms "gindoazen" ;
        <Past,Zuek>  => mkVForms "zindoazten" ;
        <Past,Hauek> => mkVForms "zihoazen" ;

        _            => izanDa ! tns ! subjAgr 
      } ;



{-
  =============================================================================
  Ekarri 
  =============================================================================
-}

{-
  =============================================================================
  Ibili
  =============================================================================
-}
  --TODO: check forms

  ibiliDa : IntransV =
    table {
        Past => table {
                    Ni => mkVForms "nenbilen" ; 
                    Hi _ => mkVForms "henbilen" ; 
                    Zu => mkVForms "zenbiltzan" ; 
                    Hau => mkVForms "zebilen" ; 
                    Gu => mkVForms "genbiltzan" ; 
                    Zuek => mkVForms "zenbiltzaten" ; 
                    Hauek => mkVForms "zebiltzan" } ;

             -- Present and future are identical
        Cond => table {
                    Ni => mkVForms "nenbilke" ; 
                    Hi _ => mkVForms "henbilke" ; 
                    Zu => mkVForms "zenbilzke" ; 
                    Hau => mkVForms "lebilke" ; 
                    Gu => mkVForms "genbiltzke" ; 
                    Zuek => mkVForms "zenbiltzketen" ; 
                    Hauek => mkVForms "lebilzke" } ;

        Pres => table {
                    Ni => mkVForms "nabil" ; 
                    Hi _ => mkVForms "habil" ; 
                    Zu => mkVForms "zabiltza" ; 
                    Hau => mkVForms "dabil" ; 
                    Gu => mkVForms "gabiltza" ; 
                    Zuek => mkVForms "zabiltzate" ; 
                    Hauek => mkVForms "dabiltza" } ;
        Fut => izanDa ! Fut 
       } ;


{-
  =============================================================================
  Jakin
  =============================================================================
-}
  jakinDu : TransV = 
    \\dobjAgr,tns,subjAgr => 
      case <dobjAgr,tns,subjAgr> of {
        <Hau,Pres,Ni>    => mkVForms "dakit" ;
        <Hau,Pres,Zu>    => mkVForms "dakizu" ;
        <Hau,Pres,Hau>   => mkVForms "daki" ;
        <Hau,Pres,Gu>    => mkVForms "dakigu" ;
        <Hau,Pres,Zuek>  => mkVForms "dakizue" ;
        <Hau,Pres,Hauek> => mkVForms "dakite" ;
        _                => ukanDu ! dobjAgr ! tns ! subjAgr 
      } ;



{-
  =============================================================================
  Ibili
  =============================================================================
-}

{-
  =============================================================================
  Eman
  =============================================================================
-}

{-
  =============================================================================
  Esan
  =============================================================================
-}

{-
  =============================================================================
  Ikusi
  =============================================================================
-}

{-
  =============================================================================
  Erabili
  =============================================================================
-}

{-
  =============================================================================
  Egin
  =============================================================================
-}

}