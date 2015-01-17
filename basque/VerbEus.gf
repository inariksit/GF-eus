concrete VerbEus of Verb = CatEus ** open ResEus, Prelude in {


  lin
    UseV = predV ; -- {s = v.s ; sc = Abs ; prc = v.prc ; compl = []; adv = []} ; 


    --SlashV2a : V2 -> VPSlash
    SlashV2a v2 = lin VPSlash v2 ;

    --ComplSlash : VPSlash -> NP -> VP
    ComplSlash vps np = lin VP {s = vps.s ! np.agr ; --(Agr => Agr => Str) to (Agr => Str) 
				prc = vps.prc ;
				sc = vps.sc ;
				compl = np.s ! Abs ;
				adv = [] } ;

    CompNP  np  = lin Comp {s = np.s} ; 

--    CompAdv adv = lin Comp {s = table {_ => adv.s}} ;

                            

    UseCopula = lin VP {s = ResEus.copula ; prc = \\_ => [] ; 
			sc = Abs ; compl = [] ; adv = [] } ;

    --UseComp : Comp -> VP ;
    --UseComp = addCopula ;
    UseComp comp = lin VP {s     = ResEus.copula ; 
			   prc   = \\_ => [] ;
			   sc    = Abs ; 
                           compl = comp.s ! Abs ; 
                           adv   = [] } ;

    -- AdvVP : VP -> Adv -> VP ;
    AdvVP vp adv = lin VP { s = vp.s ; 
			    prc = vp.prc ;
			    sc = vp.sc ;
			    compl = vp.compl ;
			    adv = vp.adv ++ adv.s } ;

}