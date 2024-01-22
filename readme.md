# SQL PROJEKT

## ZADÁNÍ
zadání projektu
## ANALÝZA

## POSTUP
### VYTVOØENÍ PRIMÁRNÍ TABULKY
#### ÚVOD
Primární tabulka t_roman_zavorka_project_sql_primary_final obsahující data z obou tabulek byla vytvoøena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kde 'CREATE' tabulku vytváøí a v pøípadì, že tabulka s tímto názvem již existuje, aktivuje se pøíkaz 'REPLACE,' který stávající tabulku nahradí novou, což v pøípadì potøeby umožòuje tabulku snadno upravovat. Tabulka byla v našem pøípadì vytvoøena skrze SQL dotazu za klauzulí 'AS.'
 
Podstatou výše zmínìné tabulky je slouèení tabulek czechia_payroll a czechia_price s jejich návaznými tabulkami (èíselníky) do jedné tabulky skrze stejné porovnatelné období, tedy spoleèné roky, ze které bude možné èerpat data ohlednì mezd a cen potravin za Èeskou republiku pro plnìní následujících úloh - vìdeckých otázek.
#### ZPÙSOB SPOJENÍ TABULEK
Protože data dvou tabulek na sebe kromì spoleèných let nemají pøímou návaznost, zpùsob propojení skrze klauzuli 'JOIN' není vhodné, protože všechny záznamy z jedné tabulky by se navázaly na záznamy se shodným rok v tabulce druhé, èímž by došlo ke zbyteènému nadbytí (duplicitám) záznamù, tudíž bylo slouèení tabulek provedeno skrze klauzuli 'UNION' (možno provést též pøes 'UNION ALL', nicménì výsledek zde bude stejný).

Vytvoøení výsledné tabulky bylo provedeno skrze slouèení dvou samostatných SQL dotazù zužující data na potøebné minimum; jeden pro tabulku czechia_payroll a druhý pro tabulku czechia_price.
#### DOTAZ PRO TABULKU czechia_payroll

Do klauzule 'FROM' byl vložen název pøíslušné tabulky czechia_payroll (cp), ze které byla data nahrávána.
V klauzuli nyní zobrazujeme veškeré sloupce: SELECT *.

Skrze zklauzuli 'JOIN' byla pøipojena menší tabulka czechia_payroll_industry_branch (cpib) s èíselníkem pro identifikaci jednotlivých prùmyslových odvìtví ze sloupce cp.industry_branch_code. Tabulka byla pøipojena následnì:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

Potøebné hodnoty ohlednì výše prùmìrných mezd se nacházejí v sloupci 'value', kde mimo jiné najdeme také hodnoty o 'prùmìrných poètech zamìstnaných osob,' které nejsou potøebné, tudíž skrze klauzuli WHERE byly záznamy omezeny pouze na hodnoty týkající se výše mezd: 

'WHERE cp.value_type_code = 5958'(zjištìno z èíselníku 'czechia_payroll_value_type').

Rovnìž byly zaznamenány záznamy, které mají ve sloupci 'industry_branch_code' hodnoty 'NULL,' a tak nevíme, do kterého odvìtví spadají. Protože informace o odvìtví je pro nás relevantní, byly tyto hodnoty též vylouèeny pøidáním další podmínky: 

'AND cp.industry_branch_code IS NOT NULL.'

Poznamka: Je možno rovnìž pøidat podmínku 'AND cp.value IS NOT NULL', nicménì v sloupci 'value' žádné prázdné záznamy o výši mezd nalezeny nebyly, a tak tato podmínka pøidána nebyla.

V tuto chvíli jsou zobrazovány veškeré sloupce a záznamy jsou omezeny pouze na záznamy o výši mezd v jednotlivých letech v jednotlivých kvartálech v jednotlivých odvìtvích. Data v tomto rozložení jsou však stále velmi obsáhlá a tak je mùžeme výraznì zmenšit zprùmìrováním fcí avg() a adekvátním seskupením klauzulí GROUP BY. V našem pøípadì byly záznamy seskupeny podle jednotlivých let mìøení a druhotnì podle prùmyslového odvìtví:

'GROUP BY cp.payroll_year, cpib.name'

Toto zprùmìrování a seskupení veškerých záznamù nám kromì zmenšení tabulky také významì pomùže i pøi øešení následujících úloh, protože takto nastavená data jsou snadnìji interpretována 
a v nìkterých pøípadech už ani není nutné použít fci avg ().

