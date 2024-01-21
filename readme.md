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
V klauzuli zobrazujeme ve�ker� sloupce: SELECT *.

Skrze zklauzuli 'JOIN' byla p�ipojena men�� tabulka czechia_payroll_industry_branch (cpib) s ��seln�kem pro identifikaci jednotliv�ch pr�myslov�ch odv�tv� ze sloupce cp.industry_branch_code. Tabulka byla p�ipojena n�sledn�:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

Pot�ebn� hodnoty ohledn� v��e pr�m�rn�ch mezd se nach�zej� v sloupci 'value', kde mimo jin� najdeme tak� hodnoty o 'pr�m�rn�ch po�tech zam�stnan�ch osob,' kter� nejsou pot�ebn�, tud� skrze klauzuli WHERE byly z�znamy omezeny pouze na hodnoty t�kaj�c� se v��e mezd: 

"WHERE cp.value_type_code = 5958 (zji�t�no z ��seln�ku 'czechia_payroll_value_type').

Rovn� byly zaznamen�ny t� hodnoty, kter� maj� ve sloupci 'industry_branch_code' hodnoty 'NULL,' a tak nev�me, do kter�ho odv�tv� spadaj�; takov� hodnoty nemus� b�t validn�, a tak byly t� vylou�eny p�id�n�m dal�� podm�nky: 

'AND cp.industry_branch_code IS NOT NULL.'

Poznamka: Je mo�no rovn� p�idat podm�nku 'AND cp.value IS NOT NULL', nicm�n� v sloupci 'value' ��dn� pr�zdn� z�znamy o v��i mezd nalezeny nebyly, a tak tato podm�nka p�id�na nebyla.






## V�SLEDKY





