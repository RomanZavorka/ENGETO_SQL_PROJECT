# SQL PROJEKT
## ZADÁNÍ
### ÚVOD DO PROJEKTU
"Na vašem analytickém oddìlení nezávislé spoleènosti, která se zabývá životní úrovní obèanù, jste se dohodli, že se pokusíte odpovìdìt na pár definovaných výzkumných otázek, které adresují dostupnost základních potravin široké veøejnosti. Kolegové již vydefinovali základní otázky, na které se pokusí odpovìdìt a poskytnout tuto informaci tiskovému oddìlení. Toto oddìlení bude výsledky prezentovat na následující konferenci zamìøené na tuto oblast.

Potøebují k tomu od vás pøipravit robustní datové podklady, ve kterých bude možné vidìt porovnání dostupnosti potravin na základì prùmìrných pøíjmù za urèité èasové období.

Jako dodateèný materiál pøipravte i tabulku s HDP, GINI koeficientem a populací dalších evropských státù ve stejném období, jako primární pøehled pro ÈR.

### DATOVÉ SADY KTERÉ JE MOŽNÉ POUŽÍT PRO ZÍSKÁNÍ VHODNÉHO DATOVÉHO PODKLADU

#### PRIMÁRNÍ TABULKY:

1. czechia_payroll – Informace o mzdách v rùzných odvìtvích za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR.
2. czechia_payroll_calculation – Èíselník kalkulací v tabulce mezd.
3. czechia_payroll_industry_branch – Èíselník odvìtví v tabulce mezd.
4. czechia_payroll_unit – Èíselník jednotek hodnot v tabulce mezd.
5. czechia_payroll_value_type – Èíselník typù hodnot v tabulce mezd.
6. czechia_price – Informace o cenách vybraných potravin za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR.
7. czechia_price_category – Èíselník kategorií potravin, které se vyskytují v našem pøehledu.
#### ÈÍSELNÍKY SDÍLENÝCH INFORMACÍ O ÈR:
1. czechia_region – Èíselník krajù Èeské republiky dle normy CZ-NUTS 2.
2. czechia_district – Èíselník okresù Èeské republiky dle normy LAU.
#### DODATEÈNÉ TABULKY:
1. countries - Všemožné informace o zemích na svìtì, napøíklad hlavní mìsto, mìna, národní jídlo nebo prùmìrná výška populace.
2. economies - HDP, GINI, daòová zátìž, atd. pro daný stát a rok.
#### VÝZKUMNÉ OTÁZKY
1. Rostou v prùbìhu let mzdy ve všech odvìtvích, nebo v nìkterých klesají?
2. Kolik je možné si koupit litrù mléka a kilogramù chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?
3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroèní nárùst)?
4. Existuje rok, ve kterém byl meziroèní nárùst cen potravin výraznì vyšší než rùst mezd (vìtší než 10 %)?
5. Má výška HDP vliv na zmìny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výraznìji v jednom roce, projeví se to na cenách potravin èi mzdách ve stejném nebo násdujícím roce výraznìjším rùstem?

#### VÝSTUP PROJEKTU

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
* calculation_code - kód zpùsobu výpoètu hodnoty
* industry_branch_code - kód prùmyslového odvìtví
* payroll_year - rok pro nìž záznamy tabulky platí
* payroll_quarter - kvartál pro nìž záznamy tabulky platí

K této tabulce se váže nìkolik doplòujících tabulek:
* Czechia_payroll_calculation - èíselník kalkulací v tabulce mezd
* czechia_payroll_industry_branch – Èíselník odvìtví v tabulce mezd.
* czechia_payroll_unit – Èíselník jednotek hodnot v tabulce mezd.
* czechia_payroll_value_type – Èíselník typù hodnot v tabulce mezd.

czechia_price - Informace o cenách vybraných potravin za nìkolikaleté období. Datová sada pochází z Portálu otevøených dat ÈR. Tato tabulka sestává z 6 sloupcù:
* id
* value - prùmìrné ceny pro jednotlivé kategorie potravin
* category_code - kód kategorie potravin
* date_from
* date_to
* region_code - kód regionu (kraje)

K této tabulce se vážou také následující podpùrné tabulky:
* czechia_price_category – Èíselník kategorií potravin, které se vyskytují v našem pøehledu
* czechia_region – Èíselník krajù Èeské republiky dle normy CZ-NUTS 2.

### PROBLEMATIKA TVORBY PRIMÁRNÍ TABULKY

Podstatou tvorby primární tabulky je slouèení tabulek czechia_payroll a czechia_price (a pøípadnì jejich návazné tabulky - èíselníky) do jedné tabulky skrze stejné porovnatelné období, tedy spoleèné roky, ze které bude možné èerpat data ohlednì mezd a cen potravin za Èeskou republiku pro plnìní následujících úloh - vìdeckých otázek.

Obì dvì tabulky obsahují velké množství informací, které jsou dále popsány v navazujících podpùrných tabulkách - èíselnících. Prvním krokem tedy bylo se s tabulkami seznámit a zjistit co obsahují a dle zadání zvážit, která data jsou pro nás dùležitá a která ne. V obou dabulkách mùžeme vidìt, že se zde nachází nìkolik sloupcù, ve kterých jsou jen pouhé kódy, které nám nic neøíkají - tyto kódy jsou popsány v navazujících èíselnících. 

Nìkteré èíselníky byly použity jednou: 
* czechia_payroll_value_type - 'nastavení value_type_code', aby byly zobrazeny jen výše mezd - kód 5958
* czechia_payroll_unit - zjištìní, v jakých jednotkách jsou hodnoty ve sloupci 'value' vyjádøeny (pro mzdy to jsou èeské koruny).

Dvì tabulky byly pøipojeny trvale: 
* czechia_price_category - identifikace kategorií potravin a jejich jednotek množství
*czechia_payroll_industry_branch - identifikace prùmyslového odvìtví.

nìkteré tabulky vùbec: 
* czechia_payroll_calculation - zpùsob kalkulace hodnot pro nás není dùležitý
* czechia_region – data byla zpracovávána celkovì za ÈR; identifikace krajù pro nás tedy nemìla význam.

Po seznámení se s obsahem tabulek bylo v rámci tvorby prímarní tabulky nutno zdolat nìkolik pøekážek. Jednou z pøekážek byl obsah nepotøebných záznamù a hodnot. Tabulka czechia_payroll obsahuje kromì záznamù ohlednì hrubých mezd také záznamy o prùmìrných poètech zamìstnancù v odvìtvích - takové hodnoty nás zde nezajímají a tak byly vyøazeny. Zárovneò byly vylouèeny hodnoty o mzdách, u nichž nebyla uvedena informace o odvìtví, kterou považujeme za zásadní. 'NULL' hodnoty co se týèe mezd pozorovány nebyly.

V tabulce czechia price byly pozorovány 'NULL' hodnoty pouze v sloupci region_code, protože však data v tomto projektu jsou zpracovávána celkovì pro ÈR, nepøedstavují tyto chybjející informace o regionu problém. V tabulce czechia_price žádné hodnoty vyøazeny nebyly.

Dalším problémem byla obsáhlost tabulek, zejména 'czechia_price', která má celkem 108,249 záznamù. 'czechia_payroll' mìla po odstranìní nepotøebných záznamù 3,268 z pùvodních 6,880. Záznamy obou tabulek proto byly zprùmìrovány a seskupeny (podle roku a odvìtví/kategorie potravin), èímž se jejich rozsah výraznì zmenšil: 'czechia_payroll' na 418 a czechia_price na 342. S takto zmenšenými rozsahy budou veškeré operace s tìmito tabulkami výraznì rychlejší a jejich data se dají snáze èíst. 

