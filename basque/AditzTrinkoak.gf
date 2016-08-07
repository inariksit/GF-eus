resource AditzTrinkoak = open Prelude, ParamEus in {

-- Synthetic verbs are in this module

oper

{-
  =============================================================================
  Izan [NOR]
  =============================================================================
-}
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

    copulaNor : IntransV =
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
  Ukan [NOR] [NORI] [NORK]
  =============================================================================
-}

   copulaNoriNorNork : DitransV = 
   table {
       _ => copulaNorNork 
   } ;

{-
  =============================================================================
  Ukan [NOR] [NORK]
  =============================================================================
-}


    copulaNorNork : TransV = table {
       -- Nor,Nork
              Ni => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => mkVForms "ninduten" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "ninduzuen" ;
                              Hau => mkVForms "ninduen" ;
                              Hi Fem  => mkVForms "ninduan" ; 
                              Hi Masc => mkVForms "nindunan" ;
                              Zu => mkVForms "ninduzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "naute" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "nauzue" ;
                              Hau => mkVForms "nau" ;
                              Hi Fem  => mkVForms "nauk" ; 
                              Hi Masc => mkVForms "naun" ;
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
                              Hi Fem => mkVForms "gintuan" ; 
                              Hi Masc => mkVForms "gintunan" ;
                              Zu => mkVForms "gintuzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gaituzte" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gaituzue" ;
                              Hau => mkVForms "gaitu" ;
                              Hi Fem => mkVForms "gaituk" ; 
                              Hi Masc => mkVForms "gaitun" ;
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
                              Hi Fem => mkVForms "dituk" ;
                              Hi Masc => mkVForms "ditun" ;
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
                              Hi Fem => mkVForms "duk" ; 
                              Hi Masc => mkVForms "dun" ;
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
  Egon
  =============================================================================
-}

    copulaEgonNor : IntransV =
      table {Past => table {Ni => mkVForms "nengoen" ; 
                    Hi _ => mkVForms "hengoen" ; 
                    Zu => mkVForms "zeunden" ; 
                    Hau => mkVForms "zegoen" ; 
                    Gu => mkVForms "geunden" ; 
                    Zuek => mkVForms "zeundeten" ; 
                    Hauek => mkVForms "zeuden" } ;
             -- TODO: Cond
             -- Present and future are identical
	     _ =>  table {Ni => mkVForms "nago" ; 
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

   eduki_V2 : TransV = table {
       -- Nor,Nork
              Ni => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "naukate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "naukazue" ;
                              Hau => mkVForms "nauka" ;
                              Hi _ => mkVForms "naukan" ;
                              Zu => mkVForms "naukazu" 
                     }
              } ;
              Gu => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gauzkate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gauzkazue" ;
                              Hau => mkVForms "gauzka" ;
                              Hi _ => noVForm ;
                              Zu => mkVForms "gauzkazu" 
                     }
              } ;
              Hauek => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "dauzkagu" ;
                              Hauek => mkVForms "dauzkate" ;
                              Ni => mkVForms "dauzkat" ;
                              Zuek => mkVForms "dauzkazue" ;
                              Hau => mkVForms "dauzka" ;
                              Hi Fem => mkVForms "dauzkak" ; 
                              Hi Masc => mkVForms "dauzkan" ;
                              Zu => mkVForms "dauzkazu" 
                     }
              } ;
              Zuek => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zauzkategu" ;
                              Hauek => mkVForms "zauzkatete" ;
                              Ni => mkVForms "zauzkatet" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzkate" ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     }
              } ;
              Hau => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "daukagu" ;
                              Hauek => mkVForms "daukate" ;
                              Ni => mkVForms "daukat" ;
                              Zuek => mkVForms "daukazue" ;
                              Hau => mkVForms "dauka" ;
                              Hi Fem => mkVForms "daukak" ; 
                              Hi Masc => mkVForms "daukan" ;
                              Zu => mkVForms "daukazu" 
                     }
              } ;
              Hi _ => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "haukagu" ;
                              Hauek => mkVForms "haukate" ;
                              Ni => mkVForms "haukat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hauka" ;
                              Hi _ => noVForm ;
                              Zu => noVForm
                     }
              } ;
              Zu => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zauzkagu" ;
                              Hauek => noVForm ;
                              Ni => mkVForms "zauzkat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzka" ;
                              Hi _ => noVForm ;
                              Zu => noVForm 
                     }
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
  --TODO: check, this is just from Wikipedia example inflection

  ibili : IntransV =
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

        _ => table {Ni => mkVForms "nabil" ; 
                    Hi _ => mkVForms "habil" ; 
                    Zu => mkVForms "zabiltza" ; 
                    Hau => mkVForms "dabil" ; 
                    Gu => mkVForms "gabiltza" ; 
                    Zuek => mkVForms "zabiltzate" ; 
                    Hauek => mkVForms "dabiltza" }
       } ;


{-
  =============================================================================
  Jakin
  =============================================================================
-}

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

