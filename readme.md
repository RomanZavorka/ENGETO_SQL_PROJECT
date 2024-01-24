# SQL PROJEKT

## ZAD�N�
"Na va�em analytick�m odd�len� nez�visl� spole�nosti, kter� se zab�v� �ivotn� �rovn� ob�an�, jste se dohodli, �e se pokus�te odpov�d�t na p�r definovan�ch v�zkumn�ch ot�zek, kter� adresuj� dostupnost z�kladn�ch potravin �irok� ve�ejnosti. Kolegov� ji� vydefinovali z�kladn� ot�zky, na kter� se pokus� odpov�d�t a poskytnout tuto informaci tiskov�mu odd�len�. Toto odd�len� bude v�sledky prezentovat na n�sleduj�c� konferenci zam��en� na tuto oblast.

Pot�ebuj� k tomu od v�s p�ipravit robustn� datov� podklady, ve kter�ch bude mo�n� vid�t porovn�n� dostupnosti potravin na z�klad� pr�m�rn�ch p��jm� za ur�it� �asov� obdob�.

Jako dodate�n� materi�l p�ipravte i tabulku s HDP, GINI koeficientem a populac� dal��ch evropsk�ch st�t� ve stejn�m obdob�, jako prim�rn� p�ehled pro �R.

Datov� sady, kter� je mo�n� pou��t pro z�sk�n� vhodn�ho datov�ho podkladu
Prim�rn� tabulky:

czechia_payroll � Informace o mzd�ch v r�zn�ch odv�tv�ch za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R.
czechia_payroll_calculation � ��seln�k kalkulac� v tabulce mezd.
czechia_payroll_industry_branch � ��seln�k odv�tv� v tabulce mezd.
czechia_payroll_unit � ��seln�k jednotek hodnot v tabulce mezd.
czechia_payroll_value_type � ��seln�k typ� hodnot v tabulce mezd.
czechia_price � Informace o cen�ch vybran�ch potravin za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R.
czechia_price_category � ��seln�k kategori� potravin, kter� se vyskytuj� v na�em p�ehledu.
��seln�ky sd�len�ch informac� o �R:

czechia_region � ��seln�k kraj� �esk� republiky dle normy CZ-NUTS 2.
czechia_district � ��seln�k okres� �esk� republiky dle normy LAU.
Dodate�n� tabulky:

countries - V�emo�n� informace o zem�ch na sv�t�, nap��klad hlavn� m�sto, m�na, n�rodn� j�dlo nebo pr�m�rn� v��ka populace.
economies - HDP, GINI, da�ov� z�t�, atd. pro dan� st�t a rok.
V�zkumn� ot�zky
Rostou v pr�b�hu let mzdy ve v�ech odv�tv�ch, nebo v n�kter�ch klesaj�?
Kolik je mo�n� si koupit litr� ml�ka a kilogram� chleba za prvn� a posledn� srovnateln� obdob� v dostupn�ch datech cen a mezd?
Kter� kategorie potravin zdra�uje nejpomaleji (je u n� nejni��� percentu�ln� meziro�n� n�r�st)?
Existuje rok, ve kter�m byl meziro�n� n�r�st cen potravin v�razn� vy��� ne� r�st mezd (v�t�� ne� 10 %)?
M� v��ka HDP vliv na zm�ny ve mzd�ch a cen�ch potravin? Neboli, pokud HDP vzroste v�razn�ji v jednom roce, projev� se to na cen�ch potravin �i mzd�ch ve stejn�m nebo n�sduj�c�m roce v�razn�j��m r�stem?
V�stup projektu
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
* calculation_code - k�d zp�sobu v�po�tu
* industry_branch_code - k�d pr�myslov�ho odv�tv�
* payroll_year
* payroll_quarter

K t�to tabulce se v�e n�kolik dopl�uj�c�ch tabulek:
* Czechia_payroll_calculation - ��seln�k kalkulac� v tabulce mezd
* czechia_payroll_industry_branch � ��seln�k odv�tv� v tabulce mezd.
* czechia_payroll_unit � ��seln�k jednotek hodnot v tabulce mezd.
* czechia_payroll_value_type � ��seln�k typ� hodnot v tabulce mezd.

