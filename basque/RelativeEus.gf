concrete RelativeEus of Relative = CatEus ** open ResEus in {



   -- RelCl    : Cl -> RCl ;            -- such that John loves her
   -- lin RelCl cl = {} ;

   -- RelVP    : RP -> VP -> RCl ;
   lin RelVP rp vp = lin RCl (mkRCl rp vp) ;

   -- RelSlash : RP -> ClSlash -> RCl ; -- whom John loves
   lin RelSlash rp cls = lin RCl (mkRClSlash rp cls) ;


   -- IdRP  : RP ;
   lin IdRP = lin RP { s = table { FinalCons => "en" ;
						           FinalR    => "en" ;
						           _         => "n"  
						         }  
			         } ;

   -- FunRP : Prep -> NP -> RP -> RP ;  -- the mother of whom
   --lin FunRP prep np rp = {} ;

{-
12:18:16 < inariksit> or "the dog, to whom I sing"
12:18:25 < inariksit> or "the dog, with whom I walk"
12:18:55 < spectei> "the mother of whom?" = "la madre de quien?" = "noren ama?"
12:19:37 < olatz> txakurra, zeinari abesten diodan. Would be the tranlsation, but....
12:20:35 < inariksit> it's just like "the dog who loves beer" = "garagardoa maite duten txakurra", but now with a preposition; "the dog to whom the owner sings"
12:21:04 < olatz> spectei, yes! and "zeinen ama?" too
12:21:39 < olatz> jabeak abesten dion txakurra

12:22:36 < olatz> those are very complicated sentences!!
12:22:37 < olatz> hahah
12:23:02 < olatz> "the dog, to whom I sing" -> abesten diodan txakurra
12:24:11 < inariksit> aah yeah, you have to change the copula too

12:27:23 < olatz> the dog, with whom I walk -> txakurra, zeinarekin ibiltzen naizen (this is absolutely not natural for basque :-S)
12:29:27 < olatz> I walk with you -> zurekin ibiltzen naiz
12:29:40 < olatz> I walk with the dog -> Txakurrarekin ibiltzen naiz
12:30:40 < olatz> so..... walk with -> -kin ibili. but..... the dog,.... must be absolutive
12:32:18 < spectei> yeah, you are missing a kind of word
12:32:36 < spectei> that kind of word is a pro-NP that stands in place of the thing that the relative is modifying
12:32:46 < olatz> txakurra, zeinarekin ibiltzen naizen
12:32:53 < spectei> like HARGLE-kin ibiltzen naizen txakurra
12:32:53 < begiak> bargle!
12:33:02 < inariksit> so this kind of clause wouldn't come before the txakurra?
12:33:41 < inariksit> like (nik) maite duten txakurra or (nik) abesten diodan txakurra
12:34:18 < olatz> yes.... zeinarekin....
12:35:54 < spectei> olatz, so "zeinarekin ibiltzen naizen txakurra" would be syntactically well formed?
12:38:18 < olatz> I would say... txakurra, zeinarekin ibiltzen naizen
12:39:20 < spectei> ok
12:39:28 < olatz> I'm not a linguist so I'm not sure about the syntactic correctness of the one above, but I would correct it if one my 
                  students writes it.

-}   

}