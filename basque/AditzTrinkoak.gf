resource AditzTrinkoak = open Prelude, ResEus, CatEus, ParamX in {

-- Synthetic verbs are in this module

oper
    copulaNor : Tense => Agr => Str =
      table {Past => table {Ni => "nintzen" ; 
                    Hi => "hintzen" ; 
                    Zu => "zinen" ; 
                    Hau => "zen" ; 
                    Gu => "ginen" ; 
                    Zuek => "zineten" ; 
                    Hauek => "ziren" } ;
             Cond => table {Ni => "banintz" ; 
                    Hi => "bahintz" ; 
                    Zu => "bazina" ; 
                    Hau => "balitz" ; 
                    Gu => "bagina" ; 
                    Zuek => "bazinete" ; 
                    Hauek => "balira" } ;
             -- Present and future are identical
	     _ =>  table {Ni => "naiz" ; 
                    Hi => "haiz" ; 
                    Zu => "zara" ; 
                    Hau => "da" ; 
                    Gu => "gara" ; 
                    Zuek => "zarete" ; 
                    Hauek => "dira" }
       } ;

   -- copulaNorNoriNork : Agr => Agr => Tense => Agr => Str = 
   -- table {
   --     _ => copulaNoriNork  --TODO hauria d'existir?
   -- } ;

   copulaNoriNorNork : Agr => Agr => Tense => Agr => Str = 
   table {
       _ => copulaNorNork 
   } ;
  

    copulaNorNork : Agr => Tense => Agr => Str = table {
       -- Nor,Nork
              Ni => table {
                     Past => table {
                              Gu => Prelude.nonExist ;
                              Hauek => "ninduten" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "ninduzuen" ;
                              Hau => "ninduen" ;
                              Hi => "ninduan" | "nindunan" ;
                              Zu => "ninduzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => Prelude.nonExist ;
                              Hauek => "naute" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "nauzue" ;
                              Hau => "nau" ;
                              Hi => "nauk" | "naun" ;
                              Zu => "nauzu" 
                     }
              } ;
              Gu => table {
                     Past => table {
                              Gu => Prelude.nonExist ;
                              Hauek => "gintuzten" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "gintuzuen" ;
                              Hau => "gintuen" ;
                              Hi => "gintuan" | "gintunan" ;
                              Zu => "gintuzun" 
                     } ;
                     _ => table { -- Pres
                              Gu => Prelude.nonExist ;
                              Hauek => "gaituzte" ;
                              Ni => Prelude.nonExist ;
                              Zuek => "gaituzue" ;
                              Hau => "gaitu" ;
                              Hi => "gaituk" | "gaitun" ;
                              Zu => "gaituzu" 
                     }
              } ;
              Hauek => table {
                     Past => table {
                              Gu => "genituen" ;
                              Hauek => "zituzten" ;
                              Ni => "nituen" ;
                              Zuek => "zenituzten" ;
                              Hau => "zituen" ;
                              Hi => "hituen" ;
                              Zu => "zenituen" 
                     } ;
                     _ => table { -- Pres
                              Gu => "ditugu" ;
                              Hauek => "dituzte" ;
                              Ni => "ditut" ;
                              Zuek => "dituzue" ;
                              Hau => "ditu" ;
                              Hi => "dituk" | "ditun" ;
                              Zu => "dituzu" 
                     }
              } ;
              Zuek => table {
                     Past => table {
                              Gu => "zintuztegun" ;
                              Hauek => "zintuzteten" ;
                              Ni => "zintuztedan" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zintuzten" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist
                     } ;
                     _ => table { -- Pres
                              Gu => "zaituztegu" ;
                              Hauek => "zaituztete" ;
                              Ni => "zaituztet" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zaituzte" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     }
              } ;
              Hau => table {
                     Past => table {
                              Gu => "genuen" ;
                              Hauek => "zuten" ;
                              Ni => "nuen" ;
                              Zuek => "zenuten" ;
                              Hau => "zuen" ;
                              Hi => "huen" ;
                              Zu => "zenuen" 
                     } ;
                     _ => table { -- Pres
                              Gu => "dugu" ;
                              Hauek => "dute" ;
                              Ni => "dut" ;
                              Zuek => "duzue" ;
                              Hau => "du" ;
                              Hi => "duk" | "dun" ;
                              Zu => "duzu" 
                     }
              } ;
              Hi => table {
                     Past => table {
                              Gu => "hindugun" ;
                              Hauek => "hinduten" ;
                              Ni => "hindudan" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "hinduen" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     } ;
                     _ => table { -- Pres
                              Gu => "haugu" ;
                              Hauek => "haute" ;
                              Ni => "haut" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "hau" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist
                     }
              } ;
              Zu => table {
                     Past => table {
                              Gu => "zintugun" ;
                              Hauek => "zintuzten" ;
                              Ni => "zintudan" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zintuen" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     } ;
                     _ => table { -- Pres
                              Gu => "zaitugu" ;
                              Hauek => "zaituzte" ;
                              Ni => "zaitut" ;
                              Zuek => Prelude.nonExist ;
                              Hau => "zaitu" ;
                              Hi => Prelude.nonExist ;
                              Zu => Prelude.nonExist 
                     }
              }
   } ;
}