czechia_price -  Informace o cen�ch vybran�ch potravin za n�kolikalet� obdob�. Datov� sada poch�z� z Port�lu otev�en�ch dat �R. Tato tabulka sest�v� z 6 sloupc�:
* id
* value - pr�m�rn� ceny pro jednotliv� kategorie potravin
* category_code - k�d kategorie potravin
* date_from
* date_to
* region_code - k�d regionu (kraje)

K t�to tabulce se v�ou tak� n�sleduj�c� podp�rn� tabulka:
* czechia_price_category � ��seln�k kategori� potravin, kter� se vyskytuj� v na�em p�ehledu
* czechia_region � ��seln�k kraj� �esk� republiky dle normy CZ-NUTS 2.

V tabulce czechia_payroll m��eme vid�t, �e se zde nach�z� velk� mno�stv� sloupc�, ve kter�ch jsou jen pouh� k�dy, kter� n�m nic ne��kaj� - tyto k�dy jsou pops�ny v navazuj�c�ch ��seln�c�ch. 

N�kter� ��seln�ky byly pou�ity jednou: *czechia_payroll_value_type - nastaven� value_type_code, aby byly zobrazeny jen v��e mezd (5958)
* czechia_payroll_unit - zji�t�n�, v jak�ch jendotk�ch jsou hodnoty ve sloupci 'value' vyj�d�eny.

Dv� tabulky byly p�ipojeny trvale: 
* czechia_price_category - identifikace kategori� potravin a a jejich jednotek mno�stv�
*czechia_payroll_industry_branch - identifikace pr�myslov�ho odv�tv�.

n�kter� v�bec: 
* czechia_payroll_calculation - zp�sob kalkulace hodnot pro n�s nen� d�le�it�

### PROBLEMATIKA TVORBY PRIM�RN� TABULKY

Podstatou tvorby prim�rn� tabulky je slou�en� tabulek czechia_payroll a czechia_price (a p��padn� jejich n�vazn� tabulky - ��seln�ky) do jedn� tabulky skrze stejn� porovnateln� obdob�, tedy spole�n� roky, ze kter� bude mo�n� �erpat data ohledn� mezd a cen potravin za �eskou republiku pro pln�n� n�sleduj�c�ch �loh - v�deck�ch ot�zek.

Ob� dv� tabulky obsahuj� velk� mno�stv� informac�, kter� jsou d�le pops�ny v navazuj�c�ch podp�rn�ch tabulk�ch - ��seln�c�ch. Prvn�m krokem tedy bylo se s tabulkami sezn�mit a zjistit co obsahuj� a dle zad�n� zv�it, kter� data jsou pro n�s d�le�it� a kter� ne. V obou dabulk�ch m��eme vid�t, �e se zde nach�z� n�kolik sloupc�, ve kter�ch jsou jen pouh� k�dy, kter� n�m nic ne��kaj� - tyto k�dy jsou pops�ny v navazuj�c�ch ��seln�c�ch. 

N�kter� ��seln�ky byly pou�ity jednou: * czechia_payroll_value_type - 'nastaven� value_type_code', aby byly zobrazeny jen v��e mezd (k�d 5958)
* czechia_payroll_unit - zji�t�n�, v jak�ch jednotk�ch jsou hodnoty ve sloupci 'value' vyj�d�eny (pro mzdy to jsou �esk� koruny).

Dv� tabulky byly p�ipojeny trvale: 
* czechia_price_category - identifikace kategori� potravin a jejich jednotek mno�stv�
*czechia_payroll_industry_branch - identifikace pr�myslov�ho odv�tv�.

n�kter� v�bec: 
* czechia_payroll_calculation - zp�sob kalkulace hodnot pro n�s nen� d�le�it�
* czechia_region � data byla zpracov�v�na celkov� za �R; identifikace kraj� pro n�s tedy nem�la v�znam.