Kromì záznamù byly provedena omezení také v poètu sloupcù, kde v
ve v SELECT klauzuli byly ve finále vybrány pouze tøi dùležité sloupce:

* cp.payroll_year - obsahuje informace o období, pro které jednotlivé záznamy platí(název sloupce nám vyhovuje tak jak je).

* cpib.name AS industry_branch_name - sloupec s názvy prùmyslových odvìtví z pøipojené tabulky (èíselníku)'czechia_payroll_industry_branch', sloupec 'cp.industry_branch_code' už tedy nepotøebujeme.

* round(avg(cp.value),2) AS mean_salary_czk - dosavadní sloupec 'cp.value' obsahující hodnoty o výši hrubých mezd byl zprùmìrován a zaokrouhlen na dvì desetinná místa skrze funkce avg() a round(). Protože výše mezd je vyjádøena v èeských korunách, byla do názvu pøidána zkratka 'czk.'	

Nyní když když byl byly nastaveny 'aliasy', mùžeme v klauzuli GROUP BY nahradit 'cpib.name' názvem 'industry_branch_name':

'GROUP BY cp.payroll_year, industry_branch_name'

Koneèný výstup této tabulky byl poté skrze klauzuli ORDER BY seøazen sestupnì podle roku a vzestupnì podle názvu prùmyslového odvìtví: 

'ORDER BY cp.payroll_year DESC, industry_branch_name ASC'

V tomto bodì je výstupem tabulka se tøemi sloupci: payroll_year, industry_branch_name a mean_salary_czk; rozsah tabulky je celkem 418 øádkù. Tabulka nám ukazuje prùmìrné mzdy v jednotlivých letech v jednotlivých odvìtvích a je seøazena sestupnì podle let a vzestupnì podle názvu odvìtví.
#### DOTAZ PRO TABULKU czechia_price
Do klauzule 'FROM' vložen název tabulky czechia_price (cpr)
a skrze SELECT * byly zobrazeny vešchny sloupce.

Hodnoty ohlednì cen potravin se nacházejí v sloupci 'value', (stejnì pojmenován jako v tabulce czechia_payroll), pøièemž potraviny josu identifkovány pouze v sloupc 'category_code'.

Abychom jednoznaènì identifikovali jednotlivé kategorie potravin, byla pøpojena skrze klauzuli 'JOIN' tabulka czechia_price_category (cpc) obsahující èíselník. Tabulka byla pøipojena následovnì:

'czechia_price_category (cpc) ON cp.category_code = cpc.code'

Kromì sloupce 'region_code' jsou záznamy kompletní a neobsahují 'NULL' hodnoty. Protože data v následujících úlohách budou zpracovávána celkovì pro ÈR, není informace o kraji v sloupci 'region_code' dùležitá. Omezení rozsahu záznamu v této tabulce není nutné.

Následnì byly v klauzuli 'SELECT' byly vybrány potøebné sloupce.
Jako první potøebujeme o roku, do kterého jednotlivé záznamy patøí. V tabulce jsou k dispozici dva sloupce udávájící tuto informaci: 'date_from' a 'date_to.' Záznamy jsou ve formátu, kde je uvedeno celé datum a èas. Protože pro propojení s první tabulkou potøebujeme znát pouze infomaci o roku, použijeme fci year(). 

Skrze dotaz: 'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)' zjístíme, že oba datmu jsou vždy ve stejném roce, a tak je možno použít kterýkoliv z tìchto dvou sloupcù; v našem pøípadì byl použit sloupec date_from: 

* year(date_from) AS price_year

* Jako další byl zvolen sloupec z pøipojené tabulky czechia_price_category (cpc) udávající název kategorie potravin: cpc.name AS foodstuff_name - (tudíž sloupec cpr.category_code již nadále nepotøebujeme).

* Obdobným zpùsobem provedeme zprùmìrování a zaokrouhlení hodnot v sloupci cpr.value jako v tabulce czechia_payroll: round(avg(cpr.value),2) AS mean_price_czk.

* Posledním sloupcem této tabulky vznikl slouèením sloupcù 'cpc.price_value' a 'cpc.price_unit' z pøipojené tabulky czechia_price_category (cpc) funkcí concat(): concat(cpc.price_value," ",cpc.price_unit) AS price_unit.
		Tento sloupec udává množství, ke kterému se vážou ceny jednotlivých kategorií potravin (napø. cena za 0,5 l piva).

Obdobnì jako v tabulce czechia_payroll je i zde velmi mnoho záznamù, a tak byly i zde byly hodnoty o cenách potravin zprùmìrovány a seskupeny skrze klauzuli 'GROUP BY' podle roku a
kategorie potravin: 

