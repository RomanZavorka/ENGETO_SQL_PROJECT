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

"WHERE cp.value_type_code = 5958 (zjištìno z èíselníku 'czechia_payroll_value_type').

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
Obdobnì jako primární tabulka byla i sekundární tabulka vytvoøena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS', která vytvoøí èi nahradí tabulku t_roman_zavorka_project_SQL_secondary_final z SQL dotazu za koneènou klauzulí 'AS.'

## VÝSLEDKY





