# SQL PROJEKT

## ZADÁNÍ
"Na vašem analytickém oddìlení nezávislé spoleènosti, která se zabývá životní úrovní obèanù, jste se dohodli, že se pokusíte odpovìdìt na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veøejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovìdìt a poskytnout tuto informaci tiskovému oddìlení. Toto oddìlení bude výsledky prezentovat na následující konferenci zamìøené na tuto oblast.

Potøebují k tomu od vás pøipravit robustní datové podklady, ve kterých bude možné vidìt porovnání dostupnosti potravin na základì prùmìrných pøíjmù za urèité èasové období.

Jako dodateèný materiál pøipravte i tabulku s HDP, GINI koeficientem a populací dalších evropských státù ve stejném období, jako primární pøehled pro ÈR.

Datové sady, které je možné použít pro získání vhodného datového podkladu
Primární tabulky:

czechia_payroll – Informace o mzdách v rùzných odvìtvích za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR.
czechia_payroll_calculation – Èíselník kalkulací v tabulce mezd.
czechia_payroll_industry_branch – Èíselník odvìtví v tabulce mezd.
czechia_payroll_unit – Èíselník jednotek hodnot v tabulce mezd.
czechia_payroll_value_type – Èíselník typù hodnot v tabulce mezd.
czechia_price – Informace o cenách vybraných potravin za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR.
czechia_price_category – Èíselník kategorií potravin, které se vyskytují v našem pøehledu.
Èíselníky sdílených informací o ÈR:

czechia_region – Èíselník krajù Èeské republiky dle normy CZ-NUTS 2.
czechia_district – Èíselník okresù Èeské republiky dle normy LAU.
Dodateèné tabulky:

countries - Všemožné informace o zemích na svìtì, napøíklad hlavní mìsto, mìna, národní jídlo nebo prùmìrná výška populace.
economies - HDP, GINI, daòová zátìž, atd. pro daný stát a rok.
Výzkumné otázky
Rostou v prùbìhu let mzdy ve všech odvìtvích, nebo v nìkterých klesají?
Kolik je možné si koupit litrù mléka a kilogramù chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroèní nárùst)?
Existuje rok, ve kterém byl meziroèní nárùst cen potravin výraznì vyšší než rùst mezd (vìtší než 10 %)?
Má výška HDP vliv na zmìny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výraznìji v jednom roce, projeví se to na cenách potravin èi mzdách ve stejném nebo násdujícím roce výraznìjším rùstem?
Výstup projektu
Pomozte kolegùm s daným úkolem. Výstupem by mìly být dvì tabulky v databázi, ze kterých se požadovaná data dají získat. Tabulky pojmenujte t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za Èeskou republiku sjednocených na totožné porovnatelné období – spoleèné roky) a t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodateèná data o dalších evropských státech).

Dále pøipravte sadu SQL, které z vámi pøipravených tabulek získají datový podklad k odpovìzení na vytyèené výzkumné otázky. Pozor, otázky/hypotézy mohou vaše výstupy podporovat i vyvracet! Záleží na tom, co øíkají data.

Na svém GitHub úètu vytvoøte repozitáø (mùže být soukromý), kam uložíte všechny informace k projektu – hlavnì SQL skript generující výslednou tabulku, popis mezivýsledkù (prùvodní listinu) a informace o výstupních datech (napøíklad kde chybí hodnoty apod.).

Neupravujte data v primárních tabulkách! Pokud bude potøeba transformovat hodnoty, dìlejte tak až v tabulkách nebo pohledech, které si novì vytváøíte."

## ANALÝZA
### PØEHLED ZDROJOVÝCH TABULEK
Pro tvorbu primární tabulky byly k dispozici dvì kmenové tabulky, na než se také vážou pomocné tabulky - èíselníky.

czechia_payroll - Informace o mzdách v rùzných odvìtvích za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR. Tabulka sestává z 8 sloupcù:
* id
* value
* value_type_code - kód typu hodnoty
* unit_code - kód jednotky, ve které jsou hodnoty vyjádøeny
* calculation_code - kód zpùsobu výpoètu
* industry_branch_code - kód prùmyslového odvìtví
* payroll_year
* payroll_quarter