Po sezn�men� se s obsahem tabulek bylo v r�mci tvorby pr�marn� tabulky nutno zdolat n�kolik p�ek�ek. Jednou z p�ek�ek byl obsah nepot�ebn�ch z�znam� a hodnot. Tabulka czechia_payroll obsahuje krom� z�znam� ohledn� hrub�ch mezd tak� z�znamy o pr�m�rn�ch po�tech zam�stnanc� v odv�tv�ch - takov� hodnoty n�s zde nezaj�maj� a tak byly vy�azeny. Z�rovne� byly vylou�eny hodnoty o mzd�ch, u nich� nebyla uvedena informace o odv�tv�, co� pova�ujeme za z�sadn�. 'NULL' hodnoty co se t��e mezd pozorov�ny nebyly.

V tabulce czechia price byly pozorov�ny 'NULL' hodnoty pouze v sloupci region_code, proto�e v�ak data v tomto projektu jsou zpracov�v�na celkov� pro �R, nep�edstavuj� tyto chybjej�c� informace o regionu probl�m. V tabulce czechia_price ��dn� hodnoty vy�azeny nebyly.

Dal��m probl�mem byla obs�hlost tabulek, zejm�na 'czechia_price', kter� m� celkem 108,249 z�znam�. 'czechia_payroll' m�la po odstran�n� nepot�ebn�ch z�znam� 3,268 z p�vodn�ch 6,880. Z�znamy obou tabulek proto byly zpr�m�rov�ny a seskupeny (podle roku a odv�tv�/kategorie potravin), ��m� se jejich rozsah v�razn� zmen�il: 'czechia_payroll' na 418 a czechia_price na 342. S takto zmen�en�mi rozsahy budou ve�ker� operace s t�mito tabulkami v�razn� rychlej�� a jejich data se daj� sn�ze ��st. 

Dal�� p�ek�kou bylo tak� nalezen� zp�sobu, jak data dvou tabulek v budoucnu p�rovat. Tabulky jsou na sobe v podstat� nez�visl�, a jedin�m spole�n�m rysem byl �daj o �ase m��en� - rok. V tabulce czechia_payroll tento �daj obsahoval sloupec 'payroll_year.' V tabulce czechia_price to byly sloupce 'date_to' a 'date_from', kter� obsahovaly cel� datum, kde rok by v obou sloupc�ch v�dy shodn�, a tak mohl b�t pou�it kter�koliv z nich.

D�le je nutno post�ehnout, �e tabulky se nemaj� shodn� rozsah let, pro n� dan� z�znamy plat�: tabulka czechia_payroll obsahuje z�znamy v letech 2000�2021, zat�mco tabulka czechia_price pouze v letech 2006�2018. Tabulky lze tedy vz�jemn� srovn�vat pouze mezi lety 2006 a 2018.

Krom� omezov�n� z�znam� (��dk� ) bylo na�� snahou omezovat rovn� po�ty sloupc�, kde v tabulce czechia_payroll byly nakonec vybr�ny pouze t�i sloupce obsahuj�c� n�sleduj�c� informaci:
* �daj o roku - payroll_year
* n�zvu odv�tv� - cpib.name (z ��seln�ku czechia_payroll_industry_branch)
* �daj o v��i pr�m�rn� hrub� mzdy - value (posl�ze zpr�m�rov�n a zaokrouhlen)

V tabulce czechia_price:
* �daj o roku -(year(date_from)) 
* �d�j o v��i ceny potravin - value (posl�ze zpr�m�rov�n a zaokrouhlen). Pozn�mka: nen� jasn� definov�no, v jak�ch jednotk�ch jsou zde ceny potravin uvedeny - p�edpokl�d�me, �e jsou v �esk�ch korun�ch.
* n�zvu kategorie potravin (z ��seln�ku czechia_price_category) 
* udaj o mno�stv� pro kter� ceny plat� (z ��seln�ku czechia_price_category) - vznikl spojen�m sloupc� 'price_value' a 'price_unit' skrze concat().

Vybran� sloupce byly posl�ze v p��pad� pot�eby p�ejmenov�ny, aby aby se p�ede�lo probl�mu duplicitn�ch n�zv� a aby bylo jasn�, co obsahuj�.

