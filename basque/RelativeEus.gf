concrete RelativeEus of Relative = CatEus ** open ResEus in {

--

--     RelCl    : Cl -> RCl ;            -- such that John loves her
--   lin RelCl cl = {} ;

--     RelVP    : RP -> VP -> RCl ;      -- who loves John
   lin RelVP rp vp = lin RCl (mkRCl rp vp) ;

--     RelSlash : RP -> ClSlash -> RCl ; -- whom John loves
--   lin RelSlash rp clslash = {} ;


-- Relative pronouns are formed from an 'identity element' by prefixing
-- or suffixing (depending on language) prepositional phrases or genitives.

--     IdRP  : RP ;                      -- which
   lin IdRP = lin RP { s = table { FinalCons => "en" ;
						           FinalR    => "en" ;
						           _         => "n"  
						         }  
			         } ;

--    FunRP : Prep -> NP -> RP -> RP ;  -- the mother of whom
--   lin FunRP prep np rp = {} ;


--}

}
