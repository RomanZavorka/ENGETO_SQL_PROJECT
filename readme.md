# SQL PROJEKT

## ZAD�N�
zad�n� projektu
## ANAL�ZA

## POSTUP
### VYTVO�EN� PRIM�RN� TABULKY
#### �VOD
Prim�rn� tabulka t_roman_zavorka_project_sql_primary_final obsahuj�c� data z obou tabulek byla vytvo�ena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kde 'CREATE' tabulku vytv��� a v p��pad�, �e tabulka s t�mto n�zvem ji� existuje, aktivuje se p��kaz 'REPLACE,' kter� st�vaj�c� tabulku nahrad� novou, co� v p��pad� pot�eby umo��uje tabulku snadno upravovat. Tabulka byla v na�em p��pad� vytvo�ena skrze SQL dotazu za klauzul� 'AS.'
 
Podstatou v��e zm�n�n� tabulky je slou�en� tabulek czechia_payroll a czechia_price s jejich n�vazn�mi tabulkami (��seln�ky) do jedn� tabulky skrze stejn� porovnateln� obdob�, tedy spole�n� roky, ze kter� bude mo�n� �erpat data ohledn� mezd a cen potravin za �eskou republiku pro pln�n� n�sleduj�c�ch �loh - v�deck�ch ot�zek.
#### ZP�SOB SPOJEN� TABULEK
Proto�e data dvou tabulek na sebe krom� spole�n�ch let nemaj� p��mou n�vaznost, zp�sob propojen� skrze klauzuli 'JOIN' nen� vhodn�, proto�e v�echny z�znamy z jedn� tabulky by se nav�zaly na z�znamy se shodn�m rok v tabulce druh�, ��m� by do�lo ke zbyte�n�mu nadbyt� (duplicit�m) z�znam�, tud� bylo slou�en� tabulek provedeno skrze klauzuli 'UNION' (mo�no prov�st t� p�es 'UNION ALL', nicm�n� v�sledek zde bude stejn�).

Vytvo�en� v�sledn� tabulky bylo provedeno skrze slou�en� dvou samostatn�ch SQL dotaz� zu�uj�c� data na pot�ebn� minimum; jeden pro tabulku czechia_payroll a druh� pro tabulku czechia_price.
#### DOTAZ PRO TABULKU czechia_payroll

Do klauzule 'FROM' byl vlo�en n�zev p��slu�n� tabulky czechia_payroll (cp), ze kter� byla data nahr�v�na.
V klauzuli nyn� zobrazujeme ve�ker� sloupce: SELECT *.

Skrze zklauzuli 'JOIN' byla p�ipojena men�� tabulka czechia_payroll_industry_branch (cpib) s ��seln�kem pro identifikaci jednotliv�ch pr�myslov�ch odv�tv� ze sloupce cp.industry_branch_code. Tabulka byla p�ipojena n�sledn�:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

Pot�ebn� hodnoty ohledn� v��e pr�m�rn�ch mezd se nach�zej� v sloupci 'value', kde mimo jin� najdeme tak� hodnoty o 'pr�m�rn�ch po�tech zam�stnan�ch osob,' kter� nejsou pot�ebn�, tud� skrze klauzuli WHERE byly z�znamy omezeny pouze na hodnoty t�kaj�c� se v��e mezd: 

'WHERE cp.value_type_code = 5958'(zji�t�no z ��seln�ku 'czechia_payroll_value_type').

Rovn� byly zaznamen�ny z�znamy, kter� maj� ve sloupci 'industry_branch_code' hodnoty 'NULL,' a tak nev�me, do kter�ho odv�tv� spadaj�. Proto�e informace o odv�tv� je pro n�s relevantn�, byly tyto hodnoty t� vylou�eny p�id�n�m dal�� podm�nky: 

'AND cp.industry_branch_code IS NOT NULL.'

Poznamka: Je mo�no rovn� p�idat podm�nku 'AND cp.value IS NOT NULL', nicm�n� v sloupci 'value' ��dn� pr�zdn� z�znamy o v��i mezd nalezeny nebyly, a tak tato podm�nka p�id�na nebyla.