Proto�e data dvou tabulek na sebe krom� spole�n�ch let nemaj� p��mou n�vaznost, zp�sob propojen� skrze klauzuli 'JOIN' se nejevil jako vhodn�, proto�e v�echny z�znamy z jedn� tabulky by se nav�zaly na z�znamy se shodn�m rokem v tabulce druh�, tud� by do�lo ke zbyte�n�mu nadbyt� (duplicit�m) z�znam�, ��m� by byla zma�ena na�e snaha o zredukov�n� dat na absolutn� minimum.

Propojen� dvou zm�n�n�ch tabulek bylo tud� provedeno skrze klauzuli 'UNION.' T�mto zp�sobem jsou tabulky spojeny nikoliv z boku ale zespoda, ��m� nedoch�zelo k duplicit�m z�znam�. 

Jeliko� skrze 'UNION' lze spojit pouze z�znamy se stejn�mi po�ty sloupc�, bylo nutn� po�ty sloupc� vyrovnat. V na�em p��pad� toho bylo dosa�eno vlo�en�m pomocn�ch 'NULL' sloupc� obsahuj�c�ch pr�zdn� hodnoty. 

Tyto 'NULL' sloupce byly do obou tabulek vlo�eny tak, aby z�znamy obou tabulek m�ly sv� vlastn� separ�tn� sloupce (bl�e pops�no v 'postupu').  

### ROZBOR V�SLEDN� PRIM�RN� TABULKY

V�sledkem na�eho �sil� je tabulka s rozsahem 760 z�znam� a celkem 7 slupci:
* payroll_year - informace o roku, pro kter� z�znamy o mzd�ch plat�
* industry_branch_name - n�zev pr�myslov�ho odv�tv�
* mean_salary_czk - pr�m�rn� hrub� mzda podle roku a odv�tv�
* price_year - informace o roku, pro kter� z�znamy o cen�ch potravin plat� 
* foodstuff_name - n�zev kategorie potravin
* mean_price_czk - pr�m�rn� cena podle roku a kategorie potravin 
* price_unit - jednotka mno�stv�, na kter� se z�zanmy o cen�ch potravin vztahuj�.

Z�znamy tabulky n�m prozrazuj� pr�m�rn� hrub� mzdy podle roku a pr�myslov�ho odv�tv� v letech 2000�2021 a tak� pr�m�rn� ceny podle roku a kategorie potravin.

Proto�e tabulky byly propojeny skrze 'UNION' a do separ�tn�ch sloupc�, m��eme vid�t, �e tabulka obsahuje mnoho pr�zdn�ch z�znam�, tedy kdy� se d�v�me na z�znamy z tabulky 'czechia_payroll', z�znamy z tabulky 'czechia_price' jsou pr�zdn� a naopak.

 


## POSTUP
### VYTVO�EN� PRIM�RN� TABULKY
#### �VOD

Prim�rn� tabulka t_roman_zavorka_project_sql_primary_final obsahuj�c� data z obou tabulek byla vytvo�ena skrze klauzuli 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' kde 'CREATE' tabulku vytv��� a v p��pad�, �e tabulka s t�mto n�zvem ji� existuje, aktivuje se p��kaz 'REPLACE,' kter� st�vaj�c� tabulku nahrad� novou, co� v p��pad� pot�eby umo��uje tabulku snadno upravovat. Tabulka byla v na�em p��pad� vytvo�ena skrze SQL dotazu za klauzul� 'AS.'
 
Jak bylo ji� pops�no v��e, vytvo�en� v�sledn� tabulky bylo provedeno skrze slou�en� dvou samostatn�ch SQL dotaz� klauzul� 'UNION.'; jeden pro tabulku czechia_payroll a druh� pro tabulku czechia_price.
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

Skrze dotaz: 'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)' zj�st�me, �e oba datumy jsou v�dy ve stejn�m roce, a tak je mo�no pou��t kter�koliv z t�chto dvou sloupc�; v na�em p��pad� byl pou�it sloupec date_from: 

* year(date_from) AS price_year