Další pøekážkou bylo také nalezení zpùsobu, jak data dvou tabulek v budoucnu párovat. Tabulky jsou na sobe v podstatì nezávislé, a jediným spoleèným rysem byl údaj o èase mìøení - rok. V tabulce czechia_payroll tento údaj obsahoval sloupec 'payroll_year.' V tabulce czechia_price to byly sloupce 'date_to' a 'date_from', které obsahovaly celé datum, kde rok byl v obou sloupcích vždy shodný, a tak mohl být použit kterýkoliv z nich.

Dále je nutno postøehnout, že tabulky nemají shodný rozsah let, pro nìž dané záznamy platí: tabulka czechia_payroll obsahuje záznamy v letech 2000–2021, zatímco tabulka czechia_price pouze v letech 2006–2018. Tabulky lze tedy vzájemnì srovnávat pouze mezi lety 2006 a 2018.

Kromì omezování záznamù (øádkù ) bylo naší snahou omezovat rovnìž poèty sloupcù, kde v tabulce 'czechia_payroll' byly nakonec vybrány pouze tøi sloupce obsahující následující informaci:
* údaj o roku - payroll_year
* názvu odvìtví - cpib.name (z èíselníku czechia_payroll_industry_branch)
* údaj o výši prùmìrné hrubé mzdy - value (posléze zprùmìrován a zaokrouhlen)

V tabulce czechia_price:
* údaj o roku - date_from (posléze vložen do funkce year()) 
* údáj o výši ceny potravin - value (posléze zprùmìrován a zaokrouhlen). Poznámka: není jasnì definováno, v jakých jednotkách jsou zde ceny potravin uvedeny - pøedpokládáme, že jsou v èeských korunách.
* názvu kategorie potravin (z èíselníku czechia_price_category) 
* udaj o množství pro které ceny platí (z èíselníku czechia_price_category) - vznikl spojením sloupcù 'price_value' a 'price_unit' skrze funkci concat().

Vybrané sloupce byly posléze v pøípadì potøeby pøejmenovány, aby aby se pøedešlo problému duplicitních názvù a aby bylo jasné, co obsahují.

Protože data dvou tabulek na sebe kromì spoleèných let nemají pøímou návaznost, zpùsob propojení skrze klauzuli 'JOIN' se nejevil jako vhodný, protože všechny záznamy z jedné tabulky by se navázaly na záznamy se shodným rokem v tabulce druhé, tudíž by došlo ke zbyteènému nadbytí (duplicitám) záznamù, èímž by byla zmaøena naše snaha o zredukování dat na minimum.

Propojení dvou zmínìných tabulek bylo tudíž provedeno skrze klauzuli 'UNION.' Tímto zpùsobem jsou tabulky spojeny nikoliv z boku ale zespoda, èímž nedocházelo k duplicitám záznamù. 

Jelikož skrze 'UNION' lze spojit pouze záznamy se stejnými poèty sloupcù, bylo nutné poèty sloupcù vyrovnat. V našem pøípadì toho bylo dosaženo vložením pomocných 'NULL' sloupcù obsahujících prázdné hodnoty. Tyto 'NULL' sloupce byly do obou tabulek vloženy tak, aby záznamy obou tabulek mìly své vlastní separátní sloupce (blíže popsáno v sekci 'postupu').  

### ROZBOR VÝSLEDNÉ PRIMÁRNÍ TABULKY

Výsledkem našeho úsilí je tabulka "t_roman_zavorka_project_sql_primary_final" s rozsahem 760 záznamù a celkem 7 slupci:
* payroll_year - informace o roku, pro který záznamy o mzdách platí
* industry_branch_name - název prùmyslového odvìtví
* mean_salary_czk - prùmìrná hrubá mzda podle roku a odvìtví
* price_year - informace o roku, pro který záznamy o cenách potravin platí 
* foodstuff_name - název kategorie potravin
* mean_price_czk - prùmìrná cena podle roku a kategorie potravin 
* price_unit - jednotka množství, na které se zázanmy o cenách potravin vztahují.

Záznamy tabulky nám prozrazují prùmìrné hrubé mzdy podle roku a prùmyslového odvìtví v letech 2000–2021 a také prùmìrné ceny (na dané množství) podle roku a kategorie potravin v letech 2006–2018 .

Protože tabulky byly propojeny skrze klauzuli 'UNION' a do separátních sloupcù, mùžeme vidìt, že tabulka obsahuje mnoho prázdných záznamù, tedy když se díváme na záznamy z tabulky 'czechia_payroll', záznamy z tabulky 'czechia_price' jsou prázdné a naopak.

## POSTUP
### VYTVOØENÍ PRIMÁRNÍ TABULKY
#### ÚVOD

Primární tabulka t_roman_zavorka_project_sql_primary_final obsahující data z obou tabulek byla vytvoøena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kde 'CREATE' tabulku vytváøí a v pøípadì, že tabulka s tímto názvem již existuje, se aktivuje pøíkaz 'REPLACE,' který stávající tabulku nahradí novou, což v pøípadì potøeby umožòuje tabulku snadno upravovat a aktualizovat. Tabulka byla v našem pøípadì vytvoøena skrze SQL dotazu za klauzulí 'AS.'
 
Jak bylo již popsáno výše v analytické èásti, vytvoøení výsledné tabulky bylo provedeno skrze klauzuli 'UNION,' sluèující dva samostatné SQL dotazy; jeden pro tabulku czechia_payroll a druhý pro tabulku czechia_price.
#### DOTAZ PRO TABULKU czechia_payroll

Do klauzule 'FROM' byl vložen název pøíslušné tabulky czechia_payroll (cp), ze které byla data nahrávána.
Na zaèátku byly zobrazovány veškeré sloupce: 'SELECT *'.

Skrze zklauzuli 'INNER JOIN' (lze použít i 'LEFT JOIN') byla pøipojena menší tabulka czechia_payroll_industry_branch (cpib) s èíselníkem pro identifikaci jednotlivých prùmyslových odvìtví ze sloupce cp.industry_branch_code. Tabulka byla pøipojena následnì:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

Potøebné hodnoty ohlednì výše prùmìrných mezd se nacházejí v sloupci 'value', kde mimo jiné najdeme také hodnoty o 'prùmìrných poètech zamìstnaných osob,' které nejsou potøebné, tudíž skrze klauzuli 'WHERE' byly záznamy omezeny pouze na hodnoty týkající se výše mezd: 

'WHERE cp.value_type_code = 5958'(zjištìno z èíselníku 'czechia_payroll_value_type').

Rovnìž byly zaznamenány záznamy, které mají ve sloupci 'industry_branch_code' hodnoty 'NULL,' a tak nevíme, do kterého odvìtví spadají. Protože informace o odvìtví je pro nás relevantní, byly tyto hodnoty též vylouèeny pøidáním další podmínky do klauzule 'WHERE': 

'AND cp.industry_branch_code IS NOT NULL.'

Poznamka: Je možno rovnìž pøidat podmínku 'AND cp.value IS NOT NULL', nicménì v sloupci 'value' žádné prázdné záznamy o výši mezd nalezeny nebyly, a tak tato podmínka pøidána nebyla.

V tuto chvíli jsou zobrazovány veškeré sloupce a záznamy jsou omezeny pouze na záznamy o výši mezd v jednotlivých letech v jednotlivých kvartálech v jednotlivých odvìtvích. Data v tomto rozložení jsou však stále velmi obsáhlá a tak je mùžeme výraznì zmenšit zprùmìrováním fcí avg() a adekvátním seskupením klauzulí GROUP BY. V našem pøípadì byly záznamy seskupeny podle jednotlivých let mìøení a druhotnì podle prùmyslového názvu odvìtví (pøipojený èíselník):

'GROUP BY cp.payroll_year, cpib.name'

Toto zprùmìrování a seskupení veškerých záznamù nám kromì zmenšení tabulky také významì pomùže i pøi øešení následujících úloh, protože takto nastavená data jsou snadnìji interpretována a v nìkterých pøípadech už ani není nutné použít fci avg ().

