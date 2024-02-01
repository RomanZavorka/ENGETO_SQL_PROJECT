SELECT 
	pf.payroll_year, 
	round(avg(pf.mean_salary_czk),2) AS mean_salary_czk,
CASE
	WHEN pf.payroll_year = 2018 THEN 24486
	ELSE 16044
END AS mean_net_salary_czk,
	pf2.foodstuff_name, 
	pf2.mean_price_czk,
CASE
	WHEN pf.payroll_year = 2018 THEN round(24486 / pf2.mean_price_czk,2)
	ELSE round(16044 / pf2.mean_price_czk,2)
END AS possible_purchase_amount,
	pf2.price_unit
FROM t_roman_zavorka_project_SQL_primary_final pf 
INNER JOIN (
	SELECT 
		price_year, 
		mean_price_czk, 
		foodstuff_name, 
		price_unit
	FROM t_roman_zavorka_project_SQL_primary_final pf
	WHERE pf.price_year IN (2006, 2018)
		AND (pf.foodstuff_name LIKE '%mléko%' OR pf.foodstuff_name LIKE '%chléb%')) pf2
	ON pf.payroll_year = pf2.price_year
GROUP BY 
	pf.payroll_year, 
	pf2.foodstuff_name
ORDER BY 
	pf.payroll_year DESC,
	pf2.foodstuff_name ASC;