K této tabulce se váže nìkolik doplòujících tabulek:
* Czechia_payroll_calculation - èíselník kalkulací v tabulce mezd
* czechia_payroll_industry_branch – Èíselník odvìtví v tabulce mezd.
* czechia_payroll_unit – Èíselník jednotek hodnot v tabulce mezd.
* czechia_payroll_value_type – Èíselník typù hodnot v tabulce mezd.

czechia_price -  Informace o cenách vybraných potravin za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR. Tato tabulka sestává z 6 sloupcù:
* id
* value - prùmìrné ceny pro jednotlivé kategorie potravin
* category_code - kód kategorie potravin
* date_from
* date_to
* region_code - kód regionu (kraje)

K této tabulce se vážou také následující podpùrné tabulka:
* czechia_price_category – Èíselník kategorií potravin, které se vyskytují v našem pøehledu
* czechia_region – Èíselník krajù Èeské republiky dle normy CZ-NUTS 2.

V tabulce czechia_payroll mùžeme vidìt, že se zde nachází velké množství sloupcù, ve kterých jsou jen pouhé kódy, které nám nic neøíkají - tyto kódy jsou popsány v navazujících èíselnících. 

Nìkteré èíselníky byly použity jednou: *czechia_payroll_value_type - nastavení value_type_code, aby byly zobrazeny jen výše mezd (5958)
* czechia_payroll_unit - zjištìní, v jakých jendotkách jsou hodnoty ve sloupci 'value' vyjádøeny.

Dvì tabulky byly pøipojeny trvale: 
* czechia_price_category - identifikace kategorií potravin a a jejich jednotek množství
*czechia_payroll_industry_branch - identifikace prùmyslového odvìtví.

nìkteré vùbec: 
* czechia_payroll_calculation - zpùsob kalkulace hodnot pro nás není dùležitý

### PROBLEMATIKA TVORBY PRIMÁRNÍ TABULKY

Podstatou tvorby primární tabulky je slouèení tabulek czechia_payroll a czechia_price (a pøípadnì jejich návazné tabulky - èíselníky) do jedné tabulky skrze stejné porovnatelné období, tedy spoleèné roky, ze které bude možné èerpat data ohlednì mezd a cen potravin za Èeskou republiku pro plnìní následujících úloh - vìdeckých otázek.

Obì dvì tabulky obsahují velké množství informací, které jsou dále popsány v navazujících podpùrných tabulkách - èíselnících. Prvním krokem tedy bylo se s tabulkami seznámit a zjistit co obsahují a dle zadání zvážit, která data jsou pro nás dùležitá a která ne. V obou dabulkách mùžeme vidìt, že se zde nachází nìkolik sloupcù, ve kterých jsou jen pouhé kódy, které nám nic neøíkají - tyto kódy jsou popsány v navazujících èíselnících. 

Nìkteré èíselníky byly použity jednou: * czechia_payroll_value_type - 'nastavení value_type_code', aby byly zobrazeny jen výše mezd (kód 5958)
* czechia_payroll_unit - zjištìní, v jakých jednotkách jsou hodnoty ve sloupci 'value' vyjádøeny (pro mzdy to jsou èeské koruny).

Dvì tabulky byly pøipojeny trvale: 
* czechia_price_category - identifikace kategorií potravin a jejich jednotek množství
*czechia_payroll_industry_branch - identifikace prùmyslového odvìtví.

nìkteré vùbec: 
* czechia_payroll_calculation - zpùsob kalkulace hodnot pro nás není dùležitý
* czechia_region – data byla zpracovávána celkovì za ÈR; identifikace krajù pro nás tedy nemìla význam.

Po seznámení se s obsahem tabulek bylo v rámci tvorby prímarní tabulky nutno zdolat nìkolik pøekážek. Jednou z pøekážek byl obsah nepotøebných záznamù a hodnot. Tabulka czechia_payroll obsahuje kromì záznamù ohlednì hrubých mezd také záznamy o prùmìrných poètech zamìstnancù v odvìtvích - takové hodnoty nás zde nezajímají a tak byly vyøazeny. Zárovneò byly vylouèeny hodnoty o mzdách, u nichž nebyla uvedena informace o odvìtví, což považujeme za zásadní. 'NULL' hodnoty co se týèe mezd pozorovány nebyly.