Kromì záznamù byly provedena omezení také v poètu sloupcù, kde v 'SELECT' klauzuli byly ve finále vybrány pouze tøi dùležité sloupce:
* cp.payroll_year - obsahuje informace o období, pro které jednotlivé záznamy platí(název sloupce nám vyhovuje tak jak je).
* cpib.name AS industry_branch_name - sloupec s názvy prùmyslových odvìtví z pøipojené tabulky (èíselníku)'czechia_payroll_industry_branch', sloupec 'cp.industry_branch_code' už tedy nepotøebujeme.
* round(avg(cp.value),2) AS mean_salary_czk - dosavadní sloupec 'cp.value' obsahující hodnoty o výši hrubých mezd byl zprùmìrován a zaokrouhlen na dvì desetinná místa skrze funkce avg() a round(). Protože výše mezd je vyjádøena v èeských korunách, byla do názvu pøidána zkratka 'czk.'	

Nyní když byly nastaveny 'aliasy', mùžeme v klauzuli GROUP BY nahradit 'cpib.name' názvem 'industry_branch_name':

'GROUP BY cp.payroll_year, industry_branch_name'

Koneèný výstup této tabulky byl poté skrze klauzuli ORDER BY seøazen sestupnì podle roku a vzestupnì podle názvu prùmyslového odvìtví: 

'ORDER BY cp.payroll_year DESC, industry_branch_name ASC'

V tomto bodì je výstupem tabulka se tøemi sloupci: payroll_year, industry_branch_name a mean_salary_czk; rozsah tabulky je celkem 418 øádkù. Tabulka nám ukazuje prùmìrné mzdy v jednotlivých letech v jednotlivých odvìtvích a je seøazena sestupnì podle let a vzestupnì podle názvu odvìtví.
#### DOTAZ PRO TABULKU czechia_price
Do klauzule 'FROM' byl vložen název tabulky czechia_price (cpr) a skrze SELECT * byly zobrazeny vešchny sloupce.

Hodnoty ohlednì cen potravin se nacházejí v sloupci 'value', (stejnì pojmenován jako v tabulce czechia_payroll), pøièemž potraviny jsou identifkovány pouze v sloupci 'category_code'.

Abychom jednoznaènì identifikovali jednotlivé kategorie potravin, byla pøpojena skrze klauzuli 'INNER JOIN' (lze použít i 'LEFT JOIN') tabulka czechia_price_category (cpc) obsahující èíselník. Tabulka byla pøipojena následovnì:

'czechia_price_category (cpc) ON cp.category_code = cpc.code'

Kromì sloupce 'region_code' jsou záznamy kompletní a neobsahují 'NULL' hodnoty. Protože data v následujících úlohách budou zpracovávána celkovì pro ÈR, není informace o kraji v sloupci 'region_code' dùležitá. Omezení rozsahu záznamu v této tabulce není nutné.

Následnì byly v klauzuli 'SELECT' vybrány potøebné sloupce.
Jako první potøebujeme údaj o roku, do kterého jednotlivé záznamy patøí. V tabulce jsou k dispozici dva sloupce udávájící tuto informaci: 'date_from' a 'date_to.' Záznamy jsou ve formátu, kde je uvedeno celé datum a èas. Protože pro propojení s první tabulkou potøebujeme znát pouze infomaci o roku, byla použita funkce year().

Skrze násedující dotaz bylo zjištìno, že oba datumy jsou vždy ve stejném roce, a tak je možno použít kterýkoliv z tìchto dvou sloupcù:

'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)' 

V našem pøípadì byl vybrán sloupec 'date_from': 
* year(cpr.date_from) AS price_year
* Jako další byl zvolen sloupec z pøipojené tabulky czechia_price_category (cpc) udávající název kategorie potravin: cpc.name AS foodstuff_name - (tudíž sloupec cpr.category_code již nadále nepotøebujeme).
* Obdobným zpùsobem provedeme zprùmìrování a zaokrouhlení hodnot v sloupci cpr.value jako v tabulce czechia_payroll: round(avg(cpr.value),2) AS mean_price_czk.
* Posledním sloupcem této tabulky vznikl slouèením sloupcù 'cpc.price_value' a 'cpc.price_unit' z pøipojené tabulky czechia_price_category (cpc) funkcí concat(): concat(cpc.price_value," ",cpc.price_unit) AS price_unit. Tento sloupec udává množství, ke kterému se vážou ceny jednotlivých kategorií potravin (napø. cena za 0,5 l piva).

Obdobnì jako v tabulce czechia_payroll je i zde velmi mnoho záznamù, a tak byly i zde byly hodnoty o cenách potravin zprùmìrovány a seskupeny skrze klauzuli 'GROUP BY' podle roku a kategorie potravin: 

'GROUP BY price_year, foodstuff_name'

Výstup našeho dotazu pro tuto tabulku byl následnì skrze klauzuli ORDER BY seøazen sestupnì podle roku a vzestupnì podle kategorie potravin: 

'ORDER BY price_year DESC, foodstuff_name ASC'

Dosavadní výstup je tedy složen ze sloupcù 'price_year', 'foodstuff_name', 'mean_price_czk' a 'price_unit' s rozsahem celkem 342 øádkù. Jednotlivé záznamy nám prozrazují, jaké jsou prùmìrné ceny jednotlivých potravinových kategoriích v jednotlivých letech pro dané množství a jsou seøazeny sestupnì podle let a vzestupnì podle názvu potravin.
#### SPOJENÍ DOTAZÙ 
Nyní když je rozsah našich dvou tabulek pøipraven, mùžeme postupnì pøistoupit k jejich spojení skrze klauzuli 'UNION.' 

Prvním problémem který bránil spojení dvou tabulek byl nestejný poèet sloupcù (3 na 4). Mimo jíne jsem se rozhodl, že data z obou tabulek chci mít v separovaných sloupcích. toho bylo dosaženo pøidáním 'null' sloupcù do obou našich tabulek, pøièemž novì pøidané 'null' sloupce v horní tabulce ponesou názvy sloupcù spodní tabulky a 'null' sloupce ve spodní tabulce budou zaèlenìny do prvních tøi sloupcù první tabulky:

czechia_payroll:
 
* SELECT 
* cp.payroll_year, 
* cpib.name AS industry_branch_name, 
* round(avg(cp.value),2) AS mean_salary_czk,
* null AS price_year, 
* null AS foodstuff_name, 
* null AS mean_price_czk, 
* null AS price_unit

czechia_price:
 
* SELECT 
* null, 
* null, 
* null, 
* year(cpr.date_from) AS price_year, 
* cpc.name AS foodstuff_name, 
* round(avg(cpr.value),2) AS mean_price_czk, * concat(cpc.price_value," ",cpc.price_unit) AS price_unit

Tímto byl vyøešen problém s nestejným poètem sloupcù a zároveò došlo k separaci sloupcù obou tabulek. Poté již bylo potøeba zabalit dotazy dvou tabulek do závorek a spojit klauzulí 'UNION,' èímž je SQL dotaz pro zobrazení všech potøebných položek obou tabulek dokonèen (možno provést též pøes 'UNION ALL', nicménì výsledek zde bude stejný).

Pøestože oba dva SQL dotazy byly skrze klauzuli 'ORDER BY' seøazeny sestupnì podle roku a vzestupnì podle odvìtví / kategorie potravin, výstup našeho 'propojeného' dotazu není seøazen dle našeho oèekávání. Tudíž tento propojený dotaz byl ještì vnoøen do nového dotazu, ve kterém necháme zobrazit veškeré data seøazena podle našeho oèekávání:

'ORDER BY payroll_DESC, industry_branch_name ASC, price_year DESC, foodstuff_name ASC

