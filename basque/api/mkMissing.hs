import PGF

main =
  do
    pgf <- PGF.readPGF "tmp/Lang.pgf"
    ms <- readFile "tmp/MissingEus.tmp" >>= return . map (last . words) . lines
    let ts = [PGF.showType [] t | m <- ms, Just t <- [PGF.functionType pgf (PGF.mkCId m)]]
    putStrLn $ unlines ["oper " ++ f ++ " : " ++ t ++ " = notYet \"" ++ f ++ "\" ;" | (f,t) <- zip ms ts]
