# SQL PROJEKT
## ZAD�N�
### �VOD DO PROJEKTU
"Na va�em analytick�m odd�len� nez�visl� spole�nosti, kter� se zab�v� �ivotn� �rovn� ob�an�, jste se dohodli, �e se pokus�te odpov�d�t na p�r definovan�ch v�zkumn�ch ot�zek, kter� adresuj� dostupnost z�kladn�ch potravin �irok� ve�ejnosti. Kolegov� ji� vydefinovali z�kladn� ot�zky, na kter� se pokus� odpov�d�t a poskytnout tuto informaci tiskov�mu odd�len�. Toto odd�len� bude v�sledky prezentovat na n�sleduj�c� konferenci zam��en� na tuto oblast.

Pot�ebuj� k tomu od v�s p�ipravit robustn� datov� podklady, ve kter�ch bude mo�n� vid�t porovn�n� dostupnosti potravin na z�klad� pr�m�rn�ch p��jm� za ur�it� �asov� obdob�.

Jako dodate�n� materi�l p�ipravte i tabulku s HDP, GINI koeficientem a populac� dal��ch evropsk�ch st�t� ve stejn�m obdob�, jako prim�rn� p�ehled pro �R.

### DATOV� SADY KTER� JE MO�N� POU��T PRO Z�SK�N� VHODN�HO DATOV�HO PODKLADU

#### PRIM�RN� TABULKY:

1. czechia_payroll � Informace o mzd�ch v r�zn�ch odv�tv�ch za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R.
2. czechia_payroll_calculation � ��seln�k kalkulac� v tabulce mezd.
3. czechia_payroll_industry_branch � ��seln�k odv�tv� v tabulce mezd.
4. czechia_payroll_unit � ��seln�k jednotek hodnot v tabulce mezd.
5. czechia_payroll_value_type � ��seln�k typ� hodnot v tabulce mezd.
6. czechia_price � Informace o cen�ch vybran�ch potravin za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R.
7. czechia_price_category � ��seln�k kategori� potravin, kter� se vyskytuj� v na�em p�ehledu.
#### ��SELN�KY SD�LEN�CH INFORMAC� O �R:
1. czechia_region � ��seln�k kraj� �esk� republiky dle normy CZ-NUTS 2.
2. czechia_district � ��seln�k okres� �esk� republiky dle normy LAU.
#### DODATE�N� TABULKY:
1. countries - V�emo�n� informace o zem�ch na sv�t�, nap��klad hlavn� m�sto, m�na, n�rodn� j�dlo nebo pr�m�rn� v��ka populace.
2. economies - HDP, GINI, da�ov� z�t�, atd. pro dan� st�t a rok.
#### V�ZKUMN� OT�ZKY
1. Rostou v pr�b�hu let mzdy ve v�ech odv�tv�ch, nebo v n�kter�ch klesaj�?
2. Kolik je mo�n� si koupit litr� ml�ka a kilogram� chleba za prvn� a posledn� srovnateln� obdob� v dostupn�ch datech cen a mezd?
3. Kter� kategorie potravin zdra�uje nejpomaleji (je u n� nejni��� percentu�ln� meziro�n� n�r�st)?
4. Existuje rok, ve kter�m byl meziro�n� n�r�st cen potravin v�razn� vy��� ne� r�st mezd (v�t�� ne� 10 %)?
5. M� v��ka HDP vliv na zm�ny ve mzd�ch a cen�ch potravin? Neboli, pokud HDP vzroste v�razn�ji v jednom roce, projev� se to na cen�ch potravin �i mzd�ch ve stejn�m nebo n�sduj�c�m roce v�razn�j��m r�stem?

#### V�STUP PROJEKTU

Pomozte koleg�m s dan�m �kolem. V�stupem by m�ly b�t dv� tabulky v datab�zi, ze kter�ch se po�adovan� data daj� z�skat. Tabulky pojmenujte t_{jmeno}_{prijmeni}_project_SQL_primary_final (pro data mezd a cen potravin za �eskou republiku sjednocen�ch na toto�n� porovnateln� obdob� � spole�n� roky) a t_{jmeno}_{prijmeni}_project_SQL_secondary_final (pro dodate�n� data o dal��ch evropsk�ch st�tech).

D�le p�ipravte sadu SQL, kter� z v�mi p�ipraven�ch tabulek z�skaj� datov� podklad k odpov�zen� na vyty�en� v�zkumn� ot�zky. Pozor, ot�zky/hypot�zy mohou va�e v�stupy podporovat i vyvracet! Z�le�� na tom, co ��kaj� data.

Na sv�m GitHub ��tu vytvo�te repozit�� (m��e b�t soukrom�), kam ulo��te v�echny informace k projektu � hlavn� SQL skript generuj�c� v�slednou tabulku, popis meziv�sledk� (pr�vodn� listinu) a informace o v�stupn�ch datech (nap��klad kde chyb� hodnoty apod.).

Neupravujte data v prim�rn�ch tabulk�ch! Pokud bude pot�eba transformovat hodnoty, d�lejte tak a� v tabulk�ch nebo pohledech, kter� si nov� vytv���te."

## ANAL�ZA
### P�EHLED ZDROJOV�CH TABULEK
Pro tvorbu prim�rn� tabulky byly k dispozici dv� kmenov� tabulky, na ne� se tak� v�ou pomocn� tabulky - ��seln�ky.

czechia_payroll - Informace o mzd�ch v r�zn�ch odv�tv�ch za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R. Tabulka sest�v� z 8 sloupc�:
* id
* value
* value_type_code - k�d typu hodnoty
* unit_code - k�d jednotky, ve kter� jsou hodnoty vyj�d�eny
* calculation_code - k�d zp�sobu v�po�tu hodnoty
* industry_branch_code - k�d pr�myslov�ho odv�tv�
* payroll_year - rok pro n� z�znamy tabulky plat�
* payroll_quarter - kvart�l pro n� z�znamy tabulky plat�

K t�to tabulce se v�e n�kolik dopl�uj�c�ch tabulek:
* Czechia_payroll_calculation - ��seln�k kalkulac� v tabulce mezd
* czechia_payroll_industry_branch � ��seln�k odv�tv� v tabulce mezd.
* czechia_payroll_unit � ��seln�k jednotek hodnot v tabulce mezd.
* czechia_payroll_value_type � ��seln�k typ� hodnot v tabulce mezd.

czechia_price - Informace o cen�ch vybran�ch potravin za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R. Tato tabulka sest�v� z 6 sloupc�:
* id
* value - pr�m�rn� ceny pro jednotliv� kategorie potravin
* category_code - k�d kategorie potravin
* date_from
* date_to
* region_code - k�d regionu (kraje)

K t�to tabulce se v�ou tak� n�sleduj�c� podp�rn� tabulky:
* czechia_price_category � ��seln�k kategori� potravin, kter� se vyskytuj� v na�em p�ehledu
* czechia_region � ��seln�k kraj� �esk� republiky dle normy CZ-NUTS 2.

### PROBLEMATIKA TVORBY PRIM�RN� TABULKY

Podstatou tvorby prim�rn� tabulky je slou�en� tabulek czechia_payroll a czechia_price (a p��padn� jejich n�vazn� tabulky - ��seln�ky) do jedn� tabulky skrze stejn� porovnateln� obdob�, tedy spole�n� roky, ze kter� bude mo�n� �erpat data ohledn� mezd a cen potravin za �eskou republiku pro pln�n� n�sleduj�c�ch �loh - v�deck�ch ot�zek.

Ob� dv� tabulky obsahuj� velk� mno�stv� informac�, kter� jsou d�le pops�ny v navazuj�c�ch podp�rn�ch tabulk�ch - ��seln�c�ch. Prvn�m krokem tedy bylo se s tabulkami sezn�mit a zjistit co obsahuj� a dle zad�n� zv�it, kter� data jsou pro n�s d�le�it� a kter� ne. V obou dabulk�ch m��eme vid�t, �e se zde nach�z� n�kolik sloupc�, ve kter�ch jsou jen pouh� k�dy, kter� n�m nic ne��kaj� - tyto k�dy jsou pops�ny v navazuj�c�ch ��seln�c�ch. 

N�kter� ��seln�ky byly pou�ity jednou: 
* czechia_payroll_value_type - 'nastaven� value_type_code', aby byly zobrazeny jen v��e mezd - k�d 5958
* czechia_payroll_unit - zji�t�n�, v jak�ch jednotk�ch jsou hodnoty ve sloupci 'value' vyj�d�eny (pro mzdy to jsou �esk� koruny).

Dv� tabulky byly p�ipojeny trvale: 
* czechia_price_category - identifikace kategori� potravin a jejich jednotek mno�stv�
*czechia_payroll_industry_branch - identifikace pr�myslov�ho odv�tv�.

n�kter� tabulky v�bec: 
* czechia_payroll_calculation - zp�sob kalkulace hodnot pro n�s nen� d�le�it�
* czechia_region � data byla zpracov�v�na celkov� za �R; identifikace kraj� pro n�s tedy nem�la v�znam.

