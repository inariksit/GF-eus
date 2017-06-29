resource AditzTrinkoak = open Prelude, ParamEus in {

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

    IntransV : Type = Tense => Agr => VForms ;
    TransV   : Type = Agr => IntransV ;
    DitransV : Type = Agr => TransV ;

------------------------------------------------------------------------------

    syntTransVerb : Valency -> TransV = \val ->
      case val of {
        NorNork Ukan  => ukanNorNork ;
        NorNork Jakin => jakinNorNork ;
        NorNork Eduki => edukiNorNork ;
        NorNori       => ukanNoriNor ;
        _             => Predef.error "Not a transitive verb"
      } ;

------------------------------------------------------------------------------

--This version is probably very overgenerating, and wrong.
  ukanNoriNorNork : DitransV = 
    \\nori,nor,tns,nork => mkVForms (norNoriNork nor nori tns nork) ;


    norNoriNork : Agr -> Agr -> Tense -> Agr -> Str = \nor,nori,tns,nork ->
      case tns of {
        Past => "TODO:past tense" ;
        Cond => "TODO:conditional" ;
        _    => let dizki = norTableNorNoriNork ! getNum nor ;
                    da    = noriTableAll ! nork ! nori  + "<NORI>"; --form of nori depends on nork
                    zue   = norkTableAll ! nork + "<NORK>"
                in dizki + da + zue 
      } ;


    -- For Nor-Nori inflection, map from Agr to prefix morpheme in Nor position
    norTableNorNori : Agr => Str =
      table { Ni    => "na" ;
              Hi _  => "ha" ;
              Gu    => "ga" ;
              Zu    => "za" ;
              Zuek  => "za" ;
              _     => []  --Hau and Hauek
            } ;

    -- For Nor-Nori-Nork inflection, map from Agr to prefix morpheme in Nor position
    -- There is no other option than 3rd person, only difference is number.
    norTableNorNoriNork : Number => Str =
      table { Sg => "di" ;
              Pl => "dizki"  
            } ;

    -- For Nor-Nori and Nor-Nori-Nork inflections, map from Agr to morpheme in Nori position
    noriTableAll : Agr => Agr => Str =
      table { Ni      => table { Hau => "t" ; _ => "da" } ; --If nork is Hau, then the form ends in t, otherwise -da-
              Hi Masc => \\_ => "k" ;
              Hi Fem  => \\_ => "n" ;
              Zu      => \\_ => "zu" ;
              Hau     => \\_ => "o" ;
              Gu      => \\_ => "gu" ;
              Zuek    => \\_ => "zue" ;
              Hauek   => \\_ => "e" 
            } ;


    -- For Nor-Nork and Nor-Nori-Nork inflections, map from Agr to morpheme in Nork position            
    norkTableAll : Agr => Str =
      table { Ni      => "t" ;
              Hi Masc => "k" ;
              Hi Fem  => "n" ;
              Zu      => "zu" ;
              Hau     => [] ;
              Gu      => "gu" ;
              Zuek    => "zue" ;
              Hauek   => "te" 
            } ;


{-
  =============================================================================
  Izan [NOR]
  =============================================================================
-}

    -- common copula
    izanNor : IntransV =
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


    ukanNorNork : TransV = table {
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

  ukanNoriNor : TransV = table {
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
   } ;


{-
  =============================================================================
  Ukan [NOR] [NORI] [NORK]
  =============================================================================
-}
  -- Don't confuse the order of nor and nori!
  -- For GF purposes, Nori is the new argument from NorNork,
  -- and it is neater if we do Nori => NorNork.
  -- But conventional literature puts nor first, and it's easier to copy from books.
  oldUkanNoriNorNork : DitransV = 
--  ukanNoriNorNork : DitransV = 
    \\nori,nor,tns,nork => case <nori,nor,tns,nork> of {

       -- X give(s) SGP3 to SGP3
       <Hau,Hau,Pres,Ni>  => mkVForms "diot" ;
       <Hau,Hau,Pres,Hi Fem>  => mkVForms "dion" ;
       <Hau,Hau,Pres,Hi Masc>  => mkVForms "diok" ;
       <Hau,Hau,Pres,Hau> => mkVForms "dio" ;
       <Hau,Hau,Pres,Gu>  => mkVForms "diogu" ;
       <Hau,Hau,Pres,Zu>  => mkVForms "diozu" ;
       <Hau,Hau,Pres,Zuek>  => mkVForms "diozue" ;
       <Hau,Hau,Pres,Hauek> => mkVForms "diote" ;

       -- X give(s) PLP3 to SGP3
       <Hau,Hauek,Pres,Ni>  => mkVForms "dizkiot" ;
       <Hau,Hauek,Pres,Hi Fem>  => mkVForms "dizkion" ;
       <Hau,Hauek,Pres,Hi Masc>  => mkVForms "dizkiok" ;
       <Hau,Hauek,Pres,Hau> => mkVForms "dizkio" ;
       <Hau,Hauek,Pres,Gu>  => mkVForms "dizkiogu" ;
       <Hau,Hauek,Pres,Zu>  => mkVForms "dizkiozu" ;
       <Hau,Hauek,Pres,Zuek>  => mkVForms "dizkiozue" ;
       <Hau,Hauek,Pres,Hauek> => mkVForms "dizkiote" ;

       -- X give(s) SGP3 to PLP3
       <Hauek,Hau,Pres,Ni>  => mkVForms "diet" ;
       <Hauek,Hau,Pres,Hi Fem>  => mkVForms "dien" ;
       <Hauek,Hau,Pres,Hi Masc>  => mkVForms "diek" ;
       <Hauek,Hau,Pres,Hau> => mkVForms "die" ;
       <Hauek,Hau,Pres,Gu>  => mkVForms "diegu" ;
       <Hauek,Hau,Pres,Zu>  => mkVForms "diezu" ;
       <Hauek,Hau,Pres,Zuek>  => mkVForms "diezue" ;
       <Hauek,Hau,Pres,Hauek> => mkVForms "diete" ;

       -- X give(s) PLP3 to PLP3
       <Hauek,Hauek,Pres,Ni>  => mkVForms "dizkiet" ;
       <Hauek,Hauek,Pres,Hi Fem>  => mkVForms "dizkien" ;
       <Hauek,Hauek,Pres,Hi Masc>  => mkVForms "dizkiek" ;
       <Hauek,Hauek,Pres,Hau> => mkVForms "dizkie" ;
       <Hauek,Hauek,Pres,Gu>  => mkVForms "dizkiegu" ;
       <Hauek,Hauek,Pres,Zu>  => mkVForms "dizkiezu" ;
       <Hauek,Hauek,Pres,Zuek>  => mkVForms "dizkiezue" ;
       <Hauek,Hauek,Pres,Hauek> => mkVForms "dizkiete" ;

       _                 => mkVForms "ukan (nori-nor-nork): TODO"
    } ;

{-
  =============================================================================
  Egon
  =============================================================================
-}
    -- stative copula, like Spanish estar
  egonNor : IntransV =
    table { Past => table {
                     Ni => mkVForms "nengoen" ; 
                     Hi _ => mkVForms "hengoen" ; 
                     Zu => mkVForms "zeunden" ; 
                     Hau => mkVForms "zegoen" ; 
                     Gu => mkVForms "geunden" ; 
                     Zuek => mkVForms "zeundeten" ; 
                     Hauek => mkVForms "zeuden" } ;
             -- TODO: Cond
             -- Present and future are identical
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

   edukiNorNork : TransV = table {
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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr 

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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr 
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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr 
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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr
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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr 
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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr 
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
                    tns => \\agr => ukanNorNork ! Ni ! tns ! agr 
              }
   } ;

{-
  =============================================================================
  Etorri 
  =============================================================================
-}

  etorriNor : IntransV = 
    \\tns,subjAgr => 
      case <tns,subjAgr> of {
        <Pres,Ni>    => mkVForms "nator" ;
        <Pres,Hi _>  => mkVForms "hator" ;
        <Pres,Zu>    => mkVForms "zatoz" ;
        <Pres,Hau>   => mkVForms "dator" ;
        <Pres,Gu>    => mkVForms "gatoz" ;
        <Pres,Zuek>  => mkVForms "zatozte" ;
        <Pres,Hauek> => mkVForms "datoz" ;
        _            => izanNor ! tns ! subjAgr 
      } ;

{-
  =============================================================================
  Joan
  =============================================================================
-}
  joanNor : IntransV = 
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

        _            => izanNor ! tns ! subjAgr 
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

  ibiliNor : IntransV =
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
        Fut => izanNor ! Fut 
       } ;


{-
  =============================================================================
  Jakin
  =============================================================================
-}
  jakinNorNork : TransV = 
    \\dobjAgr,tns,subjAgr => 
      case <dobjAgr,tns,subjAgr> of {
        <Hau,Pres,Ni>    => mkVForms "dakit" ;
        <Hau,Pres,Zu>    => mkVForms "dakizu" ;
        <Hau,Pres,Hau>   => mkVForms "daki" ;
        <Hau,Pres,Gu>    => mkVForms "dakigu" ;
        <Hau,Pres,Zuek>  => mkVForms "dakizue" ;
        <Hau,Pres,Hauek> => mkVForms "dakite" ;
        _                => ukanNorNork ! dobjAgr ! tns ! subjAgr 
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