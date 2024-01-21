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

Vytvoøení výsledné tabulky bylo provedeno skrze slouèení dvou samostatných dotazù zužující výbìr na data na potøebné minimum; jeden pro tabulku czechia_payroll a druhý pro tabulku czechia_price.
#### SELECT PRO TABULKU czechia_payroll

## VÝSLEDKY