* Jako dal�� byl zvolen sloupec z p�ipojen� tabulky czechia_price_category (cpc) ud�vaj�c� n�zev kategorie potravin: cpc.name AS foodstuff_name - (tud� sloupec cpr.category_code ji� nad�le nepot�ebujeme).

* Obdobn�m zp�sobem provedeme zpr�m�rov�n� a zaokrouhlen� hodnot v sloupci cpr.value jako v tabulce czechia_payroll: round(avg(cpr.value),2) AS mean_price_czk.

* Posledn�m sloupcem t�to tabulky vznikl slou�en�m sloupc� 'cpc.price_value' a 'cpc.price_unit' z p�ipojen� tabulky czechia_price_category (cpc) funkc� concat(): concat(cpc.price_value," ",cpc.price_unit) AS price_unit. Tento sloupec ud�v� mno�stv�, ke kter�mu se v�ou ceny jednotliv�ch kategori� potravin (nap�. cena za 0,5 l piva).

Obdobn� jako v tabulce czechia_payroll je i zde velmi mnoho z�znam�, a tak byly i zde byly hodnoty o cen�ch potravin zpr�m�rov�ny a seskupeny skrze klauzuli 'GROUP BY' podle roku a kategorie potravin: 

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

T�mto byl vy�e�en probl�m s nestejn�m po�tem sloupc� a z�rove� do�lo k separaci sloupc� obou tabulek. Pot� ji� bylo pot�eba zabalit dotazy dvou tabulek do z�vorek a spojit klauzul� 'UNION,' ��m� je SQL dotaz pro zobrazen� v�ech pot�ebn�ch polo�ek obou tabulek dokon�en (mo�no prov�st t� p�es 'UNION ALL', nicm�n� v�sledek zde bude stejn�).


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

Zobrazen� sloupc� v p�ipojen� tabulce bylo skrze vno�en� dotaz omezeno rok, pr�m�rn� ceny potravin, n�zev kategorie potravin a jednotky mno�stv�:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name
* pf.price_unit

V �loze je d�no, �e v�po�ty maj� b�t provedeny pro prvn� a posledn� srovnateln� obdob� a pouze pro kategorie potravin 'ml�ko' a 'chl�b.'

Pozn�mka: tabulka czechia_payroll obsahuje z�znamy z let 2000�2021 a tabulka czechia_price 2006�2018, prvn�m srovnateln�m obdob�m je tedy rok 2006 a posledn�m je rok 2018.

Z�znamy ve vno�en�m dotazu byly tedy skrze klauzuli 'WHERE' omezeny n�sledovn�:

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%ml�ko%' OR pf.foodstuff_name LIKE '%chl�b%'"

Tyto podm�nky zajist�, �e se zobraz� pouze z�znamy v letech 2006 a 2018 a z�rov�� zobraz� pouze kategorie potravin, kter� maj� ve sv�m n�zvu 'ml�ko' nebo 'chl�b.'

Vno�en� dotaz je t�mto dokon�en a jeho spu�t�n�m se n�m zobraz� tabulka se 4 sloupci a 4 z�znamy: pr�m�rn� ceny pro 1 kg chleba a 1 l ml�ka v letech 2006 a 2018.

Tabulka byla n�sledn� propojena skrze spole�n� roky:

'ON pf.payroll = pf2.price_year'

Pro propojen� byla zvolena klauzule 'INNER JOIN' aby ve�ker� z�znamy byly omezeny jen na vybran� roky a vybran� potraviny v p�ipojen� pomocn� tabulce pf2.

Pozn�mka: omezen�m z�znam� v p�ipojen� tabulce pf2 skrze vno�en� dotaz se vyrazn� urychluje spu�t�n� cel�ho SQL dotazu.

Do vnej�� 'SELECT' klauzule byly n�sledn� p�id�ny sloupce ohledn� cen potravin a v�po�et potenci�ln�ho mno�stv� vybran�ch potravin, kter� by bylo mo�n� za pr�m�rn� mzdy nakoupit. Uspo��d�n� sloupc�
nyn� vypadalo n�sledovn�:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS total_mean_salary_czk
* pf.foodstuff_name
* pf.mean_price_czk
* round(avg(pf.mean_salary_czk)) / pf2.mean_price_czk,2) AS possible_purchase_amount
* pf.price_unit