V tuto chv�li jsou zobrazov�ny ve�ker� sloupce a z�znamy jsou omezeny pouze na z�znamy o v��i mezd v jednotliv�ch letech v jednotliv�ch kvart�lech v jednotliv�ch odv�tv�ch. Data v tomto rozlo�en� jsou v�ak st�le velmi obs�hl� a tak je m��eme v�razn� zmen�it zpr�m�rov�n�m fc� avg() a adekv�tn�m seskupen�m klauzul� GROUP BY. V na�em p��pad� byly z�znamy seskupeny podle jednotliv�ch let m��en� a druhotn� podle pr�myslov�ho odv�tv�:

'GROUP BY cp.payroll_year, cpib.name'

Toto zpr�m�rov�n� a seskupen� ve�ker�ch z�znam� n�m krom� zmen�en� tabulky tak� v�znam� pom��e i p�i �e�en� n�sleduj�c�ch �loh, proto�e takto nastaven� data jsou snadn�ji interpretov�na 
a v n�kter�ch p��padech u� ani nen� nutn� pou��t fci avg ().

Krom� z�znam� byly provedena omezen� tak� v po�tu sloupc�, kde v
ve v SELECT klauzuli byly ve fin�le vybr�ny pouze t�i d�le�it� sloupce:

* cp.payroll_year - obsahuje informace o obdob�, pro kter� jednotliv� z�znamy plat�(n�zev sloupce n�m vyhovuje tak jak je).

* cpib.name AS industry_branch_name - sloupec s n�zvy pr�myslov�ch odv�tv� z p�ipojen� tabulky (��seln�ku)'czechia_payroll_industry_branch', sloupec 'cp.industry_branch_code' u� tedy nepot�ebujeme.

* round(avg(cp.value),2) AS mean_salary_czk - dosavadn� sloupec 'cp.value' obsahuj�c� hodnoty o v��i hrub�ch mezd byl zpr�m�rov�n a zaokrouhlen na dv� desetinn� m�sta skrze funkce avg() a round(). Proto�e v��e mezd je vyj�d�ena v �esk�ch korun�ch, byla do n�zvu p�id�na zkratka 'czk.'	

Nyn� kdy� kdy� byl byly nastaveny 'aliasy', m��eme v klauzuli GROUP BY nahradit 'cpib.name' n�zvem 'industry_branch_name':

'GROUP BY cp.payroll_year, industry_branch_name'

Kone�n� v�stup t�to tabulky byl pot� skrze klauzuli ORDER BY se�azen sestupn� podle roku a vzestupn� podle n�zvu pr�myslov�ho odv�tv�: 

'ORDER BY cp.payroll_year DESC, industry_branch_name ASC'

V tomto bod� je v�stupem tabulka se t�emi sloupci: payroll_year, industry_branch_name a mean_salary_czk; rozsah tabulky je celkem 418 ��dk�. Tabulka n�m ukazuje pr�m�rn� mzdy v jednotliv�ch letech v jednotliv�ch odv�tv�ch a je se�azena sestupn� podle let a vzestupn� podle n�zvu odv�tv�.
#### DOTAZ PRO TABULKU czechia_price
Do klauzule 'FROM' vlo�en n�zev tabulky czechia_price (cpr)
a skrze SELECT * byly zobrazeny ve�chny sloupce.

Hodnoty ohledn� cen potravin se nach�zej� v sloupci 'value', (stejn� pojmenov�n jako v tabulce czechia_payroll), p�i�em� potraviny josu identifkov�ny pouze v sloupc 'category_code'.

Abychom jednozna�n� identifikovali jednotliv� kategorie potravin, byla p�pojena skrze klauzuli 'JOIN' tabulka czechia_price_category (cpc) obsahuj�c� ��seln�k. Tabulka byla p�ipojena n�sledovn�:

'czechia_price_category (cpc) ON cp.category_code = cpc.code'

Krom� sloupce 'region_code' jsou z�znamy kompletn� a neobsahuj� 'NULL' hodnoty. Proto�e data v n�sleduj�c�ch �loh�ch budou zpracov�v�na celkov� pro �R, nen� informace o kraji v sloupci 'region_code' d�le�it�. Omezen� rozsahu z�znamu v t�to tabulce nen� nutn�.

