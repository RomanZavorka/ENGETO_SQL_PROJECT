# SQL PROJEKT

## ZAD�N�
zad�n� projektu
## ANAL�ZA

## POSTUP
### VYTVO�EN� PRIM�RN� TABULKY
�lohou je slou�en� tabulek czechia_payroll a czechia_price s jejich n�vazn�mi tabulkami (��seln�ky) do jedn� tabulky skrze toto�n� porovnateln� obdob� � spole�n� roky, ze kter� bude mo�n� �erpat data ohledn� mezd a cen potravin za �eskou pro pln�n� n�sleduj�c�ch �loh - v�deck�ch ot�zek.

Proto�e data dvou tabulek na sebe krom� spole�n�ch let nemaj� p��mou n�vaznost, zp�sob propojen� skrze klauzuli 'JOIN' nen� vhodn�, proto�e v�echny z�znamy z jedn� tabulky by se nav�zaly na z�znamy se shodn�m rok v tabulce druh�, ��m� by do�lo ke zbyte�n�mu nadbyt� (duplicit�m) z�znam�, tud� bylo slou�en� tabulek provedeno skrze klauzuli 'UNION' (mo�no prov�st t� p�es 'UNION ALL', nicm�n� v�sledek zde bude stejn�).

Vytvo�en� v�sledn� tabulky bylo provedeno skrze slou�en� dvou samostatn�ch SELECT v�b�r�, jeden pro tabulku czechia_payroll 
a druh� pro tabulku czechia_price.

## V�SLEDKY