V tabulce czechia price byly pozorovány 'NULL' hodnoty pouze v sloupci region_code, protože však data v tomto projektu jsou zpracovávána celkovì pro ÈR, nepøedstavují tyto chybjející informace o regionu problém. V tabulce czechia_price žádné hodnoty vyøazeny nebyly.

Dalším problémem byla obsáhlost tabulek, zejména 'czechia_price', která má celkem 108,249 záznamù. 'czechia_payroll' mìla po odstranìní nepotøebných záznamù 3,268 z pùvodních 6,880. Záznamy obou tabulek proto byly zprùmìrovány a seskupeny (podle roku a odvìtví/kategorie potravin), èímž se jejich rozsah výraznì zmenšil: 'czechia_payroll' na 418 a czechia_price na 342. S takto zmenšenými rozsahy budou veškeré operace s tìmito tabulkami výraznì rychlejší a jejich data se dají snáze èíst. 

Další pøekážkou bylo také nalezení zpùsobu, jak data dvou tabulek v budoucnu párovat. Tabulky jsou na sobe v podstatì nezávislé, a jediným spoleèným rysem byl údaj o èase mìøení - rok. V tabulce czechia_payroll tento údaj obsahoval sloupec 'payroll_year.' V tabulce czechia_price to byly sloupce 'date_to' a 'date_from', které obsahovaly celé datum, kde rok by v obou sloupcích vždy shodný, a tak mohl být použit kterýkoliv z nich.

Dále je nutno postøehnout, že tabulky se nemají shodný rozsah let, pro nìž dané záznamy platí: tabulka czechia_payroll obsahuje záznamy v letech 2000–2021, zatímco tabulka czechia_price pouze v letech 2006–2018. Tabulky lze tedy vzájemnì srovnávat pouze mezi lety 2006 a 2018.

Kromì omezování záznamù (øádkù ) bylo naší snahou omezovat rovnìž poèty sloupcù, kde v tabulce czechia_payroll byly nakonec vybrány pouze tøi sloupce obsahující následující informaci:
* údaj o roku - payroll_year
* názvu odvìtví - cpib.name (z èíselníku czechia_payroll_industry_branch)
* údaj o výši prùmìrné hrubé mzdy - value (posléze zprùmìrován a zaokrouhlen)

V tabulce czechia_price:
* údaj o roku -(year(date_from)) 
* údáj o výši ceny potravin - value (posléze zprùmìrován a zaokrouhlen). Poznámka: není jasnì definováno, v jakých jednotkách jsou zde ceny potravin uvedeny - pøedpokládáme, že jsou v èeských korunách.
* názvu kategorie potravin (z èíselníku czechia_price_category) 
* udaj o množství pro které ceny platí (z èíselníku czechia_price_category) - vznikl spojením sloupcù 'price_value' a 'price_unit' skrze concat().

Vybrané sloupce byly posléze v pøípadì potøeby pøejmenovány, aby aby se pøedešlo problému duplicitních názvù a aby bylo jasné, co obsahují.

Protože data dvou tabulek na sebe kromì spoleèných let nemají pøímou návaznost, zpùsob propojení skrze klauzuli 'JOIN' se nejevil jako vhodný, protože všechny záznamy z jedné tabulky by se navázaly na záznamy se shodným rokem v tabulce druhé, tudíž by došlo ke zbyteènému nadbytí (duplicitám) záznamù, èímž by byla zmaøena naše snaha o zredukování dat na absolutní minimum.

Propojení dvou zmínìných tabulek bylo tudíž provedeno skrze klauzuli 'UNION.' Tímto zpùsobem jsou tabulky spojeny nikoliv z boku ale zespoda, èímž nedocházelo k duplicitám záznamù. 

Jelikož skrze 'UNION' lze spojit pouze záznamy se stejnými poèty sloupcù, bylo nutné poèty sloupcù vyrovnat. V našem pøípadì toho bylo dosaženo vložením pomocných 'NULL' sloupcù obsahujících prázdné hodnoty. 

Tyto 'NULL' sloupce byly do obou tabulek vloženy tak, aby záznamy obou tabulek mìly své vlastní separátní sloupce (blíže popsáno v 'postupu').  