Po sezn�men� se s obsahem tabulek bylo v r�mci tvorby pr�marn� tabulky nutno zdolat n�kolik p�ek�ek. Jednou z p�ek�ek byl obsah nepot�ebn�ch z�znam� a hodnot. Tabulka czechia_payroll obsahuje krom� z�znam� ohledn� hrub�ch mezd tak� z�znamy o pr�m�rn�ch po�tech zam�stnanc� v odv�tv�ch - takov� hodnoty n�s zde nezaj�maj� a tak byly vy�azeny. Z�rovne� byly vylou�eny hodnoty o mzd�ch, u nich� nebyla uvedena informace o odv�tv�, kterou pova�ujeme za z�sadn�. 'NULL' hodnoty co se t��e mezd pozorov�ny nebyly.

V tabulce czechia price byly pozorov�ny 'NULL' hodnoty pouze v sloupci region_code, proto�e v�ak data v tomto projektu jsou zpracov�v�na celkov� pro �R, nep�edstavuj� tyto chybjej�c� informace o regionu probl�m. V tabulce czechia_price ��dn� hodnoty vy�azeny nebyly.

Dal��m probl�mem byla obs�hlost tabulek, zejm�na 'czechia_price', kter� m� celkem 108,249 z�znam�. 'czechia_payroll' m�la po odstran�n� nepot�ebn�ch z�znam� 3,268 z p�vodn�ch 6,880. Z�znamy obou tabulek proto byly zpr�m�rov�ny a seskupeny (podle roku a odv�tv�/kategorie potravin), ��m� se jejich rozsah v�razn� zmen�il: 'czechia_payroll' na 418 a czechia_price na 342. S takto zmen�en�mi rozsahy budou ve�ker� operace s t�mito tabulkami v�razn� rychlej�� a jejich data se daj� sn�ze ��st. 

Dal�� p�ek�kou bylo tak� nalezen� zp�sobu, jak data dvou tabulek v budoucnu p�rovat. Tabulky jsou na sobe v podstat� nez�visl�, a jedin�m spole�n�m rysem byl �daj o �ase m��en� - rok. V tabulce czechia_payroll tento �daj obsahoval sloupec 'payroll_year.' V tabulce czechia_price to byly sloupce 'date_to' a 'date_from', kter� obsahovaly cel� datum, kde rok byl v obou sloupc�ch v�dy shodn�, a tak mohl b�t pou�it kter�koliv z nich.

D�le je nutno post�ehnout, �e tabulky nemaj� shodn� rozsah let, pro n� dan� z�znamy plat�: tabulka czechia_payroll obsahuje z�znamy v letech 2000�2021, zat�mco tabulka czechia_price pouze v letech 2006�2018. Tabulky lze tedy vz�jemn� srovn�vat pouze mezi lety 2006 a 2018.

Krom� omezov�n� z�znam� (��dk� ) bylo na�� snahou omezovat rovn� po�ty sloupc�, kde v tabulce 'czechia_payroll' byly nakonec vybr�ny pouze t�i sloupce obsahuj�c� n�sleduj�c� informaci:
* �daj o roku - payroll_year
* n�zvu odv�tv� - cpib.name (z ��seln�ku czechia_payroll_industry_branch)
* �daj o v��i pr�m�rn� hrub� mzdy - value (posl�ze zpr�m�rov�n a zaokrouhlen)

V tabulce czechia_price:
* �daj o roku - date_from (posl�ze vlo�en do funkce year()) 
* �d�j o v��i ceny potravin - value (posl�ze zpr�m�rov�n a zaokrouhlen). Pozn�mka: nen� jasn� definov�no, v jak�ch jednotk�ch jsou zde ceny potravin uvedeny - p�edpokl�d�me, �e jsou v �esk�ch korun�ch.
* n�zvu kategorie potravin (z ��seln�ku czechia_price_category) 
* udaj o mno�stv� pro kter� ceny plat� (z ��seln�ku czechia_price_category) - vznikl spojen�m sloupc� 'price_value' a 'price_unit' skrze funkci concat().

Vybran� sloupce byly posl�ze v p��pad� pot�eby p�ejmenov�ny, aby aby se p�ede�lo probl�mu duplicitn�ch n�zv� a aby bylo jasn�, co obsahuj�.

Proto�e data dvou tabulek na sebe krom� spole�n�ch let nemaj� p��mou n�vaznost, zp�sob propojen� skrze klauzuli 'JOIN' se nejevil jako vhodn�, proto�e v�echny z�znamy z jedn� tabulky by se nav�zaly na z�znamy se shodn�m rokem v tabulce druh�, tud� by do�lo ke zbyte�n�mu nadbyt� (duplicit�m) z�znam�, ��m� by byla zma�ena na�e snaha o zredukov�n� dat na minimum.

Propojen� dvou zm�n�n�ch tabulek bylo tud� provedeno skrze klauzuli 'UNION.' T�mto zp�sobem jsou tabulky spojeny nikoliv z boku ale zespoda, ��m� nedoch�zelo k duplicit�m z�znam�. 

Jeliko� skrze 'UNION' lze spojit pouze z�znamy se stejn�mi po�ty sloupc�, bylo nutn� po�ty sloupc� vyrovnat. V na�em p��pad� toho bylo dosa�eno vlo�en�m pomocn�ch 'NULL' sloupc� obsahuj�c�ch pr�zdn� hodnoty. Tyto 'NULL' sloupce byly do obou tabulek vlo�eny tak, aby z�znamy obou tabulek m�ly sv� vlastn� separ�tn� sloupce (bl�e pops�no v sekci 'postupu').  

### ROZBOR V�SLEDN� PRIM�RN� TABULKY

V�sledkem na�eho �sil� je tabulka "t_roman_zavorka_project_sql_primary_final" s rozsahem 760 z�znam� a celkem 7 slupci:
* payroll_year - informace o roku, pro kter� z�znamy o mzd�ch plat�
* industry_branch_name - n�zev pr�myslov�ho odv�tv�
* mean_salary_czk - pr�m�rn� hrub� mzda podle roku a odv�tv�
* price_year - informace o roku, pro kter� z�znamy o cen�ch potravin plat� 
* foodstuff_name - n�zev kategorie potravin
* mean_price_czk - pr�m�rn� cena podle roku a kategorie potravin 
* price_unit - jednotka mno�stv�, na kter� se z�zanmy o cen�ch potravin vztahuj�.

Z�znamy tabulky n�m prozrazuj� pr�m�rn� hrub� mzdy podle roku a pr�myslov�ho odv�tv� v letech 2000�2021 a tak� pr�m�rn� ceny (na dan� mno�stv�) podle roku a kategorie potravin v letech 2006�2018 .

Proto�e tabulky byly propojeny skrze klauzuli 'UNION' a do separ�tn�ch sloupc�, m��eme vid�t, �e tabulka obsahuje mnoho pr�zdn�ch z�znam�, tedy kdy� se d�v�me na z�znamy z tabulky 'czechia_payroll', z�znamy z tabulky 'czechia_price' jsou pr�zdn� a naopak.

## POSTUP
### VYTVO�EN� PRIM�RN� TABULKY
#### �VOD

Prim�rn� tabulka t_roman_zavorka_project_sql_primary_final obsahuj�c� data z obou tabulek byla vytvo�ena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kde 'CREATE' tabulku vytv��� a v p��pad�, �e tabulka s t�mto n�zvem ji� existuje, se aktivuje p��kaz 'REPLACE,' kter� st�vaj�c� tabulku nahrad� novou, co� v p��pad� pot�eby umo��uje tabulku snadno upravovat a aktualizovat. Tabulka byla v na�em p��pad� vytvo�ena skrze SQL dotazu za klauzul� 'AS.'
 
Jak bylo ji� pops�no v��e v analytick� ��sti, vytvo�en� v�sledn� tabulky bylo provedeno skrze klauzuli 'UNION,' slu�uj�c� dva samostatn� SQL dotazy; jeden pro tabulku czechia_payroll a druh� pro tabulku czechia_price.
#### DOTAZ PRO TABULKU czechia_payroll

Do klauzule 'FROM' byl vlo�en n�zev p��slu�n� tabulky czechia_payroll (cp), ze kter� byla data nahr�v�na.
Na za��tku byly zobrazov�ny ve�ker� sloupce: 'SELECT *'.

Skrze zklauzuli 'INNER JOIN' (lze pou��t i 'LEFT JOIN') byla p�ipojena men�� tabulka czechia_payroll_industry_branch (cpib) s ��seln�kem pro identifikaci jednotliv�ch pr�myslov�ch odv�tv� ze sloupce cp.industry_branch_code. Tabulka byla p�ipojena n�sledn�:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

Pot�ebn� hodnoty ohledn� v��e pr�m�rn�ch mezd se nach�zej� v sloupci 'value', kde mimo jin� najdeme tak� hodnoty o 'pr�m�rn�ch po�tech zam�stnan�ch osob,' kter� nejsou pot�ebn�, tud� skrze klauzuli 'WHERE' byly z�znamy omezeny pouze na hodnoty t�kaj�c� se v��e mezd: 

'WHERE cp.value_type_code = 5958'(zji�t�no z ��seln�ku 'czechia_payroll_value_type').