N�sledn� byly v klauzuli 'SELECT' byly vybr�ny pot�ebn� sloupce.
Jako prvn� pot�ebujeme o roku, do kter�ho jednotliv� z�znamy pat��. V tabulce jsou k dispozici dva sloupce ud�v�j�c� tuto informaci: 'date_from' a 'date_to.' Z�znamy jsou ve form�tu, kde je uvedeno cel� datum a �as. Proto�e pro propojen� s prvn� tabulkou pot�ebujeme zn�t pouze infomaci o roku, pou�ijeme fci year(). 

Skrze dotaz: 'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)' zj�st�me, �e oba datmu jsou v�dy ve stejn�m roce, a tak je mo�no pou��t kter�koliv z t�chto dvou sloupc�; v na�em p��pad� byl pou�it sloupec date_from: 

* year(date_from) AS price_year

* Jako dal�� byl zvolen sloupec z p�ipojen� tabulky czechia_price_category (cpc) ud�vaj�c� n�zev kategorie potravin: cpc.name AS foodstuff_name - (tud� sloupec cpr.category_code ji� nad�le nepot�ebujeme).

* Obdobn�m zp�sobem provedeme zpr�m�rov�n� a zaokrouhlen� hodnot v sloupci cpr.value jako v tabulce czechia_payroll: round(avg(cpr.value),2) AS mean_price_czk.

* Posledn�m sloupcem t�to tabulky vznikl slou�en�m sloupc� 'cpc.price_value' a 'cpc.price_unit' z p�ipojen� tabulky czechia_price_category (cpc) funkc� concat(): concat(cpc.price_value," ",cpc.price_unit) AS price_unit.
		Tento sloupec ud�v� mno�stv�, ke kter�mu se v�ou ceny jednotliv�ch kategori� potravin (nap�. cena za 0,5 l piva).

Obdobn� jako v tabulce czechia_payroll je i zde velmi mnoho z�znam�, a tak byly i zde byly hodnoty o cen�ch potravin zpr�m�rov�ny a seskupeny skrze klauzuli 'GROUP BY' podle roku a
kategorie potravin: 

'GROUP BY price_year, foodstuff_name'

V�stup na�eho dotazu pro tuto tabulku byl n�sledn� skrze klauzuli ORDER BY se�azen sestupn� podle roku a vzestupn� podle kategorie potravin: 

'ORDER BY price_year DESC, foodstuff_name ASC'

Dosavadn� v�stup je tedy slo�en ze sloupc� 'price_year', 'foodstuff_name', 'mean_price_czk' a 'price_unit' s rozsahem celkem 342 ��dk�. Jednotliv� z�znamy n�m prozrazuj�, jak� jsou pr�m�rn� ceny jednotliv�ch potravinov�ch kategori� v jednotliv�ch letech pro dan� mno�stv� a jsou se�azeny sestupn� podle let a vzestupn� podle n�zvu potravin.
#### SPOJEN� DOTAZ� 
Nyn� kdy� je rozsah na�ich dvou tabulek p�ipraven, m��eme postupn� p�istoupit k jejich spojen� skrze klauzuli 'UNION.' 

Prvn�m probl�mem kter� br�nil spojen� dvou tabulek byl nestejn� po�et sloupc� (3 na 4). Mimo j�ne jsem se rozhodl, �e data z obou tabulek chci m�t v separovan�ch sloupc�ch. toho bylo dosa�eno p�id�n�m 'null' sloupc� do obou na�ich tabulek, p�i�em� nov� p�idan� 'null' sloupce v horn� tabulce ponesou n�zvy sloupc� spodn� tabulky a 'null' sloupce ve spodn� tabulce budou za�len�ny do prvn�ch t�i sloupc� prvn� tabulky:

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

T�mto byl vy�e�en probl�m s nestejn�m po�tem sloupc� a z�rove� do�lo k separaci sloupc� obou tabulek. Pot� ji� bylo pot�eba zabalit dotazy dvou tabulek do z�vorek a spojit klauzul� 'UNION,' ��m� je SQL dotaz pro zobrazen� v�ech pot�ebn�ch polo�ek obou tabulek dokon�en.