'GROUP BY price_year, foodstuff_name'

Výstup našeho dotazu pro tuto tabulku byl následnì skrze klauzuli ORDER BY seøazen sestupnì podle roku a vzestupnì podle kategorie potravin: 

'ORDER BY price_year DESC, foodstuff_name ASC'

Dosavadní výstup je tedy složen ze sloupcù 'price_year', 'foodstuff_name', 'mean_price_czk' a 'price_unit' s rozsahem celkem 342 øádkù. Jednotlivé záznamy nám prozrazují, jaké jsou prùmìrné ceny jednotlivých potravinových kategorií v jednotlivých letech pro dané množství a jsou seøazeny sestupnì podle let a vzestupnì podle názvu potravin.
#### SPOJENÍ DOTAZÙ 
Nyní když je rozsah našich dvou tabulek pøipraven, mùžeme postupnì pøistoupit k jejich spojení skrze klauzuli 'UNION.' 

Prvním problémem který bránil spojení dvou tabulek byl nestejný poèet sloupcù (3 na 4). Mimo jíne jsem se rozhodl, že data z obou tabulek chci mít v separovaných sloupcích. toho bylo dosaženo pøidáním 'null' sloupcù do obou našich tabulek, pøièemž novì pøidané 'null' sloupce v horní tabulce ponesou názvy sloupcù spodní tabulky a 'null' sloupce ve spodní tabulce budou zaèlenìny do prvních tøi sloupcù první tabulky:

czechia_payroll:
 
SELECT 
cp.payroll_year, 
cpib.name AS industry_branch_name, 
round(avg(cp.value),2) AS mean_salary_czk,
null AS price_year, 
null AS foodstuff_name, 
null AS mean_price_czk, 
null AS price_unit

czechia_price:
 
SELECT 
null, 
null, 
null, 
year(cpr.date_from) AS price_year, 
cpc.name AS foodstuff_name, 
round(avg(cpr.value),2) AS mean_price_czk, concat(cpc.price_value," ",cpc.price_unit) AS price_unit

Tímto byl vyøešen problém s nestejným poètem sloupcù a zároveò došlo k separaci sloupcù obou tabulek. Poté již bylo potøeba zabalit dotazy dvou tabulek do závorek a spojit klauzulí 'UNION,' èímž je SQL dotaz pro zobrazení všech potøebných položek obou tabulek dokonèen.

Nyní, jak bylo již popsáno na zaèátku, staèí nad dosavadní dotaz pøidat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' která dá pokyn k vytvoøení èi nahrazení tabulky 't_roman_zavorka_project_sql_primary_final'
### VYTVOØENÍ SEKUNDÁRNÍ TABULKY
#### ÚVOD
Obdobnì jako primární tabulka byla i sekundární tabulka vytvoøena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS', která vytvoøí èi nahradí tabulku t_roman_zavorka_project_SQL_secondary_final z SQL dotazu za koneènou klauzulí 'AS.'

Zmínìná tabulka byla vytvoøena spojením tabulek 'economies' a 'countries', které obsahují dodateèné informace o rùzných zemích svìta. Protože úlohou je vytvoøení tabulky obsahující dodateèná data o dalších evropských státech, ale zároveò nechceme tabulku mít pøíliš obsáhlou, zamìøíme se pouze na ÈR a sousední zemì.
#### ZPÙSOB SPOJENÍ TABULEK
Protože obì dvì tabulky obsahují záznamy, které na sebe pøímo navazují skrze spoleèný sloupec 'country', pøes které lze tyto dvì tabulky propojit aniž by docházelo k nežádoucím duplicitám, byly v tomto pøípadì propojeny skrze klauzuli 'JOIN.'
#### VYTVOØENÍ SQL DOTAZU
Jako první tabulka byla zvolena tabulka 'economies', a tak byla vložena do klauzule FROM. V klauzuli SELECT * zobrazujeme veškeré sloupce.

Naslednì byla skrze klauzuli 'JOIN' pøipojena tabulka 'countries': 

'JOIN countries c ON e.country = c.country'

Protože tabulka má obsahovat data pro další evropské zemì a pro stejné období, jako primární pøehled pro ÈR (2000–2021), omezíme data následující podmínkou:
 
'WHERE e.`year`>= 2000 AND c.continent = 'Europe'

Nyní, když byly obì dvì tabulky úspìšnì propojeny a záznamy byly omezeny pouze vybrané zemì, specifikujeme zkrze 'SELECT' klauzuli, které sloupce ve výsledné tabulce budou.

