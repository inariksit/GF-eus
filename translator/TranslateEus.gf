--# -path=.:../chunk:alltenses:../basque

concrete TranslateEus of Translate = 
  NounEus,
  SentenceEus,
  VerbEus - [UseCopula],
  AdverbEus,
  DictionaryEus ** 
open ResEus, Prelude in {

flags
  literal=Symb ;

}