Rovn� byly zaznamen�ny z�znamy, kter� maj� ve sloupci 'industry_branch_code' hodnoty 'NULL,' a tak nev�me, do kter�ho odv�tv� spadaj�. Proto�e informace o odv�tv� je pro n�s relevantn�, byly tyto hodnoty t� vylou�eny p�id�n�m dal�� podm�nky do klauzule 'WHERE': 

'AND cp.industry_branch_code IS NOT NULL.'

Poznamka: Je mo�no rovn� p�idat podm�nku 'AND cp.value IS NOT NULL', nicm�n� v sloupci 'value' ��dn� pr�zdn� z�znamy o v��i mezd nalezeny nebyly, a tak tato podm�nka p�id�na nebyla.

V tuto chv�li jsou zobrazov�ny ve�ker� sloupce a z�znamy jsou omezeny pouze na z�znamy o v��i mezd v jednotliv�ch letech v jednotliv�ch kvart�lech v jednotliv�ch odv�tv�ch. Data v tomto rozlo�en� jsou v�ak st�le velmi obs�hl� a tak je m��eme v�razn� zmen�it zpr�m�rov�n�m fc� avg() a adekv�tn�m seskupen�m klauzul� GROUP BY. V na�em p��pad� byly z�znamy seskupeny podle jednotliv�ch let m��en� a druhotn� podle pr�myslov�ho n�zvu odv�tv� (p�ipojen� ��seln�k):

'GROUP BY cp.payroll_year, cpib.name'

Toto zpr�m�rov�n� a seskupen� ve�ker�ch z�znam� n�m krom� zmen�en� tabulky tak� v�znam� pom��e i p�i �e�en� n�sleduj�c�ch �loh, proto�e takto nastaven� data jsou snadn�ji interpretov�na a v n�kter�ch p��padech u� ani nen� nutn� pou��t fci avg ().

Krom� z�znam� byly provedena omezen� tak� v po�tu sloupc�, kde v 'SELECT' klauzuli byly ve fin�le vybr�ny pouze t�i d�le�it� sloupce:
* cp.payroll_year - obsahuje informace o obdob�, pro kter� jednotliv� z�znamy plat�(n�zev sloupce n�m vyhovuje tak jak je).
* cpib.name AS industry_branch_name - sloupec s n�zvy pr�myslov�ch odv�tv� z p�ipojen� tabulky (��seln�ku)'czechia_payroll_industry_branch', sloupec 'cp.industry_branch_code' u� tedy nepot�ebujeme.
* round(avg(cp.value),2) AS mean_salary_czk - dosavadn� sloupec 'cp.value' obsahuj�c� hodnoty o v��i hrub�ch mezd byl zpr�m�rov�n a zaokrouhlen na dv� desetinn� m�sta skrze funkce avg() a round(). Proto�e v��e mezd je vyj�d�ena v �esk�ch korun�ch, byla do n�zvu p�id�na zkratka 'czk.'	

Nyn� kdy� byly nastaveny 'aliasy', m��eme v klauzuli GROUP BY nahradit 'cpib.name' n�zvem 'industry_branch_name':

'GROUP BY cp.payroll_year, industry_branch_name'

Kone�n� v�stup t�to tabulky byl pot� skrze klauzuli ORDER BY se�azen sestupn� podle roku a vzestupn� podle n�zvu pr�myslov�ho odv�tv�: 

'ORDER BY cp.payroll_year DESC, industry_branch_name ASC'

V tomto bod� je v�stupem tabulka se t�emi sloupci: payroll_year, industry_branch_name a mean_salary_czk; rozsah tabulky je celkem 418 ��dk�. Tabulka n�m ukazuje pr�m�rn� mzdy v jednotliv�ch letech v jednotliv�ch odv�tv�ch a je se�azena sestupn� podle let a vzestupn� podle n�zvu odv�tv�.
#### DOTAZ PRO TABULKU czechia_price
Do klauzule 'FROM' byl vlo�en n�zev tabulky czechia_price (cpr) a skrze SELECT * byly zobrazeny ve�chny sloupce.

Hodnoty ohledn� cen potravin se nach�zej� v sloupci 'value', (stejn� pojmenov�n jako v tabulce czechia_payroll), p�i�em� potraviny jsou identifkov�ny pouze v sloupci 'category_code'.

Abychom jednozna�n� identifikovali jednotliv� kategorie potravin, byla p�pojena skrze klauzuli 'INNER JOIN' (lze pou��t i 'LEFT JOIN') tabulka czechia_price_category (cpc) obsahuj�c� ��seln�k. Tabulka byla p�ipojena n�sledovn�:

'czechia_price_category (cpc) ON cp.category_code = cpc.code'

Krom� sloupce 'region_code' jsou z�znamy kompletn� a neobsahuj� 'NULL' hodnoty. Proto�e data v n�sleduj�c�ch �loh�ch budou zpracov�v�na celkov� pro �R, nen� informace o kraji v sloupci 'region_code' d�le�it�. Omezen� rozsahu z�znamu v t�to tabulce nen� nutn�.

N�sledn� byly v klauzuli 'SELECT' vybr�ny pot�ebn� sloupce.
Jako prvn� pot�ebujeme �daj o roku, do kter�ho jednotliv� z�znamy pat��. V tabulce jsou k dispozici dva sloupce ud�v�j�c� tuto informaci: 'date_from' a 'date_to.' Z�znamy jsou ve form�tu, kde je uvedeno cel� datum a �as. Proto�e pro propojen� s prvn� tabulkou pot�ebujeme zn�t pouze infomaci o roku, byla pou�ita funkce year().

Skrze n�seduj�c� dotaz bylo zji�t�no, �e oba datumy jsou v�dy ve stejn�m roce, a tak je mo�no pou��t kter�koliv z t�chto dvou sloupc�:

'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)' 

V na�em p��pad� byl vybr�n sloupec 'date_from': 
* year(cpr.date_from) AS price_year
* Jako dal�� byl zvolen sloupec z p�ipojen� tabulky czechia_price_category (cpc) ud�vaj�c� n�zev kategorie potravin: cpc.name AS foodstuff_name - (tud� sloupec cpr.category_code ji� nad�le nepot�ebujeme).
* Obdobn�m zp�sobem provedeme zpr�m�rov�n� a zaokrouhlen� hodnot v sloupci cpr.value jako v tabulce czechia_payroll: round(avg(cpr.value),2) AS mean_price_czk.
* Posledn�m sloupcem t�to tabulky vznikl slou�en�m sloupc� 'cpc.price_value' a 'cpc.price_unit' z p�ipojen� tabulky czechia_price_category (cpc) funkc� concat(): concat(cpc.price_value," ",cpc.price_unit) AS price_unit. Tento sloupec ud�v� mno�stv�, ke kter�mu se v�ou ceny jednotliv�ch kategori� potravin (nap�. cena za 0,5 l piva).

Obdobn� jako v tabulce czechia_payroll je i zde velmi mnoho z�znam�, a tak byly i zde byly hodnoty o cen�ch potravin zpr�m�rov�ny a seskupeny skrze klauzuli 'GROUP BY' podle roku a kategorie potravin: 

'GROUP BY price_year, foodstuff_name'

V�stup na�eho dotazu pro tuto tabulku byl n�sledn� skrze klauzuli ORDER BY se�azen sestupn� podle roku a vzestupn� podle kategorie potravin: 

'ORDER BY price_year DESC, foodstuff_name ASC'

Dosavadn� v�stup je tedy slo�en ze sloupc� 'price_year', 'foodstuff_name', 'mean_price_czk' a 'price_unit' s rozsahem celkem 342 ��dk�. Jednotliv� z�znamy n�m prozrazuj�, jak� jsou pr�m�rn� ceny jednotliv�ch potravinov�ch kategori�ch v jednotliv�ch letech pro dan� mno�stv� a jsou se�azeny sestupn� podle let a vzestupn� podle n�zvu potravin.
#### SPOJEN� DOTAZ� 
Nyn� kdy� je rozsah na�ich dvou tabulek p�ipraven, m��eme postupn� p�istoupit k jejich spojen� skrze klauzuli 'UNION.' 

Prvn�m probl�mem kter� br�nil spojen� dvou tabulek byl nestejn� po�et sloupc� (3 na 4). Mimo j�ne jsem se rozhodl, �e data z obou tabulek chci m�t v separovan�ch sloupc�ch. toho bylo dosa�eno p�id�n�m 'null' sloupc� do obou na�ich tabulek, p�i�em� nov� p�idan� 'null' sloupce v horn� tabulce ponesou n�zvy sloupc� spodn� tabulky a 'null' sloupce ve spodn� tabulce budou za�len�ny do prvn�ch t�i sloupc� prvn� tabulky:

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

T�mto byl vy�e�en probl�m s nestejn�m po�tem sloupc� a z�rove� do�lo k separaci sloupc� obou tabulek. Pot� ji� bylo pot�eba zabalit dotazy dvou tabulek do z�vorek a spojit klauzul� 'UNION,' ��m� je SQL dotaz pro zobrazen� v�ech pot�ebn�ch polo�ek obou tabulek dokon�en (mo�no prov�st t� p�es 'UNION ALL', nicm�n� v�sledek zde bude stejn�).