Nyn�, jak bylo ji� pops�no na za��tku, sta�� nad dosavadn� dotaz p�idat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kter� d� pokyn k vytvo�en� �i nahrazen� tabulky 't_roman_zavorka_project_sql_primary_final'
### VYTVO�EN� SEKUND�RN� TABULKY
#### �VOD
Obdobn� jako prim�rn� tabulka byla i sekund�rn� tabulka vytvo�ena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS', kter� vytvo�� �i nahrad� tabulku t_roman_zavorka_project_SQL_secondary_final z SQL dotazu za kone�nou klauzul� 'AS.'

Zm�n�n� tabulka byla vytvo�ena spojen�m tabulek 'economies' a 'countries', kter� obsahuj� dodate�n� informace o r�zn�ch zem�ch sv�ta. Proto�e �lohou je vytvo�en� tabulky obsahuj�c� dodate�n� data o dal��ch evropsk�ch st�tech, ale z�rove� nechceme tabulku m�t p��li� obs�hlou, zam���me se pouze na �R a sousedn� zem�.
#### ZP�SOB SPOJEN� TABULEK
Proto�e ob� dv� tabulky obsahuj� z�znamy, kter� na sebe p��mo navazuj� skrze spole�n� sloupec 'country', p�es kter� lze tyto dv� tabulky propojit ani� by doch�zelo k ne��douc�m duplicit�m, byly v tomto p��pad� propojeny skrze klauzuli 'JOIN.'
#### VYTVO�EN� SQL DOTAZU
Jako prvn� tabulka byla zvolena tabulka 'economies', a tak byla vlo�ena do klauzule FROM. V klauzuli SELECT * zobrazujeme ve�ker� sloupce.

Nasledn� byla skrze klauzuli 'JOIN' p�ipojena tabulka 'countries': 

'JOIN countries c ON e.country = c.country'

Proto�e tabulka m� obsahovat data pro dal�� evropsk� zem� a pro stejn� obdob�, jako prim�rn� p�ehled pro �R (2000�2021), omez�me data n�sleduj�c� podm�nkou:
 
'WHERE e.`year`>= 2000 AND c.continent = 'Europe'

Nyn�, kdy� byly ob� dv� tabulky �sp�n� propojeny a z�znamy byly omezeny pouze vybran� zem�, specifikujeme zkrze 'SELECT' klauzuli, kter� sloupce ve v�sledn� tabulce budou.

Zad�n�m je poskytnout data o HDP, GINI koeficientu a v��i populace v dal��ch evropsk�ch zem�ch v jednotliv�ch letech; tyto data najdeme v tabulce 'economies':

* e.country - n�zvy zem�
* e.`year`, - rok, pro kter� data plat�
* e.GDP AS hdp - (hrub� dom�c� produkt)
* e.gini - gini koeficient
* e.population - �daje o v�voji populace v letech; sloupec c.populaton z druh� tabulky v�voj populace v letech nezaznamen�v� (je fixn�), a tak nebyl vybr�n.

Z tabulky 'countries' byly z�rove� nad r�mec zad�n� p�id�ny dopl�uj�c� informace o jednotliv�ch zem�ch:

Z tabulky 'countries':
* c.capital_city 
* c.continent
* c.region_in_world - bli��� popis lokalizace st�t�
* c.currency_code

T�mto je SQL dotaz pro vymezen� dat pro sekund�rn� tabulku dokon�en. V�sledn� tabulka sest�v� celkem z 9 sloupc� a jej� rozsah je 945 z�znam�.

Nyn�, stejn� jako u prim�rn� tabulky, sta�� nad dosavadn� dotaz p�idat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS' kter� d� pokyn k vytvo�en� �i nahrazen� tabulky.

### �LOHA �. 1: 
#### V�PO�ET RO�N�CH ROZD�L� VE MZD�CH
Abychom zjistili, zda mzdy v jednotliv�ch odv�tv�ch stoupaj� �i klesaj�, byl vytvo�en sloupec s obsahuj�c� rozd�ly ve mzd�ch mezi lety pro jednotliv� odv�tv�. Toho bylo dosa�eno skrze p�ipojen� duplicitn� tabulky

