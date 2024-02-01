CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS 
SELECT 
	c.country, 
	c.region_in_world, 
	e.`year`, 
	e.GDP AS gdp, 
	e.gini, 
	e.population
FROM countries c
INNER JOIN economies e
	ON e.country = c.country
WHERE c.continent = 'Europe' 
	AND e.`year` >= 2000;