P�esto�e oba dva SQL dotazy byly skrze klauzuli 'ORDER BY' se�azeny sestupn� podle roku a vzestupn� podle odv�tv� / kategorie potravin, v�stup na�eho 'propojen�ho' dotazu nen� se�azen dle na�eho o�ek�v�n�. Tud� tento propojen� dotaz byl je�t� vno�en do nov�ho dotazu, ve kter�m nech�me zobrazit ve�ker� data se�azena podle na�eho o�ek�v�n�:

'ORDER BY payroll_DESC, industry_branch_name ASC, price_year DESC, foodstuff_name ASC

Nyn�, jak bylo ji� pops�no na za��tku, sta�� nad dosavadn� dotaz p�idat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kter� d� pokyn k vytvo�en� �i nahrazen� tabulky 't_roman_zavorka_project_sql_primary_final'
### VYTVO�EN� SEKUND�RN� TABULKY
#### �VOD
Obdobn� jako prim�rn� tabulka byla i sekund�rn� tabulka vytvo�ena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS', kter� vytvo�� �i nahrad� tabulku t_roman_zavorka_project_SQL_secondary_final z SQL dotazu za kone�nou klauzul� 'AS.'

Zm�n�n� sekund�rn� tabulka, jak bylo ji� uvedeno v zad�n�, m� obsahovat dopl�uj�c� p�ehled HDP, GINI koeficientu a populac� dal��ch evropsk�ch st�t� ve stejn�m obdob�, jako prim�rn� p�ehled pro �R. Tabulka byla vytvo�ena spojen�m tabulek 'economies' a 'countries.' 
#### ZP�SOB SPOJEN� TABULEK
Proto�e ob� dv� tabulky obsahuj� z�znamy, kter� na sebe p��mo navazuj� skrze spole�n� sloupec 'country', p�es kter� lze tyto dv� tabulky propojit ani� by doch�zelo k ne��douc�m duplicit�m, byly v tomto p��pad� propojeny skrze klauzuli 'INNER JOIN.'
#### VYTVO�EN� SQL DOTAZU
Jako prvn� tabulka byla zvolena tabulka 'countries', a tak byla vlo�ena do klauzule FROM. V klauzuli SELECT * zobrazujeme ve�ker� sloupce.

Nasledn� byla skrze klauzuli 'INNER JOIN' p�ipojena tabulka 'economies' p�es sloupec 'country': 

'INNER JOIN economies c ON e.country = c.country'

Proto�e tabulka m� obsahovat data pro dal�� evropsk� zem�, ale nen� p�esn� specifikov�no kter�, byly vybr�ny v�eker� zem� nach�zej�c� se na evropsk�m kontinent�. 

Druhou podm�nkou je, �e z�znamy maj� b�t pro stejn� obdob�, jako prim�rn� p�ehled pro �R; czechia_payroll: 2000�2021 a czechia_price 2006�2018. Z�znamy byly tedy omezeny jen na rok 2000 a v��e. Tyto podm�nky byly nastaveny skrze klauzuli 'WHERE' n�sledovn�:
 
"WHERE c.continent = 'Europe' AND e.`year`>= 2000"

Nyn�, kdy� byly ob� dv� tabulky �sp�n� propojeny a z�znamy byly omezeny podle na��ch pot�eb, specifikujeme zkrze 'SELECT' klauzuli, kter� sloupce ve v�sledn� tabulce budou.

Zad�n�m je poskytnout data o HDP, GINI koeficientu a v��i populace v dal��ch evropsk�ch zem�ch v jednotliv�ch letech, tyto informace najdeme v tabulce 'economies.' Z tabulky 'countries' byly z�rove� nad r�mec zad�n� p�id�ny z�kladn� dopl�uj�c� informace o jednotliv�ch zem�ch. Ve v�sledku byly vybr�ny n�sleduj�c� sloupce:

* c.country - n�zvy zem�
* c.capital_city - hlavn� m�sto
* c.region_in_world - bli��� popis lokalizace st�t�
* c.currency_code - zkratka m�stn� m�ny
* e.`year`, - rok, pro kter� data plat�
* e.GDP AS gdp - hrub� dom�c� produkt
* e.gini - gini koeficient
* e.population - �daje o v�voji populace v letech; sloupec c.populaton z druh� tabulky v�voj populace v letech nezaznamen�v� (je fixn�), a tak nebyl vybr�n.

T�mto je SQL dotaz pro vymezen� dat pro sekund�rn� tabulku dokon�en. V�sledn� tabulka sest�v� celkem z 8 sloupc� a jej� rozsah je 945 z�znam�. Tabulka n�m prozrazuje z�kladn� informace o evropsk�ch zem�ch (hlavn� m�sto, lokalizace na kontinentu, zkratku m�stn� m�ny) a v�voj ekonomick�ch ukazatel� HDP a gini a populace v letech 2000�2020.

Nyn�, stejn� jako u prim�rn� tabulky, sta�� nad dosavadn� dotaz p�idat klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS' kter� d� pokyn k vytvo�en� �i nahrazen� tabulky.

### DOTAZ PRO OT�ZKU �. 1: 
Abychom zjistili, zda mzdy v jednotliv�ch odv�tv�ch stoupaj� �i klesaj�, byl vytvo�en sloupec s zobrazuj�c� rozd�ly ve mzd�ch mezi lety pro jednotliv� odv�tv�. Toho bylo dosa�eno skrze p�ipojen� duplicitn� tabulky 'pf2.'

V z na�i prim�rn� tabulky 'pf' byly skrze 'SELECT' klauzuli vybr�ny n�sleduj�c� sloupce:
* pf.payroll_year - roky pro kter� z�znamy o mzd�ch plat�
* pf.industry_branch_name - pr�myslov� odv�tv�
* pf.mean_salary_czk - pr�m�rn� mzdy

Abychom vypo�etli ro�n� rozd�l ve mzd�ch, byla k na�� tabulce klauzul� 'INNER JOIN' p�ipojena duplicitn� tabulka 'pf2' kter� byla skrze vno�en� dotaz obdobn�m zp�sobem omezena na stejn� sloupce jako v prvn� tabulce 'pf.' 

Tabulky byly propojeny skrze spole�n� roky a shodn� odv�tv�: 
'ON pf.payroll_year = pf2.payroll_year + 1 AND pf.industry_branch_name = pf2.industry_branch_name'

K roku v druh� tabulce byla p�i�tena +1, aby byly ve�ker� z�znamy v n� posunuty o rok zp�t. Pro p�ipojen� byl zvolen INNER JOIN, aby byly odstran�ny ne��douc� NULL hodnoty v druh� tabulce plynouc� z posunut� z�znam� o rok zp�t u roku 2000 (rok 1999 nen� k dispozici). 

'INNER JOIN' z�rove� zajist�, �e se ve vybran�ch sloupc�ch nebudou zobrazovat 'NULL' hodnoty plynouc� z propojen� tabulek 'czechia_payroll' a 'czechia_price skrze' klauzuli 'UNION' (viz tvorba prim�rn� tabulky).

Po �sp�n�m p�ipojen� dvou tabulek byly polo�ky (sloupce) ve vn�j�� 'SELECT' klauzuli nastaveny n�sledn�:
* k prvn�mu sloupci 'pf.payroll_year' byl skrze concat() p�ipojen pf2.payroll_year: 'concat(pf.payroll_year," � ", pf2.payroll_year) AS time_period'
* pf.industry_branch_name
* pf.mean_salary_czk AS latter_mean_salary_czk 
* pf2.mean_salary_czk AS former_mean_salary_czk
* V�po�et a zaokrouhlen� rozd�lu mezi lety: round(pf.mean_salary_czk - pf2.mean_salary_czk,2) AS annual_difference_czk

Pozn�mka: proto�e hodnoty ohledn� mezd byly zpr�m�rov�ny a seskupeny podle let a odv�tv� ji� p�i tvorb� prim�rn� tabulky, nen� nutn� pou��vat funkci avg() ani klauzuli 'GROUP BY.'

Pro zv�razn�n� z�v�ru ro�n�ho rozd�lu byl skrze kaluzuli 'CASE' je�t� p�id�n sloupec 'annual_difference_notification', kter� upozor�uje, zda do�lo k r�stu, poklesu �i stagnacy mezd mezi lety:

* CASE
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) > 0 THEN "increase"
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) < 0 THEN "decrease !!!"
* ELSE "stagnancy"
* END AS annual_difference_notification

V�sledn� data byla se�azena vzestupn� podle n�zvu a sestupn� podle roku m��en�: 

'ORDER BY pf.industry_branch_name ASC, pf.payroll_year DESC'

T�mto je SQL dotaz pro zodpov�zen� ot�zky �. 1 dokon�en a prozrazuje n�m pr�m�r� v��e mezd a meziro�n� rozd�ly v jednotliv�ch letech a odv�tv�ch a informaci, zda do�lo k poklesu nebo zv��en� oproti lo�sk�mu roku. 