Pozn�mka: hodnoty ohledn� mezd jsou zde uvedeny jako hrub� mzdy, pro zjednodu�en� v�po�tu s nimi budeme zde nakl�dat jako s �ist�mi mzdami.

Proto�e do 'SELECT' klauzule byly p�id�ny sloupce t�kaj�c� se cen potravin, bylo nutn� rovn� prov�st �pravu v 'GROUP BY' klauzuli p�id�n�m sloupce 'pf2.foodstuff_name', aby se z�znamy seskupily prvotn� podle roku a druhotn� podle kategorie potravin:

'GROUP BY pf.payroll_year, pf2.foodstuff_name'

Kone�n� v�stup byl n�sledn� se�azen sestupn� podle roku a vzestupn� podle n�zvu kategorie potravin:

'ORDER BY pf.payroll_year DESC, pf2.foodstuff_name ASC'

T�mto je SQL dotaz pro ot�zku �. 2 dokon�en.

### �LOHA �. 3: 
#### V�PO�ET RO�N�CH ROZD�L� CEN POTRAVIN
Aby bylo mo�n� zjistit, jak se ceny potravin mezi lety vyv�jely, byly z pr�m�rn�ch ro�n�ch cen jednotliv�ch potravin vypo�teny ro�n� rozd�ly; postup v tomto p��pad� byl podobn� jako v �loze �. 1.

Z prim�rn� tabulky 'pf' byly skrze 'SELECT' klauzuli vybr�ny sloupce uv�d�j�c� informaci ohledn� roku, n�zvu kategorie potravin a pr�m�rn� ceny:
* pf.price_year
* pf.foodstuff_name
* pf.mean_price_czk
Pro v�po�et meziro�n�ch roz�l� byla n�sledn� p�ipojena duplicitn� tabulka 'pf2', kde skrze vno�en� dotaz ('SELECT') byly vybr�ny stejn� sloupce jak v na�� hlavn� tabulce 'pf.' a z�rove� byly vy�azeny pr�zn� z�znamy, kter� v prim�rn� tabulce vznikly p�i jej� tvorb� skrze slou�en� tabulek czechia_payroll a czechia_ price p�es 'UNION.':

'WHERE mean_price_czk IS NOT NULL'

Tabulky byly propojeny skrze shodn� kategorie potravin a roky, kde v p�ipojen� tabulce byl p�ipo�ten rok nav�c, ��m� se z�znamy v n� posunuly o rok zp�t:

'ON pf.price_year = pf2.price_year +1 AND pf.foodstuff_name = pf2.foodstuff_name

Tabulka byla p�ipojena skrze 'INNER JOIN', aby z n� byly odstran�ny ne��douc� z�znamy S NULL hodnotami plynouc�ch z posunu z�znam� - z�znamy p�ed rokem 2006 nem�me k dispozici. Z�rove� t�m  byly odstran�ny pr�zdn� hodnoty vznikl� p�i vzniku tabulky (pf) tabulce spojen�m cp a cpr skrze 'UNION').

Po �sp�n�m p�ipojen� tabulky pf2 byly ve vnej�� 'SELECT' klauzuli provedeny n�sleduj�c� zm�ny v uspo��d�n� zobrazovan�ch sloupc�:
* concat(pf.price_year," � ", pf2.price_year) AS time_period
* pf.foodstuff_name,
* pf.mean_price_czk AS latter_mean_price_czk
* pf2.mean_price_czk AS former_mean_price_czk
* round((pf.mean_price_czk - pf2.mean_price_czk) / pf2.mean_price_czk*100,2) AS percentage_price_difference

V��e uveden� v�b�r n�m nyn� zobrazuje pr�m�ry a meziro�n� rozd�ly pr�m�r� cen potravin mezi lety. Z�znamy byly posl�ze prim�rn� se�azeny sestupn� podle roku m��en� a pot� vzestupn� podle n�zvu potravin v prvn� tabulce:

'ORDER BY pf.price_year DESC, pf.foodstuff_name ASC'

