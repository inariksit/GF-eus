concrete ConjunctionEus of Conjunction = 
  CatEus ** open ResEus, Coordination, Prelude in {

  flags optimize=all_subs ;

    {- Conjunction for category X needs four things:
       lincat [X] 
       lin BaseX
       lin ConsX
       lin ConjX

    For example, if X is defined as

      lincat X   = {s     : Number => Str ;   g : Gender} ;

    then [X] will split its s field into two, and retain its other fields as is:

      lincat [X] = {s1,s2 : Number => Str ;   g : Gender} ;

    Let us look at a simple case: Adv is of type {s : Str}
    Then [Adv] is {s1,s2 : Str}.
    BaseAdv, ConsAdv and ConjAdv can all use functions defined in prelude/Coordination:

      BaseAdv = twoSS ;
      ConsAdv = consrSS comma ;
      ConjAdv = conjunctSS ;

    --}


-- Adverb, S and other simple {s : Str} types.
lincat
  [Adv],[AdV],[IAdv],[S] = {s1,s2 : Str} ;

lin
  BaseAdv, BaseAdV, BaseIAdv, BaseS = twoSS ;
  ConsAdv, ConsAdV, ConsIAdv, ConsS = consrSS comma ;
  ConjAdv, ConjAdV, ConjIAdv, ConjS = conjunctSS ;


-- RS depends on agreement, otherwise exactly like previous.
lincat
  [RS] = {s1,s2 : Agr => Str } ;

lin 
  BaseRS x y = twoTable Agr x y ;
  ConsRS xs x = consrTable Agr comma xs x ;
  ConjRS co xs = conjunctTable Agr co xs ;



-- APs and CNs. FIXME: crude first attempt, doesn't work properly.
lincat
  [AP] = {s1,s2 : Str ; ph : Phono ; typ : APType } ;

lin
  BaseAP x y = twoSS x y ** y ; --choose all the other fields from second argument
  ConsAP as a = consrSS comma as a ** a ;
  ConjAP co as = conjunctSS co as ** as ; 


lincat
  [CN] = {s1,s2,heavyMod : Agr => Str ; ph : Phono ; anim : Bizi } ;

lin 
  BaseCN x y = twoTable Agr x y ** y ; --choose all the other fields from second argument
  ConsCN cs c = consrTable Agr comma cs c ** c ; --- FIXME: loses the other heavyMod
  ConjCN co cs = conjunctTable Agr co cs ** cs ; 


-- Noun phrases. Should work better now.
lincat
  [NP] = { s1,s2 : Case => Str } ** NPLight ;

lin
  BaseNP x y = twoTable Case x y ** conjNP x y ;
  ConsNP xs x = consrTable Case comma xs x ** conjNP xs x ;
  ConjNP conj ss = conjunctNPTable conj ss ** conjNP ss conj ;

oper

  --NP without the s field; just to avoid copypaste and make things easier to change
  NPLight : Type = { agr  : Agr ; anim : Bizi ; nbr : Number ; isDef : Bool } ;

                     --the power of subtyping ^_^
  conjNP : NPLight -> { nbr : Number } -> NPLight = \x,y ->
    { agr  = conjAgr x.agr y.nbr ; 
      anim = x.anim ; -- Arbitrary: choose first argument's animacy 
      nbr  = conjNbr x.nbr y.nbr ; 
      isDef = x.isDef } ;

 -- Like conjunctTable from prelude/Coordination.gf,
 -- but forces the first argument into absolutive.
  conjunctNPTable : Conjunction -> ListTable Case -> {s : Case => Str} = \co,xs ->
   { s = table { Erg => xs.s1 ! Erg ++ co.s ++ xs.s2 ! Erg ;
                 cas => xs.s1 ! Abs ++ co.s ++ xs.s2 ! cas } } ;

  conjAgr : Agr -> Number -> Agr = \a,n ->
    case n of { Pl => plAgr a ; _  => a } ;

  conjNbr : Number -> Number -> Number = \n,m ->
    case n of { Pl => Pl ; _ => m } ;



}