### DOTAZ PRO OT�ZKU �. 2
Proto�e v zad�n� se hovo�� o mzd�ch v jednotliv�ch letech obecn� a nikoliv podle odv�tv�, bylo pot�eba vypo��tat celkovou pr�m�rnou mzdu ze v�ech odv�tv� pro jednotliv� roky.

Z prim�rn� tablky 'pf' ze sekce ohledn� mezd 
byl v 'SELECT' klauzuli vybr�n sloupec s �dajem o roku a sloupec po��taj�c� pr�m�r z mezd zaokrouhlen� na dv� desetinn� m�sta:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk

N�sledn� byly ve�ker� hodnoty seskpeny podle jednotiv�ch let: 

'GROUP BY pf.payroll_year'

V�sledky byly rovn� se�azeny sestupn� podle jednotliv�ch let:

'ORDER BY pf.payroll_year DESC'

V tuto chv�li n� dotaz zobrazuje celkov� pr�m�rn� mzdy sestupn� podle jednotliv�ch let.

Dal��m krokem bylo z�skat pot�ebn� pr�m�rn� ceny potravin podle roku a kategorie potravin. Jeliko� ceny potravin byly t�mto zp�sobem zpr�m�rov�ny a seskupeny ji� p�i tvorb� prim�rn�, nen� nutn� je upravovat.

Proto�e z�znamy ohledn� potravin bylo pot�eba zobrazit vedle z�znam� ohledn� mezd podle spole�n�ch let m��en� (co� st�vaj�c� tabulka 'pf' neumo��uje), byla p�ipojena duplicitn� tabulka 'pf2.'

Zobrazen� sloupc� v p�ipojen� tabulce 'pf2' bylo skrze vno�en� dotaz omezeno rok, pr�m�rn� ceny potravin, n�zev kategorie potravin a jednotky mno�stv�:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name
* pf.price_unit

V �loze je d�no, �e v�po�ty maj� b�t provedeny pro prvn� a posledn� srovnateln� obdob� a pouze pro kategorie potravin 'ml�ko' a 'chl�b.'

Pozn�mka: ohledn� mezd m�me k dispozici z�znamy z let 2000�2021, zat�mco z�znamy ohledn� cen potravin m�me jen pro roky 2006�2018, prvn�m srovnateln�m obdob�m je tedy rok 2006 a posledn�m rok 2018.

Z�znamy ve vno�en�m dotazu byly tedy skrze klauzuli 'WHERE' omezeny n�sledovn�:

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%ml�ko%' OR pf.foodstuff_name LIKE '%chl�b%')"

Tyto podm�nky zajist�, �e se zobraz� pouze z�znamy v letech 2006 a 2018 a z�rov�� zobraz� pouze kategorie potravin, kter� maj� ve sv�m n�zvu 'ml�ko' nebo 'chl�b.'

Vno�en� dotaz je t�mto dokon�en a jeho spu�t�n�m se n�m zobraz� tabulka se 4 sloupci a 4 z�znamy: pr�m�rn� ceny pro 1 kg chleba a 1 l ml�ka v letech 2006 a 2018.

Tabulky byly n�sledn� propojeny skrze spole�n� roky:

'ON pf.payroll = pf2.price_year'

Pro propojen� byla zvolena klauzule 'INNER JOIN' aby ve�ker� z�znamy byly posl�ze omezeny jen na vybran� roky a vybran� potraviny v p�ipojen� pomocn� tabulce 'pf2'.

Pozn�mka: omezen�m z�znam� v p�ipojen� tabulce 'pf2' skrze vno�en� dotaz se vyrazn� urychluje spu�t�n� cel�ho SQL dotazu.

Do vnej�� 'SELECT' klauzule byly n�sledn� p�id�ny sloupce ohledn� cen potravin; uspo��d�n� sloupc� nyn� vypadalo n�sledovn�:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk
* pf2.foodstuff_name
* pf2.mean_price_czk
* pf2.price_unit

Proto�e do 'SELECT' klauzule byly p�id�ny sloupce t�kaj�c� se cen potravin, bylo nutn� rovn� prov�st �pravu v 'GROUP BY' klauzuli p�id�n�m sloupce 'pf2.foodstuff_name', aby se z�znamy seskupily prvotn� podle roku a druhotn� podle kategorie potravin:

'GROUP BY pf.payroll_year, pf2.foodstuff_name'

V tomto moment� m�me k dispozici celkov� pr�m�rn� 'hrub�' mzdy a pr�m�rn� ceny ml�ka a chleba. Abychom v�ak mohli vypo��st v jak�m mno�stv� m��eme dan� potraviny nakoupit, pot�ebujeme hrubou mzdu p�epo��tat na �istou:

2018: 
* pr�m�rn� hrub� mzda: 32535,86 K�
* zdravotn� (4,5%) a soci�ln� poji�t�n� (6,5 %): celkem 3580 K�
* da�ov� z�klad: 32535,86*1,34 zaokrouhl�me na stovky nahoru: 43600 K�
* da� z p��jmu: 43600*0,15-2070(sleva): 4470 K�
* �ist� mzda: 32535,86-3580-4470 = 24 486 K� (zaokrouhleno nahoru)

2006:
* pr�m�rn� hrub� mzda: 20753,79 K�
* zdravotn� (4,5 %) a soci�ln� poji�t�n� (8 %): celkem 2595 K�
* da�ov� z�klad: 20753,79-2595 = 18158,79 K� zaokrouhl�me na stovky nahoru: 18200 K�
* da� z p��jmu: (18200-18200)*0,25+2715-600(sleva): 2115 K�
* �ist� mzda: 18158,79-2115 = 16 044 K� (zaokrouhleno nahoru)

Pozn�mka: v�po�et je proveden pouze se z�kladn� slevou na dani. Metodick� postup v�po�tu �ist� mzdy byl v letech 2006 a 2018 odli�n�.

