concrete VerbEus of Verb = CommonX ** open CatEus, ResEus, Prelude in {


  lin
    UseV v = {s = v.s ; compl = []; adv = []} ; 

    CompAP ap = {s = ap.s} ;
    CompNP np = {s = np.s} ; 

    --UseComp : Comp -> VP ;
    --UseComp = useCopula ;
    UseComp comp = lin VP {s     = copula ; 
                           compl = comp.s ! Abs ; 
                           adv   = [] } ;

oper
    copula : Agr => Str =
      table {SgP3 => "da" ; 
             Hargle => "hargle" ; 
             Bargle => "bargle" } ;


    useCopula : Comp -> VP = \comp ->
     lin VP {s = copula ; compl = comp.s ! Abs ; adv = [] } ;
}