### ROZBOR VÝSLEDNÉ PRIMÁRNÍ TABULKY

Výsledkem našeho úsilí je tabulka s rozsahem 760 záznamù a celkem 7 slupci:
* payroll_year - informace o roku, pro který záznamy o mzdách platí
* industry_branch_name - název prùmyslového odvìtví
* mean_salary_czk - prùmìrná hrubá mzda podle roku a odvìtví
* price_year - informace o roku, pro který záznamy o cenách potravin platí 
* foodstuff_name - název kategorie potravin
* mean_price_czk - prùmìrná cena podle roku a kategorie potravin 
* price_unit - jednotka množství, na které se zázanmy o cenách potravin vztahují.

Záznamy tabulky nám prozrazují prùmìrné hrubé mzdy podle roku a prùmyslového odvìtví v letech 2000–2021 a také prùmìrné ceny podle roku a kategorie potravin.

Protože tabulky byly propojeny skrze 'UNION' a do separátních sloupcù, mùžeme vidìt, že tabulka obsahuje mnoho prázdných záznamù, tedy když se díváme na záznamy z tabulky 'czechia_payroll', záznamy z tabulky 'czechia_price' jsou prázdné a naopak.

 


## POSTUP
### VYTVOØENÍ PRIMÁRNÍ TABULKY
#### ÚVOD

Primární tabulka t_roman_zavorka_project_sql_primary_final obsahující data z obou tabulek byla vytvoøena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kde 'CREATE' tabulku vytváøí a v pøípadì, že tabulka s tímto názvem již existuje, aktivuje se pøíkaz 'REPLACE,' který stávající tabulku nahradí novou, což v pøípadì potøeby umožòuje tabulku snadno upravovat. Tabulka byla v našem pøípadì vytvoøena skrze SQL dotazu za klauzulí 'AS.'
 
Jak bylo již popsáno výše, vytvoøení výsledné tabulky bylo provedeno skrze slouèení dvou samostatných SQL dotazù klauzulí 'UNION.'; jeden pro tabulku czechia_payroll a druhý pro tabulku czechia_price.
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

Skrze dotaz: 'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)' zjístíme, že oba datumy jsou vždy ve stejném roce, a tak je možno použít kterýkoliv z tìchto dvou sloupcù; v našem pøípadì byl použit sloupec date_from: 

* year(date_from) AS price_year

* Jako další byl zvolen sloupec z pøipojené tabulky czechia_price_category (cpc) udávající název kategorie potravin: cpc.name AS foodstuff_name - (tudíž sloupec cpr.category_code již nadále nepotøebujeme).

* Obdobným zpùsobem provedeme zprùmìrování a zaokrouhlení hodnot v sloupci cpr.value jako v tabulce czechia_payroll: round(avg(cpr.value),2) AS mean_price_czk.

* Posledním sloupcem této tabulky vznikl slouèením sloupcù 'cpc.price_value' a 'cpc.price_unit' z pøipojené tabulky czechia_price_category (cpc) funkcí concat(): concat(cpc.price_value," ",cpc.price_unit) AS price_unit. Tento sloupec udává množství, ke kterému se vážou ceny jednotlivých kategorií potravin (napø. cena za 0,5 l piva).

Obdobnì jako v tabulce czechia_payroll je i zde velmi mnoho záznamù, a tak byly i zde byly hodnoty o cenách potravin zprùmìrovány a seskupeny skrze klauzuli 'GROUP BY' podle roku a kategorie potravin: 

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

Tímto byl vyøešen problém s nestejným poètem sloupcù a zároveò došlo k separaci sloupcù obou tabulek. Poté již bylo potøeba zabalit dotazy dvou tabulek do závorek a spojit klauzulí 'UNION,' èímž je SQL dotaz pro zobrazení všech potøebných položek obou tabulek dokonèen (možno provést též pøes 'UNION ALL', nicménì výsledek zde bude stejný).


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

Zobrazení sloupcù v pøipojené tabulce bylo skrze vnoøený dotaz omezeno rok, prùmìrné ceny potravin, název kategorie potravin a jednotky množství:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name
* pf.price_unit

V úloze je dáno, že výpoèty mají být provedeny pro první a poslední srovnatelné období a pouze pro kategorie potravin 'mléko' a 'chléb.'

