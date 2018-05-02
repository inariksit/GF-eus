# Simple tests

## Morphology of synthetic verbs, take 1

Some tests found in `ukanDu.gfs`, `ukanZaio.gfs` and `ukanDio.gfs`. I test the forms against Apertium morphological analyser, you can use your favourite Basque morphological analyser.

In this directory I run it like this:

```
gf --run < ukanDio.gfs > /tmp/Dio.txt
```

And in the directory with Apertium, I run this:

```
cat /tmp/Dio.txt | lt-proc -w eus.automorf.bin | egrep -o "\*([a-zñ]*)\>" | sort -u
*didagu$
...
*zatzaie$
*zintzaizkizuekete$
```

The output is forms that the GF grammar generates but the Apertium analyser doesn't recognise. Some of them are due to overgeneration: forms like "I+me", "you+you" don't exist, you should use reflexive instead, which takes 3rd person object agreement and a special pronoun and all that stuff. So *didagu*  is wrong in the sense that it doesn't exist, but there is no other form that would be more correct. For that reason, I decided to keep these forms and not replace them with an empty string or `nonExist`. 
If an application grammarian needs to say "I see myself", they can just use  `ReflVP` in `VerbEus`.

Some of the non-existing forms are genuine mistakes, like *zatzaie*, which should be *zatza**zki**e* instead. Then you just go to `AditzTrinkoak.gf` and fix the relevant functions.

## Morphology of synthetic verbs, take 2

Better way: matching forms to what they are supposed to be, not just "does this form exist".

Open the GF shell and do the following:

```
$ gf
> i -retain ../AditzTrinkoak.gf
> cc -table -unqual ukanDio | ? grep -v stem > dio-gf.txt
> cc -table -unqual ukanDio | ? grep -v stem | cut -f 2 -d '.' | sort -u > dio-forms.txt
```

Then, do this to your secret Basque gold standard that you got by
sacrificing your firstborn:

```
egrep "^ukan" basque-secret-goldstandard | sed -E 's/ukan[^a-z]*([a-zñ]+).*V;(ARGABS.;ARGABS..);(ARGERG.;ARGERG..);(ARGIO.;ARGIO..);(.*)/\4 => \2 => \5 => \3 => indep . \1/' | egrep -v "^ukan" | grep -v INFM > dio-legit.txt
```

Then you can do e.g. this:

```
for form in `cat dio-forms.txt` ; do echo "===$form===" ; egrep "\<$form\>" dio-gf.txt ; grep "\<$form\>" dio-legit.txt ; done > dio-READMANUALLY.txt
```

You get output like following:

```
===dizkidate===
Ni => Gu => APres => Hauek => indep . dizkidate
Ni => Gu => AImp => Hauek => indep . dizkidate
Ni => Zuek => APres => Hauek => indep . dizkidate
Ni => Zuek => AImp => Hauek => indep . dizkidate
Ni => Hauek => APres => Hauek => indep . dizkidate
Ni => Hauek => AImp => Hauek => indep . dizkidate
ARGIO1;ARGIOSG => ARGABS3;ARGABSPL => PRES;IND => ARGERG3;ARGERGPL => dizkidate
```

From this you can deduce that the GF forms have some redundancies in the `Nor`/`ARGABS` argument, and the imperative form is always the same as the present indicative, but otherwise seems legit: `Ni` and `Hauek` match `ARGIO1;ARGIOSG` and `ARGERG3;ARGERGPL` respectively.

But then you get output like this, where no such form is found in the legit file:

```
===dizkigun===
Gu => Gu => APres => Hi Fem => indep . dizkigun
Gu => Gu => AImp => Hi Fem => indep . dizkigun
Gu => Zuek => APres => Hi Fem => indep . dizkigun
Gu => Zuek => AImp => Hi Fem => indep . dizkigun
Gu => Hauek => APres => Hi Fem => indep . dizkigun
Gu => Hauek => AImp => Hi Fem => indep . dizkigun
```

So then you can deduce that *dizkigun* doesn't exist.
