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

Vytvoøení výsledné tabulky bylo provedeno skrze slouèení dvou samostatných SQL dotazù zužující data na potøebné minimum; jeden pro tabulku czechia_payroll a druhý pro tabulku czechia_price.
#### DOTAZ PRO TABULKU czechia_payroll

Do klauzule 'FROM' byl vložen název pøíslušné tabulky czechia_payroll (cp), ze které byla data nahrávána.
V klauzuli zobrazujeme veškeré sloupce: SELECT *.

Skrze zklauzuli 'JOIN' byla pøipojena menší tabulka czechia_payroll_industry_branch (cpib) s èíselníkem pro identifikaci jednotlivých prùmyslových odvìtví ze sloupce cp.industry_branch_code. Tabulka byla pøipojena následnì:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

Potøebné hodnoty ohlednì výše prùmìrných mezd se nacházejí v sloupci 'value', kde mimo jiné najdeme také hodnoty o 'prùmìrných poètech zamìstnaných osob,' které nejsou potøebné, tudíž skrze klauzuli WHERE byly záznamy omezeny pouze na hodnoty týkající se výše mezd: 

"WHERE cp.value_type_code = 5958 (zjištìno z èíselníku 'czechia_payroll_value_type').

Rovnìž byly zaznamenány též hodnoty, které mají ve sloupci 'industry_branch_code' hodnoty 'NULL,' a tak nevíme, do kterého odvìtví spadají; takové hodnoty nemusí být validní, a tak byly též vylouèeny pøidáním další podmínky: 

'AND cp.industry_branch_code IS NOT NULL.'

Poznamka: Je možno rovnìž pøidat podmínku 'AND cp.value IS NOT NULL', nicménì v sloupci 'value' žádné prázdné záznamy o výši mezd nalezeny nebyly, a tak tato podmínka pøidána nebyla.






## VÝSLEDKY