Poznámka: tabulka czechia_payroll obsahuje záznamy z let 2000–2021 a tabulka czechia_price 2006–2018, prvním srovnatelným obdobím je tedy rok 2006 a posledním je rok 2018.

Záznamy ve vnoøeném dotazu byly tedy skrze klauzuli 'WHERE' omezeny následovnì:

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%mléko%' OR pf.foodstuff_name LIKE '%chléb%'"

Tyto podmínky zajistí, že se zobrazí pouze záznamy v letech 2006 a 2018 a zárovìò zobrazí pouze kategorie potravin, které mají ve svém názvu 'mléko' nebo 'chléb.'

Vnoøený dotaz je tímto dokonèen a jeho spuštìním se nám zobrazí tabulka se 4 sloupci a 4 záznamy: prùmìrné ceny pro 1 kg chleba a 1 l mléka v letech 2006 a 2018.

Tabulka byla následnì propojena skrze spoleèné roky:

'ON pf.payroll = pf2.price_year'

Pro propojení byla zvolena klauzule 'INNER JOIN' aby veškeré záznamy byly omezeny jen na vybrané roky a vybrané potraviny v pøipojené pomocné tabulce pf2.

Poznámka: omezením záznamù v pøipojené tabulce pf2 skrze vnoøený dotaz se vyraznì urychluje spuštìní celého SQL dotazu.

Do vnejší 'SELECT' klauzule byly následnì pøidány sloupce ohlednì cen potravin a výpoèet potenciálního množství vybraných potravin, které by bylo možné za prùmìrné mzdy nakoupit. Uspoøádání sloupcù
nyní vypadalo následovnì:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS total_mean_salary_czk
* pf.foodstuff_name
* pf.mean_price_czk
* round(avg(pf.mean_salary_czk)) / pf2.mean_price_czk,2) AS possible_purchase_amount
* pf.price_unit

Poznámka: hodnoty ohlednì mezd jsou zde uvedeny jako hrubé mzdy, pro zjednodušení výpoètu s nimi budeme zde nakládat jako s èistými mzdami.

Protože do 'SELECT' klauzule byly pøidány sloupce týkající se cen potravin, bylo nutné rovnìž provést úpravu v 'GROUP BY' klauzuli pøidáním sloupce 'pf2.foodstuff_name', aby se záznamy seskupily prvotnì podle roku a druhotnì podle kategorie potravin:

'GROUP BY pf.payroll_year, pf2.foodstuff_name'

Koneèný výstup byl následnì seøazen sestupnì podle roku a vzestupnì podle názvu kategorie potravin:

'ORDER BY pf.payroll_year DESC, pf2.foodstuff_name ASC'

Tímto je SQL dotaz pro otázku è. 2 dokonèen.

### ÚLOHA È. 3: 
#### VÝPOÈET ROÈNÍCH ROZDÍLÙ CEN POTRAVIN
Aby bylo možné zjistit, jak se ceny potravin mezi lety vyvíjely, byly z prùmìrných roèních cen jednotlivých potravin vypoèteny roèní rozdíly; postup v tomto pøípadì byl podobný jako v úloze è. 1.

Z primární tabulky 'pf' byly skrze 'SELECT' klauzuli vybrány sloupce uvádìjící informaci ohlednì roku, názvu kategorie potravin a prùmìrné ceny:
* pf.price_year
* pf.foodstuff_name
* pf.mean_price_czk
Pro výpoèet meziroèních rozílù byla následnì pøipojena duplicitní tabulka 'pf2', kde skrze vnoøený dotaz ('SELECT') byly vybrány stejné sloupce jak v naší hlavní tabulce 'pf.' a zároveò byly vyøazeny prázné záznamy, které v primární tabulce vznikly pøi její tvorbì skrze slouèení tabulek czechia_payroll a czechia_ price pøes 'UNION.':

'WHERE mean_price_czk IS NOT NULL'

Tabulky byly propojeny skrze shodné kategorie potravin a roky, kde v pøipojené tabulce byl pøipoèten rok navíc, èímž se záznamy v ní posunuly o rok zpìt:

'ON pf.price_year = pf2.price_year +1 AND pf.foodstuff_name = pf2.foodstuff_name

