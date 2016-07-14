import Data.List 


type TagGF = String
type TagAp = String

transTag :: TagAp -> TagGF
transTag tag = case tag of
  "vblex" -> "V"
  "n"     -> "N"
  "adj"   -> "A"
  "adv"   -> "Adv"
  "np"    -> "PN"
  "num"   -> "Num"
  x       -> "NoTag"
  --TODO rest of the tags

-- Supported tags
tags :: [TagGF]
tags = map (\w -> "_"++w++" ") ["N", "A", "V", "V2", "VV"]


type Index = Int
type Parent = Int
type Relation = String
type Feature = String

data UD = UD Index Parent Relation Feature deriving (Eq,Ord,Show)

ud :: String -> UD
ud str = UD (read ind) (read parent) relation feature
 where
  ind:wf:lem:unipos:langpos:feature:parent:relation:_ = words str


--------------------------------------------------------------------------------

--e.g. "sea_N" and "itsaso<n>" to "lin sea_N = mkN \"itsaso\" ;"
mkEntryVariants :: String -> [String] -> String
mkEntryVariants sea_N itsasoak = 
  "lin " ++ sea_N ++ " = " ++ 
      concat 
       (intersperse " | "      
         [ mkX ++ " \"" ++ itsaso ++ "\"" | itsaso <- itsasoak_bakarrik ] ) ++
  " ;\n"
 where
  (_,cat) = split '_' sea_N
  mkX = "mk" ++ cat
  itsasoak_bakarrik = map (fst . split '<') itsasoak

  --TODO: different smart paradigm based on the analyses for itsaso
  --e.g. <adj><izo> vs. <adj>

mkEntry :: String -> String -> String
mkEntry sea_N itsaso_anas = 
  "lin " ++ sea_N ++ " = " ++ mkX ++ " \"" ++ itsaso ++ "\" ;\n"

 where
  (_,cat)    = split '_' sea_N
  mkX        = "mk" ++ cat
  (itsaso,_) = split '<' itsaso_anas

-- e.g. "calm_N" "baretu<vblex>" no match, but "calm_V" and "baretu<vblex>" yes

sameLemma :: String -> String -> Bool
sameLemma absname eng = lemma==name  && pos `elem` map transTag anas
 where
   (lemma:anas)  = map (delete '>') $ split' (=='<') eng
   (name,pos) = split '_' absname


absName :: String -> String
absName fun_name_rest = name
  where (fun:name:rest) = words fun_name_rest

--------------------------------------------------------------------------------


split :: Char -> String -> (String,String)
split c str = if atLeast 2 res then (res !! 0, res !! 1) else ("no basque :(", "no english :(")
  where res = split' (==c) str


split' :: (a -> Bool) -> [a] -> [[a]]
split' p [] = []
split' p xs = takeWhile (not . p) xs : split' p (drop 1 (dropWhile (not . p) xs))


atLeast 0 _  = True
atLeast _ [] = False
atLeast k (x:xs) = atLeast (k-1) xs

sndEq (_,a) (_,b) = a==b

--------------------------------------------------------------------------------


--concrete DictionaryEus of Dictionary = CatEus ** open ParadigmsEus, ResEus, Prelude in {
cncHeader absModule language = unlines [
  "--# -path=.:../basque",
  "concrete " ++ cncModule ++ " of " ++ absModule ++ " = Cat" ++ language ++ " ** open " ++ openModules language ++ " in {",
  "flags coding = utf8 ;",
  ""
 ]
 where cncModule = absModule ++ language

openModules lang = "Res" ++ lang ++ ", Paradigms" ++ lang ++ ", Prelude"

--------------------------------------------------------------------------------

main = do
 eu_en <- lines `fmap` readFile "eu-en.txt" 
 dict <- lines `fmap` readFile "../../GF/lib/src/translator/Dictionary.gf"

 let eus_eng = map (split ':') eu_en
 let absnames = [ absName word | word <- dict, tag <- tags, tag `isInfixOf` word ]


 let sea_itsasoak = [ (sea_N, itsasoak) | sea_N <- absnames
                                        , let itsasoak = map fst $ filter ((sameLemma sea_N . snd)) eus_eng 
                                        , (not.null) itsasoak]

-- print sea_itsasoak

 let entries = [ mkEntryVariants sea_N itsasoak | (sea_N, itsasoak) <- sea_itsasoak ]

 -- let entries = [ mkEntry sea_N itsaso | sea_N <- absnames
 --                                      , (itsaso,sea) <- eus_eng
 --                                      , sameLemma sea sea_N ]
 let file = "DictionaryEus.gf"
 writeFile file (cncHeader "Dictionary" "Eus")
 sequence_ [ putStrLn entry >> appendFile file entry | entry <- entries ]
 appendFile file "}" 





---
{-

1. Show eu-en.dix from apertium, lt-expand command and result

lt-expand apertium-eu-en.eu-en.dix | grep '^[A-Za-z]' | grep -v ' ' | sed 's/:[><]:/:/g ; s/.*:$//' |  sort -u > eu-en.txt

2. 

eu_en <- lines `fmap` readFile "eu-en.txt" 
dict <- lines `fmap` readFile "../../GF/lib/src/translator/Dictionary.gf"

let eus_eng = map (split ':') eu_en
let absnames = [ absName word | word <- dict, tag <- tags, tag `isInfixOf` word ]

[ mkEntry sea_N itsaso | sea_N <- absnames, (itsaso,sea) <- eus_eng, sameLemma sea sea_N ]

 



 -- sea_itsasoak <- sequence [ print itsasoak >> return (sea_N, itsasoak) 
 --                                        | sea_N <- take 1000 absnames
 --                                        , let itsasoak = map fst $ filter ((sameLemma sea_N . snd)) eus_eng 
 --                                        , (not.null) itsasoak]

 -- let entries = [ mkEntry sea_N itsasoak | (sea_N, itsasoak) <- sea_itsasoak ]
-}