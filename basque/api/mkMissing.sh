#!/bin/sh
echo "Create tmp dir"
mkdir tmp/
echo "Remove old file"
rm ../MissingEus.gf
echo "Look for missing functions" 
gf -src -i .. -batch TryEus.gf 2>&1 | grep "Warning: no linearization of" | sort -u > tmp/MissingEus.tmp
#gf -src -i .. -batch TryEus.gf 2>&1 | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | grep -E "constant not found|no linearization of" | sort -u > tmp/MissingEus.tmp
echo "Compile grammar"
gf -src -make -i . -D tmp ../LangEus.gf 
echo "Create placeholders for missing functions"
echo "resource MissingEus = open GrammarEus, Prelude in {" > ../MissingEus.gf
echo "" >> ../MissingEus.gf
echo "-- temporary definitions to enable the compilation of RGL API" >> ../MissingEus.gf
runghc mkMissing.hs >> ../MissingEus.gf
echo "}" >> ../MissingEus.gf
echo "Cleanup"
rm -Rf tmp
