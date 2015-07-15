--# -path=.:../chunk:alltenses:../basque

concrete TranslateEus of Translate = 
  NounEus,
  AdjectiveEus,
  SentenceEus,
  VerbEus - [UseCopula],
  NumeralEus,
  AdverbEus,
  DictionaryEus ** 
open ResEus, Prelude in {

flags
  literal=Symb ;

}
