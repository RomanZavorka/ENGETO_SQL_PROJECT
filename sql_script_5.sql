SELECT 
	pf3.foodstuff_name, 
	round(avg(pf3.annual_percentage_price_difference),2) AS mean_annual_percentage_price_difference
FROM(
	SELECT
		concat(pf.price_year," – ", pf2.price_year) AS time_period, 
		pf.foodstuff_name, 
		pf.mean_price_czk AS latter_mean__price_czk, 
		pf2.mean_price_czk AS former_mean_price_czk, 
		round((pf.mean_price_czk - pf2.mean_price_czk) / pf2.mean_price_czk*100,2) AS annual_percentage_price_difference
	FROM t_roman_zavorka_project_SQL_primary_final pf
	INNER JOIN (
		SELECT 
			price_year, 
			foodstuff_name, 
			mean_price_czk 
		FROM t_roman_zavorka_project_SQL_primary_final pf
		WHERE mean_price_czk IS NOT NULL
		) pf2
		ON pf.price_year = pf2.price_year +1  
			AND pf.foodstuff_name = pf2.foodstuff_name
	ORDER BY 
		pf.price_year DESC,
		pf.foodstuff_name ASC)pf3
GROUP BY 
	pf3.foodstuff_name
ORDER BY 
	mean_annual_percentage_price_difference ASC;