Zadáním je poskytnout data o HDP, GINI koeficientu a výši populace v dalších evropských zemích v jednotlivých letech; tyto data najdeme v tabulce 'economies':

* e.country - názvy zemí
* e.`year`, - rok, pro který data platí
* e.GDP AS hdp - (hrubý domácí produkt)
* e.gini - gini koeficient
* e.population - údaje o vývoji populace v letech; sloupec c.populaton z druhé tabulky vývoj populace v letech nezaznamenává (je fixní), a tak nebyl vybrán.

Z tabulky 'countries' byly zároveò nad rámec zadání pøidány doplòující informace o jednotlivých zemích:

Z tabulky 'countries':
* c.capital_city 
* c.continent
* c.region_in_world - bližší popis lokalizace státù
* c.currency_code

Tímto je SQL dotaz pro vymezení dat pro sekundární tabulku dokonèen. Výsledná tabulka sestává celkem z 9 sloupcù a její rozsah je 945 záznamù.

Nyní, stejnì jako u primární tabulky, staèí nad dosavadní dotaz pøidat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS' která dá pokyn k vytvoøení èi nahrazení tabulky.

### ÚLOHA È. 1: 
#### VÝPOÈET ROÈNÍCH ROZDÍLÙ VE MZDÁCH
Abychom zjistili, zda mzdy v jednotlivých odvìtvích stoupají èi klesají, byl vytvoøen sloupec s obsahující rozdíly ve mzdách mezi lety pro jednotlivá odvìtví. Toho bylo dosaženo skrze pøipojení duplicitní tabulky

V z naši primární tabulky (pf) byly skrze 'SELECT' klauzuli vybrány následující sloupce:
* pf.payroll_year - roky pro které záznamy o mzdách platí
* pf.industry_branch_name - prùmyslové odvìtví
* pf.mean_salary_czk - prùmìrné mzdy

Abychom vypoèetli roèní rozdíl ve mzdách, byla k naší tabulce klauzulí 'INNER JOIN' pøipojena duplicitní tabulka (pf2)která byla skrze vnoøený dotaz obdobným zpùsobem omezena na stejné sloupce jako v první tabulce. 

Tabulky byly propojeny skrze spoleèné roky a shodné odvìtví: 
'ON pf.payroll_year = pf2.payroll_year + 1 AND pf.industry_branch_name = pf2.industry_branch_name'

K roku v druhé tabulce byla pøiètena +1, aby byly veškeré záznamy v ní posunuty o rok zpìt. Pro pøipojení byl zvolen INNER JOIN, aby byly odstranìny nežádoucí NULL hodnoty v druhé tabulce plynoucí z posunutí záznamù o rok zpìt u roku 2000 (rok 1999 není k dispozici). 

'INNER JOIN' zároveò zajistí, že se ve vybraných sloupcích nebudou zobrazovat 'NULL' hodnoty plynoucí z propojení tabulek czechia_payroll a czechia_price skrze klauzuli 'UNION' (viz tvorba primární tabulky).

Po úspìšném pøipojení dvou tabulek byly položky (sloupce) ve vnìjší 'SELECT' klauzuli nastaveny následnì:
* k prvnímu sloupci 'pf.payroll_year' byl skrze concat() pøipojen pf2.payroll_year: 'concat(pf.payroll_year," – ", pf2.payroll_year) AS time_period'
* pf.industry_branch_name
* pf.mean_salary_czk AS latter_mean_salary_czk 
* pf2.mean_salary_czk AS former_mean_salary_czk
* Výpoèet a zaokrouhlení rozdílu mezi lety: round((pf.mean_salary_czk - pf2.mean_salary_czk),2) AS annual_difference_czk

Poznámka: protože hodnoty ohlednì mezd byly zprùmìrovány a seskupeny podle let a odvìtví již pøi tvorbì primární tabulky, není nutné používat funkci avg() ani klauzuli GROUP BY.

Pro zvýraznìní závìru roèního rozdílu byl skrze kaluzuli CASE vytvoøen sloupec 'annual_difference_notification', který upozoròuje, zda došlo rùstu, poklesu èi stagnacy mezd mezi lety:

* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) > 0 THEN "increase"
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) < 0 THEN "decrease !!!"
* ELSE "stagnancy"

Výsledná data byla seøazena vzestupnì podle názvu a sestupnì podle roku mìøení: 

'ORDER BY pf.industry_branch_name ASC, pf.payroll_year DESC'

