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
                            Hi => mkVForms "hintzen" ; 
                            Zu => mkVForms "zinen" ; 
                            Hau => mkVForms "zen" ; 
                            Gu => mkVForms "ginen" ; 
                            Zuek => mkVForms "zineten" ; 
                            Hauek => mkVForms "ziren" } ;

             Cond => table {Ni => mkVForms "nintzateke" ; 
                            Hi => mkVForms "hintzateke" ; 
                            Zu => mkVForms "zinateke" ; 
                            Hau => mkVForms "litzateke" ; 
                            Gu => mkVForms "ginateke" ; 
                            Zuek => mkVForms "zinatekete" ; 
                            Hauek => mkVForms "lirateke" } ;
             -- Present and future are identical
	           _     => table {Ni => mkVForms "naiz" ; 
                             Hi => mkVForms "haiz" ; 
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
                              Hi => mkVForms "ninduan" ; --| "nindunan" ;
                              Zu => mkVForms "ninduzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "naute" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "nauzue" ;
                              Hau => mkVForms "nau" ;
                              Hi => mkVForms "nauk" ; --| "naun" ;
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
                              Hi => mkVForms "gintuan" ; --| "gintunan" ;
                              Zu => mkVForms "gintuzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gaituzte" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gaituzue" ;
                              Hau => mkVForms "gaitu" ;
                              Hi => mkVForms "gaituk" ; --| "gaitun" ;
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
                              Hi => mkVForms "hituen" ;
                              Zu => mkVForms "zenituen" 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "ditugu" ;
                              Hauek => mkVForms "dituzte" ;
                              Ni => mkVForms "ditut" ;
                              Zuek => mkVForms "dituzue" ;
                              Hau => mkVForms "ditu" ;
                              Hi => mkVForms "dituk" ; --| "ditun" ;
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
                              Hi => noVForm ;
                              Zu => noVForm
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zaituztegu" ;
                              Hauek => mkVForms "zaituztete" ;
                              Ni => mkVForms "zaituztet" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zaituzte" ;
                              Hi => noVForm ;
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
                              Hi => mkVForms "huen" ;
                              Zu => mkVForms "zenuen" 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "dugu" ;
                              Hauek => mkVForms "dute" ;
                              Ni => mkVForms "dut" ;
                              Zuek => mkVForms "duzue" ;
                              Hau => mkVForms "du" ;
                              Hi => mkVForms "duk" ; --| "dun" ;
                              Zu => mkVForms "duzu" 
                     }
              } ;
              Hi => table {
                     Past => table {
                              Gu => mkVForms "hindugun" ;
                              Hauek => mkVForms "hinduten" ;
                              Ni => mkVForms "hindudan" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hinduen" ;
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "haugu" ;
                              Hauek => mkVForms "haute" ;
                              Ni => mkVForms "haut" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hau" ;
                              Hi => noVForm ;
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
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zaitugu" ;
                              Hauek => mkVForms "zaituzte" ;
                              Ni => mkVForms "zaitut" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zaitu" ;
                              Hi => noVForm ;
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
                    Hi => mkVForms "hengoen" ; 
                    Zu => mkVForms "zeunden" ; 
                    Hau => mkVForms "zegoen" ; 
                    Gu => mkVForms "geunden" ; 
                    Zuek => mkVForms "zeundeten" ; 
                    Hauek => mkVForms "zeuden" } ;
             -- TODO: Cond
             -- Present and future are identical
	     _ =>  table {Ni => mkVForms "nago" ; 
                    Hi => mkVForms "hago" ; 
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
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "naukate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "naukazue" ;
                              Hau => mkVForms "nauka" ;
                              Hi => mkVForms "naukan" ; --| "naukan" ;
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
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => noVForm ;
                              Hauek => mkVForms "gauzkate" ;
                              Ni => noVForm ;
                              Zuek => mkVForms "gauzkazue" ;
                              Hau => mkVForms "gauzka" ;
                              Hi => noVForm ;
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
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "dauzkagu" ;
                              Hauek => mkVForms "dauzkate" ;
                              Ni => mkVForms "dauzkat" ;
                              Zuek => mkVForms "dauzkazue" ;
                              Hau => mkVForms "dauzka" ;
                              Hi => mkVForms "dauzkak" ; --| "dauzkan" ;
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
                              Hi => noVForm ;
                              Zu => noVForm
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zauzkategu" ;
                              Hauek => mkVForms "zauzkatete" ;
                              Ni => mkVForms "zauzkatet" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzkate" ;
                              Hi => noVForm ;
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
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "daukagu" ;
                              Hauek => mkVForms "daukate" ;
                              Ni => mkVForms "daukat" ;
                              Zuek => mkVForms "daukazue" ;
                              Hau => mkVForms "dauka" ;
                              Hi => mkVForms "daukak" ; --| "daukan" ;
                              Zu => mkVForms "daukazu" 
                     }
              } ;
              Hi => table {
                     Past => table {
                              Gu => noVForm ;
                              Hauek => noVForm ;
                              Ni => noVForm ;
                              Zuek => noVForm ;
                              Hau => noVForm ;
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "haukagu" ;
                              Hauek => mkVForms "haukate" ;
                              Ni => mkVForms "haukat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "hauka" ;
                              Hi => noVForm ;
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
                              Hi => noVForm ;
                              Zu => noVForm 
                     } ;
                     _ => table { -- Pres
                              Gu => mkVForms "zauzkagu" ;
                              Hauek => noVForm ;
                              Ni => mkVForms "zauzkat" ;
                              Zuek => noVForm ;
                              Hau => mkVForms "zauzka" ;
                              Hi => noVForm ;
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

