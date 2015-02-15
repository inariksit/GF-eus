concrete VerbEus of Verb = CatEus ** open ResEus, NounEus, AditzTrinkoak, Prelude in {


  lin
    UseV = predV ; -- {s = v.s ; sc = Abs ; prc = v.prc ; compl = []; adv = []} ; 


    --SlashV2a : V2 -> VPSlash
    SlashV2a v2 = lin VPSlash v2 ;

    -- V3 -> NP -> VPSlash ;  -- give it (to her)
    Slash2V3 v3 np = lin VPSlash {s = AditzTrinkoak.copulaNoriNorNork ! np.agr ;
				  prc = v3.prc ;
				  sc = Erg } ;

    -- V3  -> NP -> VPSlash ;  -- give (it) to her
    -- Slash2V3 v3 np = lin VPSlash {s = AditzTrinkoak.copulaNorNoriNork ! np.agr ;
    -- 				  prc = v3.prc ;
    -- 				  sc = Erg } ;

    --ComplSlash : VPSlash -> NP -> VP
    ComplSlash vps np = lin VP {s = vps.s ! np.agr ; --(Agr => Agr => Str) to (Agr => Str) 
				prc = vps.prc ;
				sc = vps.sc ;
				compl = table {_ => np.s ! Abs} ; -- NP as a complement doesn't agree with head, all agrs will give the same result
				adv = [] } ;

    CompNP  np  = lin Comp {s = table {_ => np.s ! Abs}} ; 

    -- the house is big   = etxea handia da
    -- the houses are big = etxeak handiak dira
    CompAP  ap  = lin Comp {s = table {agr => glue ap.stem (DefArt.s ! getNum agr ! Abs ! ap.ph)}} ;

    CompAdv adv = lin Comp {s = table {_ => adv.s}} ;

                            
-- choose copula based on transitivity(argstruct) of main verb.
    UseCopula = lin VP defaultVP ;

    --UseComp : Comp -> VP ;
    UseComp comp = lin VP (insertComp comp defaultVP) ;

    -- AdvVP : VP -> Adv -> VP ;
    AdvVP vp adv = lin VP (insertAdv adv vp) ;

oper 


    defaultVP : VP = lin VP {s     = AditzTrinkoak.copulaNor ; 
  		 	     prc   = table {_ => []} ; 
		             sc    = Abs ; 
			     compl = table {_ => []} ; 
			     adv   = [] } ;

}