V z na�i prim�rn� tabulky (pf) byly skrze 'SELECT' klauzuli vybr�ny n�sleduj�c� sloupce:
* pf.payroll_year - roky pro kter� z�znamy o mzd�ch plat�
* pf.industry_branch_name - pr�myslov� odv�tv�
* pf.mean_salary_czk - pr�m�rn� mzdy

Abychom vypo�etli ro�n� rozd�l ve mzd�ch, byla k na�� tabulce klauzul� 'INNER JOIN' p�ipojena duplicitn� tabulka (pf2)kter� byla skrze vno�en� dotaz obdobn�m zp�sobem omezena na stejn� sloupce jako v prvn� tabulce. 

Tabulky byly propojeny skrze spole�n� roky a shodn� odv�tv�: 
'ON pf.payroll_year = pf2.payroll_year + 1 AND pf.industry_branch_name = pf2.industry_branch_name'

K roku v druh� tabulce byla p�i�tena +1, aby byly ve�ker� z�znamy v n� posunuty o rok zp�t. Pro p�ipojen� byl zvolen INNER JOIN, aby byly odstran�ny ne��douc� NULL hodnoty v druh� tabulce plynouc� z posunut� z�znam� o rok zp�t u roku 2000 (rok 1999 nen� k dispozici). 

'INNER JOIN' z�rove� zajist�, �e se ve vybran�ch sloupc�ch nebudou zobrazovat 'NULL' hodnoty plynouc� z propojen� tabulek czechia_payroll a czechia_price skrze klauzuli 'UNION' (viz tvorba prim�rn� tabulky).

Po �sp�n�m p�ipojen� dvou tabulek byly polo�ky (sloupce) ve vn�j�� 'SELECT' klauzuli nastaveny n�sledn�:
* k prvn�mu sloupci 'pf.payroll_year' byl skrze concat() p�ipojen pf2.payroll_year: 'concat(pf.payroll_year," � ", pf2.payroll_year) AS time_period'
* pf.industry_branch_name
* pf.mean_salary_czk AS latter_mean_salary_czk 
* pf2.mean_salary_czk AS former_mean_salary_czk
* V�po�et a zaokrouhlen� rozd�lu mezi lety: round((pf.mean_salary_czk - pf2.mean_salary_czk),2) AS annual_difference_czk

Pozn�mka: proto�e hodnoty ohledn� mezd byly zpr�m�rov�ny a seskupeny podle let a odv�tv� ji� p�i tvorb� prim�rn� tabulky, nen� nutn� pou��vat funkci avg() ani klauzuli GROUP BY.

Pro zv�razn�n� z�v�ru ro�n�ho rozd�lu byl skrze kaluzuli CASE vytvo�en sloupec 'annual_difference_notification', kter� upozor�uje, zda do�lo r�stu, poklesu �i stagnacy mezd mezi lety:

* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) > 0 THEN "increase"
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) < 0 THEN "decrease !!!"
* ELSE "stagnancy"

V�sledn� data byla se�azena vzestupn� podle n�zvu a sestupn� podle roku m��en�: 

'ORDER BY pf.industry_branch_name ASC, pf.payroll_year DESC'

T�mto je SQL dotaz pro ot�zku �. 1 dokon�en.
### �LOHA �. 2
#### V�PO�ET PR�M�RU MEZD  
Proto�e v zad�n� se hovo�� o mzd�ch v jednotliv�ch letech obecn� a nikoliv podle odv�tv�, bylo pot�eba vypo��tat celkovou pr�m�rnou mzdu ze v�ech odv�tv� pro jednotliv� roky.

Z prim�rn� tablky (pf) ze sekce ohledn� mezd 
byl v 'SELECT' klauzuli vybr�n sloupec s �dajem o letech a sloupec po��taj�c� pr�m�r zaokrouhlen� na dv� desetinn� m�sta:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS total_mean_salary_czk

N�sledn� byly ve�ker� hodnoty seskpeny podle jednotiv�ch let: 'GROUP BY pf.payroll_year'.
V�sledky byly rovn� se�azeny sestupn� podle jednotliv�ch let:
'ORDER BY pf.payroll_year DESC'

