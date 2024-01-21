# SQL PROJEKT

## ZADÁNÍ
zadání projektu
## ANALÝZA

## POSTUP
### VYTVOØENÍ PRIMÁRNÍ TABULKY
Úlohou je slouèení tabulek czechia_payroll a czechia_price s jejich návaznými tabulkami (èíselníky) do jedné tabulky skrze totožné porovnatelné období – spoleèné roky, ze které bude možné èerpat data ohlednì mezd a cen potravin za Èeskou pro plnìní následujících úloh - vìdeckých otázek.

Protože data dvou tabulek na sebe kromì spoleèných let nemají pøímou návaznost, zpùsob propojení skrze klauzuli 'JOIN' není vhodné, protože všechny záznamy z jedné tabulky by se navázaly na záznamy se shodným rok v tabulce druhé, èímž by došlo ke zbyteènému nadbytí (duplicitám) záznamù, tudíž bylo slouèení tabulek provedeno skrze klauzuli 'UNION' (možno provést též pøes 'UNION ALL', nicménì výsledek zde bude stejný).

Vytvoøení výsledné tabulky bylo provedeno skrze slouèení dvou samostatných SELECT výbìrù, jeden pro tabulku czechia_payroll 
a druhý pro tabulku czechia_price.

## VÝSLEDKY