Jeliko� hodnoty t�kaj�c� se cen potravin byly zpr�m�rov�ny a seskupeny podle roku a kategorie potravin ji� p�i tvorb� prim�rn� tabulky 'pf' nebylo v tomto bod� nutn� nastavovat klauzuli 'GROUP BY' (v�sledky se zobraz� stejn�). 

Proto�e zobrazovan�ch z�znam� je v tomto bod� velmi mnoho (celkem 315 ��dk�), nen� snadn� tato data interpretovat a ud�lat z nich z�v�r o rychlosti zdra�ov�n� �i slev�ov�n� jednotliv�ch potravin; z meziro�n�ch rozd�l� byl tedy pro jednotliv� potraviny vypo�ten pr�m�r.

Abychom mohli tento pr�m�rn� procentu�ln� rozd�l vypo��tat, byl cel� dosavadn� dotaz vno�en do nov� klauzule 'FROM' (alias pf3) a skrze novou vn�j�� klauzuli 'SELECT' byl proveden v�po�et pr�m�rn�ho procentu�ln�ho roz�dlu pro jednotliv� potraviny:
* pf3.foodstuff_name
* round(avg(pf3.percentage_price_difference,2) AS mean_percentage_price_difference

Aby se vypo�ty sekskupily podle jednotliv�ch potravin, bylo nutn� v na�em nov�m vn�j��m dotazu nastavit klauzuli 'GROUP BY':

'GROUP BY pf3.foodstuff_name'

Kone�n� v�stup jsme rovn� se�adili vzestupn� podle nov� vypo�ten�ho pr�m�ru a n�zvu potravin:

'ORDER BY mean_percentage_price_difference ASC, foodstuff_name ASC'

T�mto byla tvorba dotazu pro �lohu �. 3 dokon�ena.

V�sledkem je v�pis jednotliv�ch potravin se�azen�ch prim�rn� podle pr�m�rn�ho procentu�ln�ho rozd�lu a sekund�rn� dle n�zvu potravin.
### �LOHA �. 4: 
####P�IPOJEN� POMOCN�CH TABULEK
Proto�e v t�to �loze je po�adavkem zjistit, zda existuje, ve kter�m byl meziro�n� n�r�st cen potravin v�razn� vy��� ne� r�st mezd (vet�� ne� 10%), bylo pot�eba vypo��tat meziro�n� rozd�ly celkov�ch ro�n�ch pr�m�r� pro mzdy a ceny potravin. Abychom toho dos�hli, byly p�ipojeny pomocn� duplicitn� tabulky 'pf2' a 'pf3.'

V prvn� ze dvou tabulek 'pf2' poslou�� k v�po�tu meziro�n�ho rozd�lu ve mzd�ch, a tak byly skrze vno�en� dotaz vybr�ny sloupce s informac� o roku a v�po�tem pr�m�rn� v��i mzdy:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (bude zaokrouhleno v pozdej��ch v�po�tech)

V�sledky v tabulce byly rovn� zbaveny pr�zdn�ch z�znam� a seskupeny podle jednotliv�ch let:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

V tomto bod� vno�en� dotaz na�� tabulky zobrazuje celkov� pr�m�rn� v��e mezd pro jednotliv� roky. Tabulka byla n�sledn� skrze 'INNER JOIN' p�ipojena podle spole�n�ch let, kde k pf2 byl p�i�ten rok nav�c, aby se jej� z�znamy posunuly o rok zp�t:

'ON pf.payroll_year = pf2.payroll_year +1' 

Skrze toto spojen� byly Meziro�n� rozd�ly ve mzd�ch vypo�teny ve vn�j�� 'SELECT' klauzuli (bude uk�z�no pozd�ji).

Druh� pomocn� tabulka 'pf3' poslou�� k v�po�tu meziro�n�ho rozd�lu v cen�ch potravin. Proto�e rozd�ly ve mzd�ch byly vypo�teny skrze tabulky pf1 a pf2, nen� obdobn� zp�sob v�po�tu vhodn�, proto�e by z podstaty 'UNION' propojen� tabulek 'cp' a 'cpr' nast�valy probl�my se zobrazen�m v�sledk� ohledn� rozd�l� cen potravin. Z tohoto d�vodu byly v t�to tabulce p�ipraveny n�sleduj�c� sloupce pro pozd�j�� v�po�et meziro�n�ho rozd�lu v cen�ch potravin:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

Abychom mohli tyto sloupce zobrazit, byla ve vno�en�m dotazu p�ipojena dal�� pomocn� tabulka: pf32 (pf31 je prvn�), jej� z�znamy byly posunuty o rok zp�t:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

Tyto tabulky byly propojeny skrze 'INNER JOIN,' ��m� byly odstran�ny ne��douc� 'NULL' z�znamy. Hodnoty byly nakonec seskupeny podle roku:

'GROUP BY pf31.price_year'

Vno�en� dotaz v tabulce pf3 ji nyn� hotov a zobrazuje n�m dva sloupce s nezaokrouhlen�mi pr�m�rn�mi cenami potravin v jednotliv�ch letech, p�i�em� jeden ze sploupc� m� pr�m�ry posunuty o rok zp�t, abychom mohli n�sledn� vypo��tat meziro�n� rozd�ly.

Pomocn� tabulka pf3 byla pot� skrze 'INNER JOIN' p�ipojena k tabulce pf podle spole�n�ch let:

'ON pf.payroll_year = pf3.price_year'

'INNER JOIN' zde zajist�, �e kone�n� v�stupy budou omezena jen na spole�n� srovnateln� obdob� cen a mezd (2006�2018).

Pozn�mka: t�m, �e je ��st v�po�t� (zpr�m�rov�n� a seskupen�) provedeno u� uvnit� pomocn�ch tabulek je rychlost zpu�t�n� kone�n�ho dotazu v�razn� urychleno.

Nyn�, kdy� byly ve�ker� nezbytn� podklady p�ipraveny, byly skrze vn�j�� 'SELECT' klauzuli vypo�teny meziro�n� procentu�ln� rozd�ly pr�m�rn�ch mezd a cen; z t�ch byl pot� zpo�ten tak� rozd�l (rozd�l v meziro�n�ch rozd�lech mezd a cena potravin):
* concat(pf.payroll_year," � ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* round(((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100),2) - round(((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100),2) AS salary_price_percentage_difference

T�mto je dotaz pro �lohu �. 4 dokon�en. jeho spu�t�n�m se n�m zobraz� v�pis meziro�n�ch procentu�ln�ch rozd�l� pr�m�rn�ch cen a mezd a tak� rozd�ly v t�chto procentu�ln�ch meziro�n�ch rozd�l�.


## V�SLEDKY
### �LOHA �. 1
#### SHRNUT�

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

#### DETAILN� POPIS V�SLEDK�

### �LOHA �. 2

!!! NUTNO P�ED�LAT HRUB� MZDY NA �IST� !!!

P�i dan�ch pr�m�rn�ch mzd�ch a cen�ch v prvn�m a posledn�m srovnateln�m obdob�, tedy v letech 2006 a 2018, je za celou v�platu mo�no nakoupit 1287.46 Kg a 1342.24 Kg chleba a 1437.24 l a 1641.57 l ml�ka.

### �LOHA �. 3

Ve v�sledk�ch m��eme vid�t, �e v pr�m�ru ceny valn� v�t�iny potravin zdra�uj�; v�jimkou jsou 'krystalov� cukr' a 'rajsk� jablka �erven� kulat�,' kter� naopak v pr�m�ru ro�n� slev�uj� o 1.92 % a 0.74 %. Podle dosavadn�ch dat jsou tedy hypoteticky "nejpomaleji" zdra�uj�c�mi potravinami 'Ban�ny �lut�', kter� v pr�m�ru ro�n� zdra�uj� o 0,81 % a za nimi Vep�ov� pe�en� s kost� 0.99 % ro�n�. Naopak v pr�m�ru nejrychleji se zdra�uj�c� potravinou se zdaj� b�t 'Papriky': 7.29 % ro�n� a d�le M�slo: 6.68 % 

