V tuto chv�li n� dotaz zobrazuje celkov� pr�m�rn� mzdy sestupn� podle jednotliv�ch let.

Dal��m krokem bylo z�skat pot�ebn� pr�m�rn� ceny potravin podle roku a kategorie potravin. Jeliko� ceny potravin byly t�mto zp�sobem zpr�m�rov�ny a seskupeny ji� p�i tvorb� prim�rn�, nen� nutn� je upravovat.

Proto�e z�znamy ohledn� potravin bylo pot�eba zobrazit vedle z�znam� ohledn� mezd podle spole�n�ch let m��en� (co� st�vaj�c� tabulka pf neumo��uje), byla p�ipojena duplicitn� tabulka (pf2).

Z�znamy v p�ipojen� tabulce byly skrze vno�en� dotaz omezeny rok, pr�m�rn� ceny potravin, n�zev kategorie potravin a jednotky mno�stv�:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name
* pf.price_unit

Z�znamy ve vno�en�m dotazu z�rove� omez�me na prvn� a srovnateln� obdob� a na vybran� kategorie potravin: 'chl�b' a 'ml�ko:'

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%ml�ko%' OR pf.foodstuff_name LIKE '%chl�b%'"

Pozn�mka: tabulka czechia_payroll obsahuje z�znamy z let 2000�2021 a tabulka czechia_price 2006�2018, prvn�m srovnateln�m obdob�m je tedy rok 2006 a posledn�m je rok 2018.

Vno�en� dotaz je t�mto dokon�en a jeho spu�t�n�m se n�m zobraz� tabulka se 4 sloupci a 4 z�znamy: pr�m�rn� ceny pro 1 kg chleba a 1 l ml�ka v letech 2006 a 2018.

Tabulka byla n�sledn� propojena skrze spole�n� roky:

'ON pf.payroll = pf2.price_year'

Pro propojen� byla zvolena klauzule 'INNER JOIN' aby ve�ker� z�znamy byly omezeny jen na vybran� roky a vybran� potraviny v p�ipojen� pomocn� tabulce.

Pozn�mka:  

#### V�PO�ET V݊E MO�N�HO N�KUPU POTRAVIN
## V�SLEDKY
### �LOHA �. 1
#### Z�V�R

Podle dosavadn�ch dat existuj� pouze �ty�i odv�tv�, ve kter�ch mzdy nep�eru�ovan� rostly:
* Doprava a skladov�n�
* Ostatn� �innosti
* Zdravotn� a soci�ln� p��e
* Zpracovatelsk� pr�mysl

Ve valn� v�t�in� n�mi zkouman�ch odv�tv� byly pozorov�ny poklesy r�zn�ch v���. V�t�inou �lo o n�razov�, kr�tkodob� poklesy (zejm�na v roce 2013), po nich� v�ak mzdy op�t za�aly stoupat:
* Administrativn� a podp�rn� �innosti
* �innosti v oblasti nemovitost�
* Informa�n� a komunika�n� �innosti	
* Kulturn�, z�bavn� a rekrea�n� �innosti
* Pen�nictv� a poji��ovnictv�	
* Profesn�, v�deck� a technick� �innosti	
* T�ba a dob�v�n�
* Ubytov�n�, stravov�n� a pohostinstv�
* Velkoobchod a maloobchod; opravy a �dr�ba motorov�ch vozidel: 
* V�roba a rozvod elekt�iny, plynu, tepla a klimatiz. vzduchu 

Pozorujeme i n�kolik odv�tv�, u nich� lze post�ehnout postupn� pokles stoup�n� a n�sledn� sni�ov�n� mezd na konci obdob�, pro kter� jsou data k dispozici; tedy nemus� se jednat jen o n�razov� pokles, ale m��e doj�t k del��mu poklesu ve v��i mezd v budouc�ch letech:

* Stavebnictv� 	
* Ve�ejn� spr�va a obrana; povinn� soci�ln� zabezpe�en�
* Vzd�l�v�n�
* Z�sobov�n� vodou; �innosti souvisej�c� s odpady a sanacemi
* Zem�d�lstv�, lesnictv�, ryb��stv�

#### DETAILN� ROZBOR