Tímto je SQL dotaz pro otázku è. 1 dokonèen.
### ÚLOHA È. 2
#### VÝPOÈET PRÙMÌRU MEZD  
Protože v zadání se hovoøí o mzdách v jednotlivých letech obecnì a nikoliv podle odvìtví, bylo potøeba vypoèítat celkovou prùmìrnou mzdu ze všech odvìtví pro jednotlivé roky.

Z primární tablky (pf) ze sekce ohlednì mezd 
byl v 'SELECT' klauzuli vybrán sloupec s údajem o letech a sloupec poèítající prùmìr zaokrouhlený na dvì desetinná místa:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS total_mean_salary_czk

Následnì byly veškeré hodnoty seskpeny podle jednotivých let: 'GROUP BY pf.payroll_year'.
Výsledky byly rovnìž seøazeny sestupnì podle jednotlivých let:
'ORDER BY pf.payroll_year DESC'

V tuto chvíli náš dotaz zobrazuje celkové prùmìrné mzdy sestupnì podle jednotlivých let.

Dalším krokem bylo získat potøebné prùmìrné ceny potravin podle roku a kategorie potravin. Jelikož ceny potravin byly tímto zpùsobem zprùmìrovány a seskupeny již pøi tvorbì primární, není nutné je upravovat.

Protože záznamy ohlednì potravin bylo potøeba zobrazit vedle záznamù ohlednì mezd podle spoleèných let mìøení (což stávající tabulka pf neumožòuje), byla pøipojena duplicitní tabulka (pf2).

Záznamy v pøipojené tabulce byly skrze vnoøený dotaz omezeny rok, prùmìrné ceny potravin, název kategorie potravin a jednotky množství:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name
* pf.price_unit

Záznamy ve vnoøeném dotazu zároveò omezíme na první a srovnatelné období a na vybrané kategorie potravin: 'chléb' a 'mléko:'

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%mléko%' OR pf.foodstuff_name LIKE '%chléb%'"

Poznámka: tabulka czechia_payroll obsahuje záznamy z let 2000–2021 a tabulka czechia_price 2006–2018, prvním srovnatelným obdobím je tedy rok 2006 a posledním je rok 2018.

Vnoøený dotaz je tímto dokonèen a jeho spuštìním se nám zobrazí tabulka se 4 sloupci a 4 záznamy: prùmìrné ceny pro 1 kg chleba a 1 l mléka v letech 2006 a 2018.

Tabulka byla následnì propojena skrze spoleèné roky:

'ON pf.payroll = pf2.price_year'

Pro propojení byla zvolena klauzule 'INNER JOIN' aby veškeré záznamy byly omezeny jen na vybrané roky a vybrané potraviny v pøipojené pomocné tabulce.

Poznámka:  

#### VÝPOÈET VÝŠE MOŽNÉHO NÁKUPU POTRAVIN
## VÝSLEDKY
### ÚLOHA È. 1
#### ZÁVÌR

Podle dosavadních dat existují pouze ètyøi odvìtví, ve kterých mzdy nepøerušovanì rostly:
* Doprava a skladování
* Ostatní èinnosti
* Zdravotní a sociální péèe
* Zpracovatelský prùmysl

Ve valnì vìtšinì námi zkoumaných odvìtví byly pozorovány poklesy rùzných výší. Vìtšinou šlo o nárazové, krátkodobé poklesy (zejména v roce 2013), po nichž však mzdy opìt zaèaly stoupat:
* Administrativní a podpùrné èinnosti
* Èinnosti v oblasti nemovitostí
* Informaèní a komunikaèní èinnosti	
* Kulturní, zábavní a rekreaèní èinnosti
* Penìžnictví a pojišovnictví	
* Profesní, vìdecké a technické èinnosti	
* Tìžba a dobývání
* Ubytování, stravování a pohostinství
* Velkoobchod a maloobchod; opravy a údržba motorových vozidel: 
* Výroba a rozvod elektøiny, plynu, tepla a klimatiz. vzduchu 

Pozorujeme i nìkolik odvìtví, u nichž lze postøehnout postupný pokles stoupání a následné snižování mezd na konci období, pro které jsou data k dispozici; tedy nemusí se jednat jen o nárazový pokles, ale mùže dojít k delšímu poklesu ve výši mezd v budoucích letech:

* Stavebnictví 	
* Veøejná správa a obrana; povinné sociální zabezpeèení
* Vzdìlávání
* Zásobování vodou; èinnosti související s odpady a sanacemi
* Zemìdìlství, lesnictví, rybáøství

#### DETAILNÍ ROZBOR