Tabulka byla pøipojena skrze 'INNER JOIN', aby z ní byly odstranìny nežádoucí záznamy S NULL hodnotami plynoucích z posunu záznamù - záznamy pøed rokem 2006 nemáme k dispozici. Zároveò tím  byly odstranìny prázdné hodnoty vzniklé pøi vzniku tabulky (pf) tabulce spojením cp a cpr skrze 'UNION').

Po úspìšném pøipojení tabulky pf2 byly ve vnejší 'SELECT' klauzuli provedeny následující zmìny v uspoøádání zobrazovaných sloupcù:
* concat(pf.price_year," – ", pf2.price_year) AS time_period
* pf.foodstuff_name,
* pf.mean_price_czk AS latter_mean_price_czk
* pf2.mean_price_czk AS former_mean_price_czk
* round((pf.mean_price_czk - pf2.mean_price_czk) / pf2.mean_price_czk*100,2) AS percentage_price_difference

Výše uvedený výbìr nám nyní zobrazuje prùmìry a meziroèní rozdíly prùmìrù cen potravin mezi lety. Záznamy byly posléze primárnì seøazeny sestupnì podle roku mìøení a poté vzestupnì podle názvu potravin v první tabulce:

'ORDER BY pf.price_year DESC, pf.foodstuff_name ASC'

Jelikož hodnoty týkající se cen potravin byly zprùmìrovány a seskupeny podle roku a kategorie potravin již pøi tvorbì primární tabulky 'pf' nebylo v tomto bodì nutné nastavovat klauzuli 'GROUP BY' (výsledky se zobrazí stejnì). 

Protože zobrazovaných záznamù je v tomto bodì velmi mnoho (celkem 315 øádkù), není snadné tato data interpretovat a udìlat z nich závìr o rychlosti zdražování èi slevòování jednotlivých potravin; z meziroèních rozdílù byl tedy pro jednotlivé potraviny vypoèten prùmìr.