Nyní, jak bylo již popsáno na zaèátku, staèí nad dosavadní dotaz pøidat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' která dá pokyn k vytvoøení èi nahrazení tabulky 't_roman_zavorka_project_sql_primary_final'
### VYTVOØENÍ SEKUNDÁRNÍ TABULKY
#### ÚVOD
Obdobnì jako primární tabulka byla i sekundární tabulka vytvoøena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS', která vytvoøí èi nahradí tabulku t_roman_zavorka_project_SQL_secondary_final z SQL dotazu za koneènou klauzulí 'AS.'

Zmínìná sekundární tabulka, jak bylo již uvedeno v zadání, má obsahovat doplòující pøehled HDP, GINI koeficientu a populací dalších evropských státù ve stejném období, jako primární pøehled pro ÈR. Tabulka byla vytvoøena spojením tabulek 'economies' a 'countries.' 
#### ZPÙSOB SPOJENÍ TABULEK
Protože obì dvì tabulky obsahují záznamy, které na sebe pøímo navazují skrze spoleèný sloupec 'country', pøes které lze tyto dvì tabulky propojit aniž by docházelo k nežádoucím duplicitám, byly v tomto pøípadì propojeny skrze klauzuli 'INNER JOIN.'
#### VYTVOØENÍ SQL DOTAZU
Jako první tabulka byla zvolena tabulka 'countries', a tak byla vložena do klauzule FROM. V klauzuli SELECT * zobrazujeme veškeré sloupce.

Naslednì byla skrze klauzuli 'INNER JOIN' pøipojena tabulka 'economies' pøes sloupec 'country': 

'INNER JOIN economies c ON e.country = c.country'

Protože tabulka má obsahovat data pro další evropské zemì, ale není pøesnì specifikováno které, byly vybrány všekeré zemì nacházející se na evropském kontinentì. 

Druhou podmínkou je, že záznamy mají být pro stejné období, jako primární pøehled pro ÈR; czechia_payroll: 2000–2021 a czechia_price 2006–2018. Záznamy byly tedy omezeny jen na rok 2000 a výše. Tyto podmínky byly nastaveny skrze klauzuli 'WHERE' následovnì:
 
"WHERE c.continent = 'Europe' AND e.`year`>= 2000"

Nyní, když byly obì dvì tabulky úspìšnì propojeny a záznamy byly omezeny podle naších potøeb, specifikujeme zkrze 'SELECT' klauzuli, které sloupce ve výsledné tabulce budou.

Zadáním je poskytnout data o HDP, GINI koeficientu a výši populace v dalších evropských zemích v jednotlivých letech, tyto informace najdeme v tabulce 'economies.' Z tabulky 'countries' byly zároveò nad rámec zadání pøidány základní doplòující informace o jednotlivých zemích. Ve výsledku byly vybrány následující sloupce:

* c.country - názvy zemí
* c.capital_city - hlavní mìsto
* c.region_in_world - bližší popis lokalizace státù
* c.currency_code - zkratka místní mìny
* e.`year`, - rok, pro který data platí
* e.GDP AS gdp - hrubý domácí produkt
* e.gini - gini koeficient
* e.population - údaje o vývoji populace v letech; sloupec c.populaton z druhé tabulky vývoj populace v letech nezaznamenává (je fixní), a tak nebyl vybrán.

Tímto je SQL dotaz pro vymezení dat pro sekundární tabulku dokonèen. Výsledná tabulka sestává celkem z 8 sloupcù a její rozsah je 945 záznamù. Tabulka nám prozrazuje základní informace o evropských zemích (hlavní mìsto, lokalizace na kontinentu, zkratku místní mìny) a vývoj ekonomických ukazatelù HDP a gini a populace v letech 2000–2020.

Nyní, stejnì jako u primární tabulky, staèí nad dosavadní dotaz pøidat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS' která dá pokyn k vytvoøení èi nahrazení tabulky.

### DOTAZ PRO OTÁZKU È. 1: 
Abychom zjistili, zda mzdy v jednotlivých odvìtvích stoupají èi klesají, byl vytvoøen sloupec s zobrazující rozdíly ve mzdách mezi lety pro jednotlivá odvìtví. Toho bylo dosaženo skrze pøipojení duplicitní tabulky 'pf2.'

V z naši primární tabulky 'pf' byly skrze 'SELECT' klauzuli vybrány následující sloupce:
* pf.payroll_year - roky pro které záznamy o mzdách platí
* pf.industry_branch_name - prùmyslové odvìtví
* pf.mean_salary_czk - prùmìrné mzdy

Abychom vypoèetli roèní rozdíl ve mzdách, byla k naší tabulce klauzulí 'INNER JOIN' pøipojena duplicitní tabulka 'pf2' která byla skrze vnoøený dotaz obdobným zpùsobem omezena na stejné sloupce jako v první tabulce 'pf.' 

Tabulky byly propojeny skrze spoleèné roky a shodné odvìtví: 
'ON pf.payroll_year = pf2.payroll_year + 1 AND pf.industry_branch_name = pf2.industry_branch_name'

K roku v druhé tabulce byla pøiètena +1, aby byly veškeré záznamy v ní posunuty o rok zpìt. Pro pøipojení byl zvolen INNER JOIN, aby byly odstranìny nežádoucí NULL hodnoty v druhé tabulce plynoucí z posunutí záznamù o rok zpìt u roku 2000 (rok 1999 není k dispozici). 

'INNER JOIN' zároveò zajistí, že se ve vybraných sloupcích nebudou zobrazovat 'NULL' hodnoty plynoucí z propojení tabulek 'czechia_payroll' a 'czechia_price skrze' klauzuli 'UNION' (viz tvorba primární tabulky).

Po úspìšném pøipojení dvou tabulek byly položky (sloupce) ve vnìjší 'SELECT' klauzuli nastaveny následnì:
* k prvnímu sloupci 'pf.payroll_year' byl skrze concat() pøipojen pf2.payroll_year: 'concat(pf.payroll_year," – ", pf2.payroll_year) AS time_period'
* pf.industry_branch_name
* pf.mean_salary_czk AS latter_mean_salary_czk 
* pf2.mean_salary_czk AS former_mean_salary_czk
* Výpoèet a zaokrouhlení rozdílu mezi lety: round(pf.mean_salary_czk - pf2.mean_salary_czk,2) AS annual_difference_czk

Poznámka: protože hodnoty ohlednì mezd byly zprùmìrovány a seskupeny podle let a odvìtví již pøi tvorbì primární tabulky, není nutné používat funkci avg() ani klauzuli 'GROUP BY.'

Pro zvýraznìní závìru roèního rozdílu byl skrze kaluzuli 'CASE' ještì pøidán sloupec 'annual_difference_notification', který upozoròuje, zda došlo k rùstu, poklesu èi stagnacy mezd mezi lety:

* CASE
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) > 0 THEN "increase"
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) < 0 THEN "decrease !!!"
* ELSE "stagnancy"
* END AS annual_difference_notification

Výsledná data byla seøazena vzestupnì podle názvu a sestupnì podle roku mìøení: 

'ORDER BY pf.industry_branch_name ASC, pf.payroll_year DESC'

Tímto je SQL dotaz pro zodpovìzení otázky è. 1 dokonèen a prozrazuje nám prùmìré výše mezd a meziroèní rozdíly v jednotlivých letech a odvìtvích a informaci, zda došlo k poklesu nebo zvýšení oproti loòskému roku. 

### DOTAZ PRO OTÁZKU È. 2
Protože v zadání se hovoøí o mzdách v jednotlivých letech obecnì a nikoliv podle odvìtví, bylo potøeba vypoèítat celkovou prùmìrnou mzdu ze všech odvìtví pro jednotlivé roky.

Z primární tablky 'pf' ze sekce ohlednì mezd 
byl v 'SELECT' klauzuli vybrán sloupec s údajem o roku a sloupec poèítající prùmìr z mezd zaokrouhlený na dvì desetinná místa:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk

Následnì byly veškeré hodnoty seskpeny podle jednotivých let: 

'GROUP BY pf.payroll_year'

