concrete VerbEus of Verb = CatEus ** open ResEus, Prelude in {


  lin
    UseV v = {s = v.s ; compl = []; adv = []} ; 


    --SlashV2a : V2        -> VPSlash
    SlashV2a v2 = lin VPSlash {s     = v2.s ; 
			       compl = [] ;
			       adv   = [] ;
			       cas   = v2.cas } ;

    --ComplSlash : VPSlash -> NP -> VP
    ComplSlash vps np = lin VP {s = vps.s ; 
				compl = np.s ! vps.cas ;
				adv = [] } ;

    CompNP  np  = lin Comp np ; -- {s = np.s} ; 

--    CompAdv adv = lin Comp {s = table {_ => adv.s}} ;

                            

    UseCopula = lin VP {s = ResEus.copula ; compl = [] ; adv = [] } ;

    --UseComp : Comp -> VP ;
    --UseComp = addCopula ;
    UseComp comp = lin VP {s     = ResEus.copula ; 
                           compl = comp.s ! Abs ; 
                           adv   = [] } ;


}