Nyn�, kdy� je �ist� mzda pro na�e dv� obdob� vypo�tena,
byly do 'SELECT' klauzule p�id�ny sloupce s �istou mzdou a v�po�tem, kolik lze p�i dan�ch pr�m�rn�ch �ist�ch mzd�ch a cen�ch nakoupit dan�ch potravin:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk
* CASE WHEN pf.payroll_year = 2018 THEN 24486 ELSE 16044 END AS mean_net_salary_czk
* pf2.foodstuff_name
* pf2.mean_price_czk
* CASE WHEN pf.payroll_year = 2018 THEN round(24486 / pf2.mean_price_czk,2) ELSE round(16044 / pf2.mean_price_czk,2 END AS possible_purchase_amount
* pf2.price_unit

Proto�e v�sledn� �ist� mzda byla vlo�ena ru�n�, byly tyto nov� p�idan� sloupce vytvo�eny skrze klauzuli 'CASE,' aby se ke ka�d�mu roku p�idru�ila spr�vn� ��stka.

Kone�n� v�stup byl n�sledn� se�azen sestupn� podle roku a vzestupn� podle n�zvu kategorie potravin:

'ORDER BY pf.payroll_year DESC, pf2.foodstuff_name ASC'

T�mto je SQL dotaz pro ot�zku �. 2 dokon�en a jeho v�stupem je tabulka se 4 z�znamy, kter� n�m prozrazuje jak� byly pr�m�rn� hrub� a �ist� mzdy a pr�m�rn� ceny chleba a ml�ka v letech 2006 a 2018 a jako mno�stv� bylo mo�n� si t�chto potravin p�i dan�ch mzd�ch koupit.

### DOTAZ PRO OT�ZKU �. 3: 
Aby bylo mo�n� zjistit, jak se ceny potravin mezi lety vyv�jely, byly z pr�m�rn�ch ro�n�ch cen jednotliv�ch potravin vypo�teny ro�n� rozd�ly; postup v tomto p��pad� byl podobn� jako v �loze �. 1.

Z prim�rn� tabulky 'pf' byly skrze 'SELECT' klauzuli vybr�ny sloupce uv�d�j�c� informaci ohledn� roku, n�zvu kategorie potravin a pr�m�rn� ceny:
* pf.price_year
* pf.foodstuff_name
* pf.mean_price_czk

Pro v�po�et meziro�n�ch roz�l� byla n�sledn� p�ipojena duplicitn� tabulka 'pf2', kde skrze vno�en� dotaz ('SELECT') byly vybr�ny stejn� sloupce jako v na�� hlavn� tabulce 'pf' a z�rove� byly vy�azeny pr�zn� z�znamy, kter� v prim�rn� tabulce vznikly p�i jej� tvorb� skrze slou�en� tabulek czechia_payroll a czechia_ price p�es 'UNION.':

'WHERE mean_price_czk IS NOT NULL'

Tabulky byly propojeny skrze shodn� kategorie potravin a roky, kde v p�ipojen� tabulce 'pf2' byl p�ipo�ten rok nav�c, ��m� se z�znamy v n� posunuly o rok zp�t:

'ON pf.price_year = pf2.price_year +1 AND pf.foodstuff_name = pf2.foodstuff_name

Tabulka byla p�ipojena skrze 'INNER JOIN', aby byly odstran�ny ne��douc� z�znamy S NULL hodnotami plynouc�ch z posunu z�znam� - z�znamy p�ed rokem 2006 nem�me k dispozici. Z�rove� t�m  byly odstran�ny pr�zdn� hodnoty vznikl� p�i tvorb� tabulky 'pf' spojen�m 'cp' a 'cpr' skrze 'UNION'.

Po �sp�n�m p�ipojen� tabulky 'pf2' byly ve vnej�� 'SELECT' klauzuli provedeny n�sleduj�c� zm�ny v uspo��d�n� zobrazovan�ch sloupc�:
* concat(pf.price_year," � ", pf2.price_year) AS time_period
* pf.foodstuff_name,
* pf.mean_price_czk AS latter_mean_price_czk
* pf2.mean_price_czk AS former_mean_price_czk
* round((pf.mean_price_czk - pf2.mean_price_czk) / pf2.mean_price_czk*100,2) AS percentage_price_difference

V��e uveden� v�b�r n�m nyn� zobrazuje pr�m�ry a meziro�n� rozd�ly pr�m�r� cen potravin mezi lety. Z�znamy byly posl�ze prim�rn� se�azeny sestupn� podle roku m��en� a pot� vzestupn� podle n�zvu potravin v prvn� tabulce:

'ORDER BY pf.price_year DESC, pf.foodstuff_name ASC'

Jeliko� hodnoty t�kaj�c� se cen potravin byly zpr�m�rov�ny a seskupeny podle roku a kategorie potravin ji� p�i tvorb� prim�rn� tabulky, nebylo v tomto bod� nutn� nastavovat klauzuli 'GROUP BY' (v�sledky se zobraz� stejn�). 

Proto�e zobrazovan�ch z�znam� je v tomto bod� velmi mnoho (celkem 315 ��dk�), nen� snadn� tato data interpretovat a ud�lat z nich z�v�r o rychlosti zdra�ov�n� �i slev�ov�n� jednotliv�ch potravin; z meziro�n�ch rozd�l� byl tedy pro jednotliv� potraviny nakonec vypo�ten pr�m�r.

Abychom mohli tento pr�m�rn� procentu�ln� rozd�l vypo��tat, byl cel� dosavadn� dotaz vno�en do nov� klauzule 'FROM' ('pf3') a skrze novou vn�j�� klauzuli 'SELECT' byl proveden v�po�et pr�m�rn�ho procentu�ln�ho roz�dlu pro jednotliv� potraviny:
* pf3.foodstuff_name
* round(avg(pf3.percentage_price_difference,2) AS mean_percentage_price_difference

Aby se vypo�ty seskupily podle jednotliv�ch potravin, bylo nutn� v na�em nov�m vn�j��m dotazu nastavit klauzuli 'GROUP BY':

'GROUP BY pf3.foodstuff_name'

Kone�n� v�stup jsme rovn� se�adili vzestupn� podle nov� vypo�ten�ho pr�m�ru a n�zvu potravin:

'ORDER BY mean_percentage_price_difference ASC, foodstuff_name ASC'

T�mto byla tvorba SQL dotazu pro zodpov�zen� ot�zky �. 3 dokon�ena, a jeho spu�t�n�m dostaneme v�pis potravin s jejich pr�m�rn�m procentu�ln�m meziro�n�m rozd�lem, kter� je se�azen prim�rn� podle v��e tohoto rozd�lu a sekund�rn� dle n�zvu jednotliv�ch potravin.
 
### DOTAZ PRO OT�ZKU �. 4: 
Proto�e v t�to �loze je po�adavkem zjistit, zda existuje rok, ve kter�m byl meziro�n� n�r�st cen potravin v�razn� vy��� ne� r�st mezd (vet�� ne� 10%), bylo pot�eba vypo��tat procentu�ln� meziro�n� rozd�ly celkov�ch ro�n�ch pr�m�r� pro mzdy a ceny potravin. Abychom toho dos�hli, byly p�ipojeny pomocn� duplicitn� tabulky 'pf2' a 'pf3.'

V prvn� ze dvou tabulek 'pf2' poslou�� k v�po�tu meziro�n�ho rozd�lu ve mzd�ch, a tak byly skrze vno�en� dotaz vybr�ny sloupce s informac� o roku a s v�po�tem pr�m�rn� v��e mzdy:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (bude zaokrouhleno v pozdej��ch v�po�tech)

V�sledky v tabulce byly rovn� zbaveny pr�zdn�ch z�znam� a seskupeny podle jednotliv�ch let:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

V tomto bod� vno�en� dotaz na�� tabulky zobrazuje celkov� nezaokrouhlen� pr�m�rn� v��e mezd pro jednotliv� roky. Tabulka byla n�sledn� skrze 'INNER JOIN' p�ipojena podle spole�n�ch let, kde k pf2 byl p�i�ten rok nav�c, aby se jej� z�znamy posunuly o rok zp�t:

'ON pf.payroll_year = pf2.payroll_year +1' 

Skrze toto spojen� byly meziro�n� rozd�ly ve mzd�ch vypo�teny ve vn�j�� 'SELECT' klauzuli (bude uk�z�no pozd�ji).

Druh� pomocn� tabulka 'pf3' poslou�� k v�po�tu meziro�n�ho rozd�lu v cen�ch potravin. Proto�e rozd�ly ve mzd�ch byly vypo�teny skrze tabulky 'pf1' a 'pf2', nen� obdobn� zp�sob v�po�tu vhodn�, proto�e by z podstaty 'UNION' propojen� tabulek 'cp' a 'cpr' nast�valy probl�my se zobrazen�m v�sledk� ohledn� rozd�l� cen potravin. Z tohoto d�vodu byly v t�to tabulce p�ipraveny n�sleduj�c� sloupce pro pozd�j�� v�po�et meziro�n�ho rozd�lu v cen�ch potravin:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

Abychom mohli tyto sloupce zobrazit, byla ve vno�en�m dotazu p�ipojena dal�� pomocn� tabulka: pf32 (pf31 je prvn�), jej� z�znamy byly posunuty o rok zp�t:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

Tyto tabulky byly propojeny skrze 'INNER JOIN,' ��m� byly odstran�ny ne��douc� 'NULL' z�znamy. Hodnoty byly nakonec v tabulce 'pf31' seskupeny podle roku:

'GROUP BY pf31.price_year'

Vno�en� dotaz v tabulce 'pf3' je nyn� hotov a zobrazuje n�m dva sloupce s nezaokrouhlen�mi pr�m�rn�mi cenami potravin v jednotliv�ch letech, p�i�em� jeden ze sploupc� m� pr�m�ry posunuty o rok zp�t, abychom mohli pozd�ji vypo��tat meziro�n� rozd�ly.

Pomocn� tabulka 'pf3' byla pot� skrze 'INNER JOIN' p�ipojena k tabulce pf podle spole�n�ch let:

'ON pf.payroll_year = pf3.price_year'

'INNER JOIN' zde zajist�, �e kone�n� v�stupy budou omezeny jen na spole�n� srovnateln� obdob� cen a mezd (2006�2018).

Pozn�mka: t�m, �e je ��st v�po�t� (zpr�m�rov�n� a seskupen�) provedeno u� uvnit� pomocn�ch tabulek je rychlost zpu�t�n� kone�n�ho dotazu v�razn� urychleno.

Nyn�, kdy� byly ve�ker� nezbytn� podklady p�ipraveny, byly skrze vn�j�� 'SELECT' klauzuli vypo�teny meziro�n� procentu�ln� rozd�ly pr�m�rn�ch mezd a cen; z t�ch byl pot� zpo�ten tak� rozd�l (rozd�l v meziro�n�ch rozd�lech mezd a cena potravin):
* concat(pf.payroll_year," � ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* round(((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100),2) - round(((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100),2) AS salary_price_percentage_difference

Jeliko� se je ot�zkou zda existuje rok, ve kter�m byl meziro�n� n�r�st cen potravin v�razn� vy��� ne� r�st mezd, byl rozd�l v r�stu cen a mezd vypo�ten v n�sledn�m form�tu: p��r�st cen % - p��r�st mezd %.

T�mto je dotaz pro zodpov�zen� ot�zky �. 4 dokon�en. jeho spu�t�n�m se n�m zobraz� v�pis meziro�n�ch procentu�ln�ch rozd�l� pr�m�rn�ch cen a mezd a tak� rozd�ly v t�chto meziro�n�ch rozd�lech mezi mzdami a cenami potravin.

### �LOHA �. 5
Proto�e v t�to �loze je po�adavkem zjistit, zda m� v��ka HDP a jeho zm�ny vliv na v�voj mezd a cen potravin, pot�ebujeme vypo��tat (procentu�ln�) meziro�n� rozd�ly mezd, cen potravin a HDP. Aby toto bylo mo�n�, je pot�eba p�ipojit pomocn� duplicitn� tabulky 'pf2', 'pf3' a sekund�rn� tabulku obsahuj�c� data ohledn� HDP 'sf.'

Proto�e v t�to �loze pot�ebujeme vypo��tat procentu�ln� meziro�n� rozd�ly mezd a cen potravin podobn� jako v �loze �. 4. byla prvn� ��st co se t��e p�ipojen� pomocn�ch tabulek 'pf2' a 'pf3' v podstat� stejn�, a tak zna�n� ��st dotazu byla p�evzata:

Tabulka 'pf2' bude slou�it k v�po�tu meziro�n�ho rozd�lu ve mzd�ch, tud� byly skrze vno�en� dotaz vybr�ny sloupce s rokem ohledn� roku a v�po�tem pr�m�rn� v��i mzdy:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (zat�m nen� nutno zaorkouhlovat)

N�sledn� byly v�sledky zbaveny pr�zdn�ch z�znam� a seskupeny dle jednotliv�ch rok�:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

V tuto chv�li vno�en� dotaz pomocn� tabulky zobrazuje celkov� pr�m�rn� v��e mezd pro jednotliv� roky. Tabulka byla n�sledn� skrze 'INNER JOIN' p�ipojena podle spole�n�ch let, kde k 'pf2' byl p�i�ten rok nav�c, aby se jej� z�znamy posunuly o rok zp�t:

'ON pf.payroll_year = pf2.payroll_year +1' 

P�es toto spojen� byly meziro�n� rozd�ly co se t��e mezd vypo�teny ve vn�j�� 'SELECT' klauzuli (bude n�sledovat pozd�ji).
 
Nyn� se dost�v�me k tabulce 'pf3' kter� bude slou�it k v�po�tu meziro�n�ho rozd�lu v cen�ch potravin. Jeliko� meziro�n� rozd�ly ve mzd�ch byly spo�teny skrze tabulky 'pf' a 'pf2', nem��eme obdobn� zp�sob v�po�tu pou��t, proto�e by z podstaty 'UNION' propojen� tabulek 'cp' a 'cpr' nast�valy probl�my se zobrazen�m v�sledk� co se t��e rozd�l� cen potravin. Tud� byly v t�to tabulce p�ipraveny n�sleduj�c� sloupce pro pozd�j�� v�po�et meziro�n�ho rozd�lu v cen�ch potravin:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

Aby bylo mo�n� v��e uk�zan� sloupce zobrazit, byla ve vno�en�m dotazu p�ipojena dal�� pomocn� tabulka: pf32 (pf31 je prvn�), jej� z�znamy byly posunuty o rok zp�t:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

N�sledn� byly tabulky spojeny skrze 'INNER JOIN,' aby byly odstran�ny ne��douc� 'NULL' z�znamy. V�sledky byly pot� seskupeny podle roku:

'GROUP BY pf31.price_year'

Vno�en� dotaz v pomocn� tabulky 'pf3' je nyn� hotov a zobrazuje n�m dva sloupce s nezaokrouhlen�mi pr�m�rn�mi cenami potravin pro jednotliv� roky, kde jeden ze sloupc� z�znamy posunuty o rok zp�t, aby bylo mo�no n�sledn� vypo��tat meziro�n� rozd�ly.

Tabulka 'pf3' byla posl�ze p�es 'INNER JOIN' p�ipojena k tabulce 'pf' skrze spole�n� roky:

'ON pf.payroll_year = pf3.price_year'

Pozn�mka: 'INNER JOIN' zde zajist�, �e kone�n� v�stupy budou omezeny jen na spole�n� srovnateln� obdob� cen a mezd (2006�2018).

Pozn�mka: obdobn� jako v p�edchoz� �loze byly byla ��st v�po�t� (zpr�m�rov�n� a seskupen�) provedeno ji� v r�mci pomocn�ch tabulek, aby byla rychlost zpu�t�n� kone�n�ho dotazu zrychlena.

Nyn� kdy� byly duplicitn� tabulky 'pf2' a 'pf3' p�ipojeny, p�ich�z� �ada na p�ipojen� sekund�rn� tabulky (t_roman_zavorka_project_sql_secondary_final) 'sf,' obsahuj�c� hodnoty ohledn� v�voje HDP v letech:

Proto�e v�po�ty procentu�ln�ch meziro�n�ch rozd�l� HDP jsou pom�rn� jednoduch� (nen� pot�eba po��tat pr�m�ry ani data seskupovat), byly vypo�teny p��mo ve vno�en�m dotazu skrze n�sleduj�c� sloupce:
* sf11.`year`
* round((sf11.gdp - sf12.gdp) / sf12.gdp*100,2) AS annual_percentage_hdp_difference

Pro v�po�et procentu�ln�ho meziro�n�ho rozd�lu HDP bylo v�ak nutn� prve p�ipojit pomocnou duplicitn� tabulku 'sf12' ('sf11' je prvn� z tabulek):
* country
* `year`
* gdp

proto�e tabulka obsahuje data pro r�zn� evropsk� zem�, byly z�znamy omezeny pouze na �R:

"WHERE country = 'Czech republic'"

Vnit�n� tabulka 'sf12' obsahuj�c� hodnoty HDP v letech pro �R byla posl�ze p�ipojena k tabulce 'sf11' p�es 'INNER JOIN' skrze spole�n� roky a n�zvy zem�, p�i�em� z�znamy v 'sf12' byly posunuty o rok zp�t:

'ON sf11.`year` = sf12.`year` +1 AND sf11.country = sf12.country'

'INNER JOIN' zde zajist� vyfiltrov�n� ne��douc�ch pr�zdn�ch hodnot.

V tomto bod� je vno�en� dotaz pro tabulku 'sf' hotov a jeho spu�t�n�m se n�m zobr�z� procentu�ln� meziro�n� rozd�ly HDP pro �R. Tabulka 'sf' byla posl�ze skrze 'INNER JOIN' (lze i LEFT JOIN) p�ipojena k tabulce 'pf' skrze spole�n� roky:

'ON pf.payroll_year = sf.`year`'

D�le, kdy� byly t�i podp�rn� tabulky p�ipojeny, byly n�sledn� v hlavn� 'SELECT' klauzuli nastaveny sloupce pro vypo�ty procentu�ln�ch meziro�n�ch rozd�l� pro mzdy, ceny a hdp v letech:
* concat(pf.payroll_year," � ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* sf.gdp_annual_difference (vypo�et ji� p�ipojen� tabulce)

Aby se ve�ker� v�po�ty seskupily podle jednotliv�ch let (byl zvolen sloupec 'pf.payroll_year'), byla klauzule 'GROUP BY' pro hlavn� dotaz 'pf' nastavena n�sledovn�:

'GROUP BY pf.payroll_year'

Dle stejn�ho sloupce byly v�sledn� z�znamy se�azeny sestupn� podle let:

'ORDER BY pf.payroll_year DESC'

V tomto bod� n�m dosavadn� dotaz zobrazuje tabulku kter� n�m ukazuje v�vjoj procentu�ln�ho vyj�d�en� rozd�l� pr�m�rn�ch mezd a cen potravin a HDP mezi lety. Ji� v tomto zobrazen� je mo�n� vid� ur�it� vztah mezi v�vjem HDP a v�vojem mezd a cen. Abychom v�ak tento vztah mohli l�pe posoudit, byl n�sledn� vypo�ten tak� p�ehled o tom, jak se vyv�j� rychlost r�stu �i poklesu mezi lety - jin�mi slovy rozd�l z meziro�n�ch procentu�ln�ch rozd�l�.

Abychom toho dos�hli, byl n� dosavadn� dotaz vno�en do nov�ho 'vn�j��ho' dotazu do klauzule 'FROM', kde vno�en� dotaz jsme pojmenovali jako 'pf4.' N�sledn� byla skrze 'LEFT JOIN' p�ipojna kopie na�eho vno�en�ho dotazu kterou jsme pojmenovali 'pf5.' Do obou dotaz� 'pf4' a 'pf5' bylo vlo�en pomocn� sloupec 'pf.payroll_year,' kter� pou�ijeme pro vz�jemn� propojen� t�chto dotaz�, p�i�em� z�znamy 'pf5' byly posunuty o rok zp�t:

'ON pf4.payroll_year = pf5.payroll_year +1'

'LEFT JOIN' byl pou�it, aby nebyl vymazan z�znam v prvn�m roce, kde chyb� v�sledek ve v�po�tu zm�ny v rychlosti r�stu.

Nyn� kdy� byly tyto tabulky propojeny, byly v hlavn� 'SELECT' klauzuli vybr�ny n�sleduj�c� sloupce:
* time_period
* pf4.annual_percentage_salary_difference
* pf4.annual_percentage_salary_difference-pf5.annual_percentage_salary_difference AS annual_percentage_salary_growth_difference
* pf4.annual_percentage_price_difference
* pf4.annual_percentage_price_difference-pf5.annual_percentage_price_difference AS annual_percentage_price_growth_difference
* pf4.annual_percentage_gdp_difference

Pozn�mka: v�po�et zm�ny v r�stu HDP se neuk�zal b�t jako p��nosn� a tak byl vylou�en.

A�koliv je v�sledn� dotaz ve srovn�n� s p�edchoz�mi dotazy pom�rn� velk�, jeho spu�t�n� je rychl�.

T�mto je dotaz pro ot�zku �. 5 dokon�en. V�sledkem je v�pis procentu�ln�ho vyj�d�en� meziro�n�ch zm�n ve v��i mezd, cen potravin a HDP mezi lety a rovn� rozd�ly v procentu�ln�ch p��r�stc�ch (zm�ny v rychlosti r�stu �i poklesu) mezi lety.

## V�SLEDKY
### OT�ZKA �. 1
Rostou v pr�b�hu let mzdy ve v�ech odv�tv�ch, nebo v n�kter�ch klesaj�?

Podle dosavadn�ch dat existuj� pouze �ty�i odv�tv�, ve kter�ch mzdy nep�eru�ovan� rostly:
* Doprava a skladov�n�
* Ostatn� �innosti
* Zdravotn� a soci�ln� p��e
* Zpracovatelsk� pr�mysl

Ve valn� v�t�in� n�mi zkouman�ch odv�tv� byly pozorov�ny poklesy r�zn�ch v���. V�t�inou �lo o n�razov�, kr�tkodob� poklesy (zejm�na v roce 2013), po nich� v�ak mzdy op�t za�aly stoupat:
* Administrativn� a podp�rn� �innosti
* �innosti v oblasti nemovitost�
* Informa�n� a komunika�n� �innosti	
* Pen�nictv� a poji��ovnictv�	
* Profesn�, v�deck� a technick� �innosti	
* T�ba a dob�v�n�
* Ubytov�n�, stravov�n� a pohostinstv�
* Velkoobchod a maloobchod; opravy a �dr�ba motorov�ch vozidel: 
* V�roba a rozvod elekt�iny, plynu, tepla a klimatiz. vzduchu 
* Z�sobov�n� vodou; �innosti souvisej�c� s odpady a sanacemi

Pozorujeme i n�kolik odv�tv�, u nich� lze i mimo jin� post�ehnout postupn� pokles stoup�n� a n�sledn� sni�ov�n� mezd na konci obdob�, pro kter� jsou data k dispozici; tedy nemus� se jednat jen o n�razov� pokles, ale m��e doj�t k del��mu poklesu ve v��i mezd v budouc�ch letech:
* Kulturn�, z�bavn� a rekrea�n� �innosti
* Stavebnictv� 	
* Ve�ejn� spr�va a obrana; povinn� soci�ln� zabezpe�en�
* Vzd�l�v�n�
* Zem�d�lstv�, lesnictv�, ryb��stv�
### OT�ZKA �. 2
Kolik je mo�n� si koupit litr� ml�ka a kilogram� chleba za prvn� a posledn� srovnateln� obdob� v dostupn�ch datech cen a mezd?

V prvn�m srovnateln�m obdob�, tedy v roce 2006 byla pr�m�rn� �ist� mzda 16 044 K� a Kg chleba st�l v pr�m�ru 16.12 K� a l ml�ka 14.44 K�. 

V druh�m srovnateln�m obdob� v roce 2018 dosahovala pr�m�rn� �ist� mzda 24 486 K�. Pr�m�rn� cena za Kg chleba byla 24.24 K� a za l ml�ka 19.82 K� 

Za danou v�platu bylo v roce 2006 mo�no tedy nakoupit 995.29 Kg chleba a 1111.08 l ml�ka, zat�mco za v�platu v roce 2018 to bylo 1010.15 Kg chleba a 1235.42 l ml�ka; tud� v druh�m srovnateln�m obdob� bylo mo�no t�chto dan�ch potravin nakoupit v�ce.

### OT�ZKA �. 3
Kter� kategorie potravin zdra�uje nejpomaleji (je u n� nejni��� percentu�ln� meziro�n� n�r�st)?

Ve v�sledc�ch m��eme vid�t, �e v pr�m�ru ceny valn� v�t�iny potravin zdra�uj�; v�jimkou jsou 'krystalov� cukr' a 'rajsk� jablka �erven� kulat�,' kter� naopak v pr�m�ru ro�n� slev�uj� o -1.92 % a -0.74 %. 

Podle dosavadn�ch dat jsou tedy hypoteticky "nejpomaleji zdra�uj�c�mi" potravinami 'Ban�ny �lut�', kter� v pr�m�ru ro�n� zdra�uj� jen o 0,81 % a za nimi Vep�ov� pe�en� s kost� 0.99 % ro�n�. 

Naopak v pr�m�ru nejrychleji se zdra�uj�c� potravinou se zdaj� b�t 'Papriky': 7.29 % ro�n� a d�le M�slo: 6.68 % 

### OT�ZKA �. 4
Existuje rok, ve kter�m byl meziro�n� n�r�st cen potravin v�razn� vy��� ne� r�st mezd (v�t�� ne� 10 %)?

Z dosavadn�ch v�sledk� vych�z� najevo, �e nejv�t�� n�r�st cen oproti r�stu mezd byl zaznamen�n mezi lety 2013�2012, kde ceny vzrostly o 5,1 % zat�mco mdzy naopak klesly o -1,56 %, celkov� rozd�l je tedy 6.66 % ve prosp�ch zdra�ov�n�. V ��dn�m roce tedy rozd�ly nedos�hly ani 10 %. 

Naopak nejni���, respektive nejv�t�� rozd�l ve prosp�ch mezd byl zaznamen�n mezi lety 2009�2008, kde mdzy vzrostly o 3,16 % zat�mco ceny potravin klesly o -6,42 % a celkov� rozd�l je tedy -9,58 % ve prosp�ch mezd.

V obdob� 2010�2009 bylo nav��ov�n� mezd ve stejn� m��e jako zdra�ov�n� potravin: 1.95 %.

D�le m��eme tak� post�ehnout, �e v t�chto datech je rok 2013 jedin� rok, kdy pr�m�rn� ro�n� procentu�ln� rozd�l mezd dos�hl negativn�ch hodnot; toto podporuj� tak� v�sledky v �loze �. 1 kde ve valn� v�t�in� odv�tv� byl v tomto roce zaznamen�n pokles v pr�m�rn�ch mzd�ch.

### OT�ZKA �. 5
M� v��ka HDP vliv na zm�ny ve mzd�ch a cen�ch potravin? Neboli, pokud HDP vzroste v�razn�ji v jednom roce, projev� se to na cen�ch potravin �i mzd�ch ve stejn�m nebo n�sduj�c�m roce v�razn�j��m r�stem?

Pod�v�meli se na zm�ny HDP v letech, m��eme vid�t, �e po v�t�inu let HDP roste, v�jimkou jsou v�ak obdob� mezi lety 2009�2008 kde byl zaznamen�n pom�rn� v�razn� pokles -4.66 % a tak� men�� poklesy -0,79 % a -0,05 % v obdob�ch 2012�2011 a 2013�2012.

Porov�meli v�voj HDP a v�voj cen potravin, m��eme v n�kter�ch bodech post�ehnout, �e se ceny vyv�jej� podobn� jako HDP, zejm�na v letech 2007, 2008, a 2009, kde rust HDP zpomaluje a pot� kles� (-4.66 %) a stejn� tak ceny potravin (-6,42 %). Posl�ze v letech 2010 a 2011, kdy� HDP op�t za��n� r�st, rostou rovn� i ceny.

Zm�na v�ak nast�v� v obdob�ch 2012�2011 a 2013�2012, kde HDP op�t av�ak m�rn�ji kles� (-0,05 % a -0,79 %) -> prve za��n� klesat p��r�st cen potravin a a� v obdob�ch 2015�2014 a 2016�2015 doch�z� k poklesu cen potravin (-0,55 % a -1,19 %), zat�mco HDP touto dobou ji� zase stoup�. Po t�chto opo�d�n�ch poklesech ceny potravin op�t za��naj� r�st, nicm�n� rychlost r�stu zvl�tn� osciluje.
�
Podobn� jako u cen potravin lze u mezd vid�t ur�itou reakci na v�voj HDP, av�ak se nezd� b�t tolik viditeln�. Mzdy a� na obdob� 2013�2012 neus�le rostou.

V obdob� 2009�2008, kdy byl nejv�t�� pokles v HDP (-4.66 %), do�lo u mezd v tomto a n�sleduj�c�m obdob� pouze k poklesu rychlosti r�stu (-4,71 % a -1,21 %), kter� posl�ze zase za�ala zvedat. Pokles ve v��i mezd byl pozorov�n a� v obdob� 2013�2012, kdy mzdy poklesly o -1,56 %, kdy v tomto a p�edch�zej�c�m obdob�m byly pozorov�ny v podstat� jen m�rn� poklesy v HDP (-0,05 % a -0,79 %) a je tedy ot�zkou, zda tento pokles ve mzd�ch byl zp�soben t�mito dv�ma m�rn�j��mi poklesy nebo zda jde o zpo�d�nou reakci na siln� pokles HDP z obdob� 2009�2008. V n�sleduj�c�ch letech, kdy HDP op�t za�alo stoupat a zrychlovat v r�stu, za�aly zrychlovat v r�stu i mdzy.

Z dosavatn�ch dat se zd�, �e m�ra r�stu �i poklesu HDP ovliv�uje v�voj cen a mezd, tedy pokud HDP v�razn� klesne �i vzroste, je velmi pravd�podobn�, �e dojde k poklesu �i vzr�stu ve mzd�ch a cen�ch potravin nebo alespo� ke zm�n� rychlosti r�stu �i kles�n�, av�ak tento efekt m��e nastat a� po ur�it� dob�. 