Abychom mohli tento prùmìrný procentuální rozdíl vypoèítat, byl celý dosavadní dotaz vnoøen do nové klauzule 'FROM' (alias pf3) a skrze novou vnìjší klauzuli 'SELECT' byl proveden výpoèet prùmìrného procentuálního rozídlu pro jednotlivé potraviny:
* pf3.foodstuff_name
* round(avg(pf3.percentage_price_difference,2) AS mean_percentage_price_difference

Aby se vypoèty sekskupily podle jednotlivých potravin, bylo nutné v našem novém vnìjším dotazu nastavit klauzuli 'GROUP BY':

'GROUP BY pf3.foodstuff_name'

Koneèný výstup jsme rovnìž seøadili vzestupnì podle novì vypoèteného prùmìru a názvu potravin:

'ORDER BY mean_percentage_price_difference ASC, foodstuff_name ASC'

Tímto byla tvorba dotazu pro úlohu è. 3 dokonèena.

Výsledkem je výpis jednotlivých potravin seøazených primárnì podle prùmìrného procentuálního rozdílu a sekundárnì dle názvu potravin.
### ÚLOHA È. 4: 
####PØIPOJENÍ POMOCNÝCH TABULEK
Protože v této úloze je požadavkem zjistit, zda existuje, ve kterém byl meziroèní nárùst cen potravin výraznì vyšší než rùst mezd (vetší než 10%), bylo potøeba vypoèítat meziroèní rozdíly celkových roèních prùmìrù pro mzdy a ceny potravin. Abychom toho dosáhli, byly pøipojeny pomocné duplicitní tabulky 'pf2' a 'pf3.'

V první ze dvou tabulek 'pf2' poslouží k výpoètu meziroèního rozdílu ve mzdách, a tak byly skrze vnoøený dotaz vybrány sloupce s informací o roku a výpoètem prùmìrné výši mzdy:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (bude zaokrouhleno v pozdejších výpoètech)

Výsledky v tabulce byly rovnìž zbaveny prázdných záznamù a seskupeny podle jednotlivých let:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

V tomto bodì vnoøený dotaz naší tabulky zobrazuje celkové prùmìrné výše mezd pro jednotlivé roky. Tabulka byla následnì skrze 'INNER JOIN' pøipojena podle spoleèných let, kde k pf2 byl pøièten rok navíc, aby se její záznamy posunuly o rok zpìt:

'ON pf.payroll_year = pf2.payroll_year +1' 

Skrze toto spojení byly Meziroèní rozdíly ve mzdách vypoèteny ve vnìjší 'SELECT' klauzuli (bude ukázáno pozdìji).

Druhá pomocná tabulka 'pf3' poslouží k výpoètu meziroèního rozdílu v cenách potravin. Protože rozdíly ve mzdách byly vypoèteny skrze tabulky pf1 a pf2, není obdobný zpùsob výpoètu vhodný, protože by z podstaty 'UNION' propojení tabulek 'cp' a 'cpr' nastávaly problémy se zobrazením výsledkù ohlednì rozdílù cen potravin. Z tohoto dùvodu byly v této tabulce pøipraveny následující sloupce pro pozdìjší výpoèet meziroèního rozdílu v cenách potravin:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

Abychom mohli tyto sloupce zobrazit, byla ve vnoøeném dotazu pøipojena další pomocná tabulka: pf32 (pf31 je první), jejíž záznamy byly posunuty o rok zpìt:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

Tyto tabulky byly propojeny skrze 'INNER JOIN,' èímž byly odstranìny nežádoucí 'NULL' záznamy. Hodnoty byly nakonec seskupeny podle roku:

'GROUP BY pf31.price_year'

Vnoøený dotaz v tabulce pf3 ji nyní hotov a zobrazuje nám dva sloupce s nezaokrouhlenými prùmìrnými cenami potravin v jednotlivých letech, pøièemž jeden ze sploupcù má prùmìry posunuty o rok zpìt, abychom mohli následnì vypoèítat meziroèní rozdíly.

Pomocná tabulka pf3 byla poté skrze 'INNER JOIN' pøipojena k tabulce pf podle spoleèných let:

'ON pf.payroll_year = pf3.price_year'

'INNER JOIN' zde zajistí, že koneèné výstupy budou omezena jen na spoleèná srovnatelná období cen a mezd (2006–2018).

Poznámka: tím, že je èást výpoètù (zprùmìrování a seskupení) provedeno už uvnitø pomocných tabulek je rychlost zpuštìní koneèného dotazu výraznì urychleno.

Nyní, když byly veškeré nezbytné podklady pøipraveny, byly skrze vnìjší 'SELECT' klauzuli vypoèteny meziroèní procentuální rozdíly prùmìrných mezd a cen; z tìch byl poté zpoèten také rozdíl (rozdíl v meziroèních rozdílech mezd a cena potravin):
* concat(pf.payroll_year," – ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* round(((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100),2) - round(((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100),2) AS salary_price_percentage_difference

Tímto je dotaz pro úlohu è. 4 dokonèen. jeho spuštìním se nám zobrazí výpis meziroèních procentuálních rozdílù prùmìrných cen a mezd a také rozdíly v tìchto procentuálních meziroèních rozdílù.


## VÝSLEDKY
### ÚLOHA È. 1
#### SHRNUTÍ

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

#### DETAILNÍ POPIS VÝSLEDKÙ

### ÚLOHA È. 2

!!! NUTNO PØEDÌLAT HRUBÉ MZDY NA ÈISTÉ !!!

Pøi daných prùmìrných mzdách a cenách v prvním a posledním srovnatelném období, tedy v letech 2006 a 2018, je za celou výplatu možno nakoupit 1287.46 Kg a 1342.24 Kg chleba a 1437.24 l a 1641.57 l mléka.

### ÚLOHA È. 3

Ve výsledkích mùžeme vidìt, že v prùmìru ceny valné vìtšiny potravin zdražují; výjimkou jsou 'krystalový cukr' a 'rajská jablka èervená kulatá,' které naopak v prùmìru roènì slevòují o 1.92 % a 0.74 %. Podle dosavadních dat jsou tedy hypoteticky "nejpomaleji" zdražujícími potravinami 'Banány žluté', které v prùmìru roènì zdražují o 0,81 % a za nimi Vepøová peèenì s kostí 0.99 % roènì. Naopak v prùmìru nejrychleji se zdražující potravinou se zdají být 'Papriky': 7.29 % roènì a dále Máslo: 6.68 % 

























