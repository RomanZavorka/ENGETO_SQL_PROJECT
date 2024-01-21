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

Vytvo�en� v�sledn� tabulky bylo provedeno skrze slou�en� dvou samostatn�ch dotaz� zu�uj�c� v�b�r na data na pot�ebn� minimum; jeden pro tabulku czechia_payroll a druh� pro tabulku czechia_price.
#### SELECT PRO TABULKU czechia_payroll

## V�SLEDKY