Výsledky byly rovnìž seøazeny sestupnì podle jednotlivých let:

'ORDER BY pf.payroll_year DESC'

V tuto chvíli náš dotaz zobrazuje celkové prùmìrné mzdy sestupnì podle jednotlivých let.

Dalším krokem bylo získat potøebné prùmìrné ceny potravin podle roku a kategorie potravin. Jelikož ceny potravin byly tímto zpùsobem zprùmìrovány a seskupeny již pøi tvorbì primární, není nutné je upravovat.

Protože záznamy ohlednì potravin bylo potøeba zobrazit vedle záznamù ohlednì mezd podle spoleèných let mìøení (což stávající tabulka 'pf' neumožòuje), byla pøipojena duplicitní tabulka 'pf2.'

Zobrazení sloupcù v pøipojené tabulce 'pf2' bylo skrze vnoøený dotaz omezeno rok, prùmìrné ceny potravin, název kategorie potravin a jednotky množství:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name
* pf.price_unit

V úloze je dáno, že výpoèty mají být provedeny pro první a poslední srovnatelné období a pouze pro kategorie potravin 'mléko' a 'chléb.'

Poznámka: ohlednì mezd máme k dispozici záznamy z let 2000–2021, zatímco záznamy ohlednì cen potravin máme jen pro roky 2006–2018, prvním srovnatelným obdobím je tedy rok 2006 a posledním rok 2018.

Záznamy ve vnoøeném dotazu byly tedy skrze klauzuli 'WHERE' omezeny následovnì:

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%mléko%' OR pf.foodstuff_name LIKE '%chléb%')"

Tyto podmínky zajistí, že se zobrazí pouze záznamy v letech 2006 a 2018 a zárovìò zobrazí pouze kategorie potravin, které mají ve svém názvu 'mléko' nebo 'chléb.'

Vnoøený dotaz je tímto dokonèen a jeho spuštìním se nám zobrazí tabulka se 4 sloupci a 4 záznamy: prùmìrné ceny pro 1 kg chleba a 1 l mléka v letech 2006 a 2018.

Tabulky byly následnì propojeny skrze spoleèné roky:

'ON pf.payroll = pf2.price_year'

Pro propojení byla zvolena klauzule 'INNER JOIN' aby veškeré záznamy byly posléze omezeny jen na vybrané roky a vybrané potraviny v pøipojené pomocné tabulce 'pf2'.

Poznámka: omezením záznamù v pøipojené tabulce 'pf2' skrze vnoøený dotaz se vyraznì urychluje spuštìní celého SQL dotazu.

Do vnejší 'SELECT' klauzule byly následnì pøidány sloupce ohlednì cen potravin; uspoøádání sloupcù nyní vypadalo následovnì:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk
* pf2.foodstuff_name
* pf2.mean_price_czk
* pf2.price_unit

Protože do 'SELECT' klauzule byly pøidány sloupce týkající se cen potravin, bylo nutné rovnìž provést úpravu v 'GROUP BY' klauzuli pøidáním sloupce 'pf2.foodstuff_name', aby se záznamy seskupily prvotnì podle roku a druhotnì podle kategorie potravin:

'GROUP BY pf.payroll_year, pf2.foodstuff_name'

V tomto momentì máme k dispozici celkové prùmìrné 'hrubé' mzdy a prùmìrné ceny mléka a chleba. Abychom však mohli vypoèíst v jakém množství mùžeme dané potraviny nakoupit, potøebujeme hrubou mzdu pøepoèítat na èistou:

2018: 
* prùmìrná hrubá mzda: 32535,86 Kè
* zdravotní (4,5%) a sociální pojištìní (6,5 %): celkem 3580 Kè
* daòový základ: 32535,86*1,34 zaokrouhlíme na stovky nahoru: 43600 Kè
* daò z pøíjmu: 43600*0,15-2070(sleva): 4470 Kè
* èistá mzda: 32535,86-3580-4470 = 24 486 Kè (zaokrouhleno nahoru)

2006:
* prùmìrná hrubá mzda: 20753,79 Kè
* zdravotní (4,5 %) a sociální pojištìní (8 %): celkem 2595 Kè
* daòový základ: 20753,79-2595 = 18158,79 Kè zaokrouhlíme na stovky nahoru: 18200 Kè
* daò z pøíjmu: (18200-18200)*0,25+2715-600(sleva): 2115 Kè
* èistá mzda: 18158,79-2115 = 16 044 Kè (zaokrouhleno nahoru)

Poznámka: výpoèet je proveden pouze se základní slevou na dani. Metodický postup výpoètu èisté mzdy byl v letech 2006 a 2018 odlišný.

