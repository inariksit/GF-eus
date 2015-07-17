--# -path=.:../chunk:alltenses:../basque

concrete TranslateEus of Translate = 
  NounEus,
  AdjectiveEus,
  SentenceEus,
  VerbEus - [UseCopula],
  ConjunctionEus,
  NumeralEus,
  AdverbEus,
  DictionaryEus ** 
open ResEus, Prelude in {

flags
  literal=Symb ;

}
