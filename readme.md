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

"WHERE cp.value_type_code = 5958 (zji�t�no z ��seln�ku 'czechia_payroll_value_type').

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
Obdobn� jako prim�rn� tabulka byla i sekund�rn� tabulka vytvo�ena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS', kter� vytvo�� �i nahrad� tabulku t_roman_zavorka_project_SQL_secondary_final z SQL dotazu za kone�nou klauzul� 'AS.'

## V�SLEDKY