Nyní, když je èistá mzda pro naše dvì období vypoètena,
byly do 'SELECT' klauzule pøidány sloupce s èistou mzdou a výpoètem, kolik lze pøi daných prùmìrných èistých mzdách a cenách nakoupit daných potravin:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk
* CASE WHEN pf.payroll_year = 2018 THEN 24486 ELSE 16044 END AS mean_net_salary_czk
* pf2.foodstuff_name
* pf2.mean_price_czk
* CASE WHEN pf.payroll_year = 2018 THEN round(24486 / pf2.mean_price_czk,2) ELSE round(16044 / pf2.mean_price_czk,2 END AS possible_purchase_amount
* pf2.price_unit

Protože výsledná èistá mzda byla vložena ruènì, byly tyto novì pøidané sloupce vytvoøeny skrze klauzuli 'CASE,' aby se ke každému roku pøidružila správná èástka.

Koneèný výstup byl následnì seøazen sestupnì podle roku a vzestupnì podle názvu kategorie potravin:

'ORDER BY pf.payroll_year DESC, pf2.foodstuff_name ASC'

Tímto je SQL dotaz pro otázku è. 2 dokonèen a jeho výstupem je tabulka se 4 záznamy, která nám prozrazuje jaké byly prùmìrné hrubé a èisté mzdy a prùmìrné ceny chleba a mléka v letech 2006 a 2018 a jako množství bylo možné si tìchto potravin pøi daných mzdách koupit.

### DOTAZ PRO OTÁZKU È. 3: 
Aby bylo možné zjistit, jak se ceny potravin mezi lety vyvíjely, byly z prùmìrných roèních cen jednotlivých potravin vypoèteny roèní rozdíly; postup v tomto pøípadì byl podobný jako v úloze è. 1.

Z primární tabulky 'pf' byly skrze 'SELECT' klauzuli vybrány sloupce uvádìjící informaci ohlednì roku, názvu kategorie potravin a prùmìrné ceny:
* pf.price_year
* pf.foodstuff_name
* pf.mean_price_czk

Pro výpoèet meziroèních rozílù byla následnì pøipojena duplicitní tabulka 'pf2', kde skrze vnoøený dotaz ('SELECT') byly vybrány stejné sloupce jako v naší hlavní tabulce 'pf' a zároveò byly vyøazeny prázné záznamy, které v primární tabulce vznikly pøi její tvorbì skrze slouèení tabulek czechia_payroll a czechia_ price pøes 'UNION.':

'WHERE mean_price_czk IS NOT NULL'

Tabulky byly propojeny skrze shodné kategorie potravin a roky, kde v pøipojené tabulce 'pf2' byl pøipoèten rok navíc, èímž se záznamy v ní posunuly o rok zpìt:

'ON pf.price_year = pf2.price_year +1 AND pf.foodstuff_name = pf2.foodstuff_name

Tabulka byla pøipojena skrze 'INNER JOIN', aby byly odstranìny nežádoucí záznamy S NULL hodnotami plynoucích z posunu záznamù - záznamy pøed rokem 2006 nemáme k dispozici. Zároveò tím  byly odstranìny prázdné hodnoty vzniklé pøi tvorbì tabulky 'pf' spojením 'cp' a 'cpr' skrze 'UNION'.

Po úspìšném pøipojení tabulky 'pf2' byly ve vnejší 'SELECT' klauzuli provedeny následující zmìny v uspoøádání zobrazovaných sloupcù:
* concat(pf.price_year," – ", pf2.price_year) AS time_period
* pf.foodstuff_name,
* pf.mean_price_czk AS latter_mean_price_czk
* pf2.mean_price_czk AS former_mean_price_czk
* round((pf.mean_price_czk - pf2.mean_price_czk) / pf2.mean_price_czk*100,2) AS percentage_price_difference

Výše uvedený výbìr nám nyní zobrazuje prùmìry a meziroèní rozdíly prùmìrù cen potravin mezi lety. Záznamy byly posléze primárnì seøazeny sestupnì podle roku mìøení a poté vzestupnì podle názvu potravin v první tabulce:

'ORDER BY pf.price_year DESC, pf.foodstuff_name ASC'

Jelikož hodnoty týkající se cen potravin byly zprùmìrovány a seskupeny podle roku a kategorie potravin již pøi tvorbì primární tabulky, nebylo v tomto bodì nutné nastavovat klauzuli 'GROUP BY' (výsledky se zobrazí stejnì). 

Protože zobrazovaných záznamù je v tomto bodì velmi mnoho (celkem 315 øádkù), není snadné tato data interpretovat a udìlat z nich závìr o rychlosti zdražování èi slevòování jednotlivých potravin; z meziroèních rozdílù byl tedy pro jednotlivé potraviny nakonec vypoèten prùmìr.

Abychom mohli tento prùmìrný procentuální rozdíl vypoèítat, byl celý dosavadní dotaz vnoøen do nové klauzule 'FROM' ('pf3') a skrze novou vnìjší klauzuli 'SELECT' byl proveden výpoèet prùmìrného procentuálního rozídlu pro jednotlivé potraviny:
* pf3.foodstuff_name
* round(avg(pf3.percentage_price_difference,2) AS mean_percentage_price_difference

Aby se vypoèty seskupily podle jednotlivých potravin, bylo nutné v našem novém vnìjším dotazu nastavit klauzuli 'GROUP BY':

'GROUP BY pf3.foodstuff_name'

Koneèný výstup jsme rovnìž seøadili vzestupnì podle novì vypoèteného prùmìru a názvu potravin:

'ORDER BY mean_percentage_price_difference ASC, foodstuff_name ASC'

Tímto byla tvorba SQL dotazu pro zodpovìzení otázky è. 3 dokonèena, a jeho spuštìním dostaneme výpis potravin s jejich prùmìrným procentuálním meziroèním rozdílem, který je seøazen primárnì podle výše tohoto rozdílu a sekundárnì dle názvu jednotlivých potravin.
 
### DOTAZ PRO OTÁZKU È. 4: 
Protože v této úloze je požadavkem zjistit, zda existuje rok, ve kterém byl meziroèní nárùst cen potravin výraznì vyšší než rùst mezd (vetší než 10%), bylo potøeba vypoèítat procentuální meziroèní rozdíly celkových roèních prùmìrù pro mzdy a ceny potravin. Abychom toho dosáhli, byly pøipojeny pomocné duplicitní tabulky 'pf2' a 'pf3.'

V první ze dvou tabulek 'pf2' poslouží k výpoètu meziroèního rozdílu ve mzdách, a tak byly skrze vnoøený dotaz vybrány sloupce s informací o roku a s výpoètem prùmìrné výše mzdy:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (bude zaokrouhleno v pozdejších výpoètech)

Výsledky v tabulce byly rovnìž zbaveny prázdných záznamù a seskupeny podle jednotlivých let:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

V tomto bodì vnoøený dotaz naší tabulky zobrazuje celkové nezaokrouhlené prùmìrné výše mezd pro jednotlivé roky. Tabulka byla následnì skrze 'INNER JOIN' pøipojena podle spoleèných let, kde k pf2 byl pøièten rok navíc, aby se její záznamy posunuly o rok zpìt:

'ON pf.payroll_year = pf2.payroll_year +1' 

Skrze toto spojení byly meziroèní rozdíly ve mzdách vypoèteny ve vnìjší 'SELECT' klauzuli (bude ukázáno pozdìji).

Druhá pomocná tabulka 'pf3' poslouží k výpoètu meziroèního rozdílu v cenách potravin. Protože rozdíly ve mzdách byly vypoèteny skrze tabulky 'pf1' a 'pf2', není obdobný zpùsob výpoètu vhodný, protože by z podstaty 'UNION' propojení tabulek 'cp' a 'cpr' nastávaly problémy se zobrazením výsledkù ohlednì rozdílù cen potravin. Z tohoto dùvodu byly v této tabulce pøipraveny následující sloupce pro pozdìjší výpoèet meziroèního rozdílu v cenách potravin:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

Abychom mohli tyto sloupce zobrazit, byla ve vnoøeném dotazu pøipojena další pomocná tabulka: pf32 (pf31 je první), jejíž záznamy byly posunuty o rok zpìt:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

Tyto tabulky byly propojeny skrze 'INNER JOIN,' èímž byly odstranìny nežádoucí 'NULL' záznamy. Hodnoty byly nakonec v tabulce 'pf31' seskupeny podle roku:

'GROUP BY pf31.price_year'

Vnoøený dotaz v tabulce 'pf3' je nyní hotov a zobrazuje nám dva sloupce s nezaokrouhlenými prùmìrnými cenami potravin v jednotlivých letech, pøièemž jeden ze sploupcù má prùmìry posunuty o rok zpìt, abychom mohli pozdìji vypoèítat meziroèní rozdíly.

Pomocná tabulka 'pf3' byla poté skrze 'INNER JOIN' pøipojena k tabulce pf podle spoleèných let:

'ON pf.payroll_year = pf3.price_year'

'INNER JOIN' zde zajistí, že koneèné výstupy budou omezeny jen na spoleèná srovnatelná období cen a mezd (2006–2018).

Poznámka: tím, že je èást výpoètù (zprùmìrování a seskupení) provedeno už uvnitø pomocných tabulek je rychlost zpuštìní koneèného dotazu výraznì urychleno.

Nyní, když byly veškeré nezbytné podklady pøipraveny, byly skrze vnìjší 'SELECT' klauzuli vypoèteny meziroèní procentuální rozdíly prùmìrných mezd a cen; z tìch byl poté zpoèten také rozdíl (rozdíl v meziroèních rozdílech mezd a cena potravin):
* concat(pf.payroll_year," – ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* round(((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100),2) - round(((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100),2) AS salary_price_percentage_difference

Jelikož se je otázkou zda existuje rok, ve kterém byl meziroèní nárùst cen potravin výraznì vyšší než rùst mezd, byl rozdíl v rùstu cen a mezd vypoèten v následném formátu: pøírùst cen % - pøírùst mezd %.

Tímto je dotaz pro zodpovìzení otázky è. 4 dokonèen. jeho spuštìním se nám zobrazí výpis meziroèních procentuálních rozdílù prùmìrných cen a mezd a také rozdíly v tìchto meziroèních rozdílech mezi mzdami a cenami potravin.

### ÚLOHA È. 5
Protože v této úloze je požadavkem zjistit, zda má výška HDP a jeho zmìny vliv na vývoj mezd a cen potravin, potøebujeme vypoèítat (procentuální) meziroèní rozdíly mezd, cen potravin a HDP. Aby toto bylo možné, je potøeba pøipojit pomocné duplicitní tabulky 'pf2', 'pf3' a sekundární tabulku obsahující data ohlednì HDP 'sf.'

Protože v této úloze potøebujeme vypoèítat procentuální meziroèní rozdíly mezd a cen potravin podobnì jako v úloze è. 4. byla první èást co se týèe pøipojení pomocných tabulek 'pf2' a 'pf3' v podstatì stejná, a tak znaèná èást dotazu byla pøevzata:

Tabulka 'pf2' bude sloužit k výpoètu meziroèního rozdílu ve mzdách, tudíž byly skrze vnoøený dotaz vybrány sloupce s rokem ohlednì roku a výpoètem prùmìrné výši mzdy:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (zatím není nutno zaorkouhlovat)

Následnì byly výsledky zbaveny prázdných záznamù a seskupeny dle jednotlivých rokù:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

V tuto chvíli vnoøený dotaz pomocné tabulky zobrazuje celkové prùmìrné výše mezd pro jednotlivé roky. Tabulka byla následnì skrze 'INNER JOIN' pøipojena podle spoleèných let, kde k 'pf2' byl pøièten rok navíc, aby se její záznamy posunuly o rok zpìt:

'ON pf.payroll_year = pf2.payroll_year +1' 

Pøes toto spojení byly meziroèní rozdíly co se týèe mezd vypoèteny ve vnìjší 'SELECT' klauzuli (bude následovat pozdìji).
 
Nyní se dostáváme k tabulce 'pf3' která bude sloužit k výpoètu meziroèního rozdílu v cenách potravin. Jelikož meziroèní rozdíly ve mzdách byly spoèteny skrze tabulky 'pf' a 'pf2', nemùžeme obdobný zpùsob výpoètu použít, protože by z podstaty 'UNION' propojení tabulek 'cp' a 'cpr' nastávaly problémy se zobrazením výsledkù co se týèe rozdílù cen potravin. Tudíž byly v této tabulce pøipraveny následující sloupce pro pozdìjší výpoèet meziroèního rozdílu v cenách potravin:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

Aby bylo možné výše ukázané sloupce zobrazit, byla ve vnoøeném dotazu pøipojena další pomocná tabulka: pf32 (pf31 je první), jejíž záznamy byly posunuty o rok zpìt:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

Následnì byly tabulky spojeny skrze 'INNER JOIN,' aby byly odstranìny nežádoucí 'NULL' záznamy. Výsledky byly poté seskupeny podle roku:

'GROUP BY pf31.price_year'

Vnoøený dotaz v pomocné tabulky 'pf3' je nyní hotov a zobrazuje nám dva sloupce s nezaokrouhlenými prùmìrnými cenami potravin pro jednotlivé roky, kde jeden ze sloupcù záznamy posunuty o rok zpìt, aby bylo možno následnì vypoèítat meziroèní rozdíly.

Tabulka 'pf3' byla posléze pøes 'INNER JOIN' pøipojena k tabulce 'pf' skrze spoleèné roky:

'ON pf.payroll_year = pf3.price_year'

Poznámka: 'INNER JOIN' zde zajistí, že koneèné výstupy budou omezeny jen na spoleèná srovnatelná období cen a mezd (2006–2018).

Poznámka: obdobnì jako v pøedchozí úloze byly byla èást výpoètù (zprùmìrování a seskupení) provedeno již v rámci pomocných tabulek, aby byla rychlost zpuštìní koneèného dotazu zrychlena.

Nyní když byly duplicitní tabulky 'pf2' a 'pf3' pøipojeny, pøichází øada na pøipojení sekundární tabulky (t_roman_zavorka_project_sql_secondary_final) 'sf,' obsahující hodnoty ohlednì vývoje HDP v letech:

Protože výpoèty procentuálních meziroèních rozdílù HDP jsou pomìrnì jednoduché (není potøeba poèítat prùmìry ani data seskupovat), byly vypoèteny pøímo ve vnoøeném dotazu skrze následující sloupce:
* sf11.`year`
* round((sf11.gdp - sf12.gdp) / sf12.gdp*100,2) AS annual_percentage_hdp_difference

Pro výpoèet procentuálního meziroèního rozdílu HDP bylo však nutné prve pøipojit pomocnou duplicitní tabulku 'sf12' ('sf11' je první z tabulek):
* country
* `year`
* gdp

protože tabulka obsahuje data pro rùzné evropské zemì, byly záznamy omezeny pouze na ÈR:

"WHERE country = 'Czech republic'"

Vnitøní tabulka 'sf12' obsahující hodnoty HDP v letech pro ÈR byla posléze pøipojena k tabulce 'sf11' pøes 'INNER JOIN' skrze spoleèné roky a názvy zemì, pøièemž záznamy v 'sf12' byly posunuty o rok zpìt:

'ON sf11.`year` = sf12.`year` +1 AND sf11.country = sf12.country'

'INNER JOIN' zde zajistí vyfiltrování nežádoucích prázdných hodnot.

V tomto bodì je vnoøený dotaz pro tabulku 'sf' hotov a jeho spuštìním se nám zobrází procentuální meziroèní rozdíly HDP pro ÈR. Tabulka 'sf' byla posléze skrze 'INNER JOIN' (lze i LEFT JOIN) pøipojena k tabulce 'pf' skrze spoleèné roky:

'ON pf.payroll_year = sf.`year`'

Dále, když byly tøi podpùrné tabulky pøipojeny, byly následnì v hlavní 'SELECT' klauzuli nastaveny sloupce pro vypoèty procentuálních meziroèních rozdílù pro mzdy, ceny a hdp v letech:
* concat(pf.payroll_year," – ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* sf.gdp_annual_difference (vypoèet již pøipojené tabulce)

Aby se veškeré výpoèty seskupily podle jednotlivých let (byl zvolen sloupec 'pf.payroll_year'), byla klauzule 'GROUP BY' pro hlavní dotaz 'pf' nastavena následovnì:

'GROUP BY pf.payroll_year'

Dle stejného sloupce byly výsledné záznamy seøazeny sestupnì podle let:

'ORDER BY pf.payroll_year DESC'

V tomto bodì nám dosavadní dotaz zobrazuje tabulku která nám ukazuje vývjoj procentuálního vyjádøení rozdílù prùmìrných mezd a cen potravin a HDP mezi lety. Již v tomto zobrazení je možné vidì urèitý vztah mezi vývjem HDP a vývojem mezd a cen. Abychom však tento vztah mohli lépe posoudit, byl následnì vypoèten také pøehled o tom, jak se vyvíjí rychlost rùstu èi poklesu mezi lety - jinými slovy rozdíl z meziroèních procentuálních rozdílù.

Abychom toho dosáhli, byl náš dosavadní dotaz vnoøen do nového 'vnìjšího' dotazu do klauzule 'FROM', kde vnoøený dotaz jsme pojmenovali jako 'pf4.' Následnì byla skrze 'LEFT JOIN' pøipojna kopie našeho vnoøeného dotazu kterou jsme pojmenovali 'pf5.' Do obou dotazù 'pf4' a 'pf5' bylo vložen pomocný sloupec 'pf.payroll_year,' který použijeme pro vzájemné propojení tìchto dotazù, pøièemž záznamy 'pf5' byly posunuty o rok zpìt:

'ON pf4.payroll_year = pf5.payroll_year +1'

'LEFT JOIN' byl použit, aby nebyl vymazan záznam v prvním roce, kde chybí výsledek ve výpoètu zmìny v rychlosti rùstu.

Nyní když byly tyto tabulky propojeny, byly v hlavní 'SELECT' klauzuli vybrány následující sloupce:
* time_period
* pf4.annual_percentage_salary_difference
* pf4.annual_percentage_salary_difference-pf5.annual_percentage_salary_difference AS annual_percentage_salary_growth_difference
* pf4.annual_percentage_price_difference
* pf4.annual_percentage_price_difference-pf5.annual_percentage_price_difference AS annual_percentage_price_growth_difference
* pf4.annual_percentage_gdp_difference

Poznámka: výpoèet zmìny v rùstu HDP se neukázal být jako pøínosný a tak byl vylouèen.

Aèkoliv je výsledný dotaz ve srovnání s pøedchozími dotazy pomìrnì velký, jeho spuštìní je rychlé.

Tímto je dotaz pro otázku è. 5 dokonèen. Výsledkem je výpis procentuálního vyjádøení meziroèních zmìn ve výši mezd, cen potravin a HDP mezi lety a rovnìž rozdíly v procentuálních pøírùstcích (zmìny v rychlosti rùstu èi poklesu) mezi lety.

## VÝSLEDKY
### OTÁZKA È. 1
Rostou v prùbìhu let mzdy ve všech odvìtvích, nebo v nìkterých klesají?

Podle dosavadních dat existují pouze ètyøi odvìtví, ve kterých mzdy nepøerušovanì rostly:
* Doprava a skladování
* Ostatní èinnosti
* Zdravotní a sociální péèe
* Zpracovatelský prùmysl

Ve valnì vìtšinì námi zkoumaných odvìtví byly pozorovány poklesy rùzných výší. Vìtšinou šlo o nárazové, krátkodobé poklesy (zejména v roce 2013), po nichž však mzdy opìt zaèaly stoupat:
* Administrativní a podpùrné èinnosti
* Èinnosti v oblasti nemovitostí
* Informaèní a komunikaèní èinnosti	
* Penìžnictví a pojišovnictví	
* Profesní, vìdecké a technické èinnosti	
* Tìžba a dobývání
* Ubytování, stravování a pohostinství
* Velkoobchod a maloobchod; opravy a údržba motorových vozidel: 
* Výroba a rozvod elektøiny, plynu, tepla a klimatiz. vzduchu 
* Zásobování vodou; èinnosti související s odpady a sanacemi

Pozorujeme i nìkolik odvìtví, u nichž lze i mimo jiné postøehnout postupný pokles stoupání a následné snižování mezd na konci období, pro které jsou data k dispozici; tedy nemusí se jednat jen o nárazový pokles, ale mùže dojít k delšímu poklesu ve výši mezd v budoucích letech:
* Kulturní, zábavní a rekreaèní èinnosti
* Stavebnictví 	
* Veøejná správa a obrana; povinné sociální zabezpeèení
* Vzdìlávání
* Zemìdìlství, lesnictví, rybáøství
### OTÁZKA È. 2
Kolik je možné si koupit litrù mléka a kilogramù chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

V prvním srovnatelném období, tedy v roce 2006 byla prùmìrná èistá mzda 16 044 Kè a Kg chleba stál v prùmìru 16.12 Kè a l mléka 14.44 Kè. 

V druhém srovnatelném období v roce 2018 dosahovala prùmìrná èistá mzda 24 486 Kè. Prùmìrná cena za Kg chleba byla 24.24 Kè a za l mléka 19.82 Kè 

Za danou výplatu bylo v roce 2006 možno tedy nakoupit 995.29 Kg chleba a 1111.08 l mléka, zatímco za výplatu v roce 2018 to bylo 1010.15 Kg chleba a 1235.42 l mléka; tudíž v druhém srovnatelném období bylo možno tìchto daných potravin nakoupit více.

### OTÁZKA È. 3
Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroèní nárùst)?

Ve výsledcích mùžeme vidìt, že v prùmìru ceny valné vìtšiny potravin zdražují; výjimkou jsou 'krystalový cukr' a 'rajská jablka èervená kulatá,' které naopak v prùmìru roènì slevòují o -1.92 % a -0.74 %. 

Podle dosavadních dat jsou tedy hypoteticky "nejpomaleji zdražujícími" potravinami 'Banány žluté', které v prùmìru roènì zdražují jen o 0,81 % a za nimi Vepøová peèenì s kostí 0.99 % roènì. 

Naopak v prùmìru nejrychleji se zdražující potravinou se zdají být 'Papriky': 7.29 % roènì a dále Máslo: 6.68 % 

### OTÁZKA È. 4
Existuje rok, ve kterém byl meziroèní nárùst cen potravin výraznì vyšší než rùst mezd (vìtší než 10 %)?

Z dosavadních výsledkù vychází najevo, že nejvìtší nárùst cen oproti rùstu mezd byl zaznamenán mezi lety 2013–2012, kde ceny vzrostly o 5,1 % zatímco mdzy naopak klesly o -1,56 %, celkový rozdíl je tedy 6.66 % ve prospìch zdražování. V žádném roce tedy rozdíly nedosáhly ani 10 %. 

Naopak nejnižší, respektive nejvìtší rozdíl ve prospìch mezd byl zaznamenán mezi lety 2009–2008, kde mdzy vzrostly o 3,16 % zatímco ceny potravin klesly o -6,42 % a celkový rozdíl je tedy -9,58 % ve prospìch mezd.

V období 2010–2009 bylo navýšování mezd ve stejné míøe jako zdražování potravin: 1.95 %.

Dále mùžeme také postøehnout, že v tìchto datech je rok 2013 jediný rok, kdy prùmìrný roèní procentuální rozdíl mezd dosáhl negativních hodnot; toto podporují také výsledky v úloze è. 1 kde ve valné vìtšinì odvìtví byl v tomto roce zaznamenán pokles v prùmìrných mzdách.

### OTÁZKA È. 5
Má výška HDP vliv na zmìny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výraznìji v jednom roce, projeví se to na cenách potravin èi mzdách ve stejném nebo násdujícím roce výraznìjším rùstem?

Podívámeli se na zmìny HDP v letech, mùžeme vidìt, že po vìtšinu let HDP roste, výjimkou jsou však období mezi lety 2009–2008 kde byl zaznamenán pomìrnì výrazný pokles -4.66 % a také menší poklesy -0,79 % a -0,05 % v obdobích 2012–2011 a 2013–2012.

Porovámeli vývoj HDP a vývoj cen potravin, mùžeme v nìkterých bodech postøehnout, že se ceny vyvíjejí podobnì jako HDP, zejména v letech 2007, 2008, a 2009, kde rust HDP zpomaluje a poté klesá (-4.66 %) a stejnì tak ceny potravin (-6,42 %). Posléze v letech 2010 a 2011, když HDP opìt zaèíná rùst, rostou rovnìž i ceny.

Zmìna však nastává v obdobích 2012–2011 a 2013–2012, kde HDP opìt avšak mírnìji klesá (-0,05 % a -0,79 %) -> prve zaèíná klesat pøírùst cen potravin a až v obdobích 2015–2014 a 2016–2015 dochází k poklesu cen potravin (-0,55 % a -1,19 %), zatímco HDP touto dobou již zase stoupá. Po tìchto opoždìných poklesech ceny potravin opìt zaèínají rùst, nicménì rychlost rùstu zvláštnì osciluje.
­
Podobnì jako u cen potravin lze u mezd vidìt urèitou reakci na vývoj HDP, avšak se nezdá být tolik viditelná. Mzdy až na období 2013–2012 neusále rostou.

V období 2009–2008, kdy byl nejvìtší pokles v HDP (-4.66 %), došlo u mezd v tomto a následujícím období pouze k poklesu rychlosti rùstu (-4,71 % a -1,21 %), která posléze zase zaèala zvedat. Pokles ve výši mezd byl pozorován až v období 2013–2012, kdy mzdy poklesly o -1,56 %, kdy v tomto a pøedcházejícím obdobím byly pozorovány v podstatì jen mírné poklesy v HDP (-0,05 % a -0,79 %) a je tedy otázkou, zda tento pokles ve mzdách byl zpùsoben tìmito dvìma mírnìjšími poklesy nebo zda jde o zpoždìnou reakci na silný pokles HDP z období 2009–2008. V následujících letech, kdy HDP opìt zaèalo stoupat a zrychlovat v rùstu, zaèaly zrychlovat v rùstu i mdzy.

Z dosavatních dat se zdá, že míra rùstu èi poklesu HDP ovlivòuje vývoj cen a mezd, tedy pokud HDP výraznì klesne èi vzroste, je velmi pravdìpodobné, že dojde k poklesu èi vzrùstu ve mzdách a cenách potravin nebo alespoò ke zmìnì rychlosti rùstu èi klesání, avšak tento efekt mùže nastat až po urèité dobì. 

