resource AditzTrinkoak = open Prelude, ParamEus in {

-- Synthetic verbs are in this module

oper

    VForms : Type = { indep : Str ; stem : Str } ;

    noVForm : VForms = { indep = Prelude.nonExist ; stem = Prelude.nonExist } ;

    mkVForms = overload {
      mkVForms : Str -> VForms = \du ->
        let due : Str = case du of {
            _ + "en"          => init du ;        -- zen / zen
            _ + "a"           => init du + "e" ;  -- da  / d+en
            _ + "t"           => init du + "da" ; -- dut / duda+n
            _ + ("e"|"i"|"o") => du ;             -- dio / dio+n
            _                 => du + "e" }       -- du / du+en
        in { indep = du ; stem = due } ;

      mkVForms : (_,_ : Str) -> VForms = \dut,duda ->
        { indep = dut ; stem = duda } ;
    } ;

    IntransV : Type = Tense => Agr => VForms ;
    TransV   : Type = Agr => IntransV ;
    DitransV : Type = Agr => TransV ;



    syntTransVerb : Valency -> TransV = \val ->
      case val of {
        NorNork Ukan  => ukanNorNork ;
        NorNork Jakin => jakinNorNork ;
        NorNork Eduki => edukiNorNork ;
        NorNori       => ukanNoriNor ;
        _             => Predef.error "Not a transitive verb"
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
                             Zu => mkVForms "zara" ; 
                             Hau => mkVForms "da" ; 
                             Gu => mkVForms "gara" ; 
                             Zuek => mkVForms "zarete" ; 
                             Hauek => mkVForms "dira" }
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
                              Hi Masc => mkVForms "duk" ; 
                              Hi Fem => mkVForms "dun" ;
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
  --TODO make it properly, this is just for a few testing purposes

  ukanNoriNorNork : DitransV = 
    \\nori,nor,tns,nork => case <nori,nor,tns,nork> of 
    {  <Hau,Hau,Pres,Ni>  => mkVForms "diot" ;
       <Hau,Hau,Pres,Zu>  => mkVForms "diozu" ;
       <Hau,Hau,Pres,Hau> => mkVForms "dio" ;
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
                              Hi _ => mkVForms "naukan" ;
                              Zu => mkVForms "naukazu" } ;
                     _ => \\agr => noVForm 
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
                     _ => \\agr => noVForm 
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
                     _ => \\agr => noVForm 
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
                     _    => \\agr => noVForm           
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
                     _    => \\agr => noVForm
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
                     _    => \\agr => noVForm
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
                     _ => \\agr => noVForm 
              }
   } ;

{-
  =============================================================================
  Etorri 
  =============================================================================
-}

{-
  =============================================================================
  Joan
  =============================================================================
-}

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