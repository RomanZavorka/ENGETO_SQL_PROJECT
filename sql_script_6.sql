SELECT 
	concat(pf.payroll_year," – ",pf2.payroll_year) AS time_period, 
	round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference,
	round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference,
	round(((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100),2) - round(((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100),2) 
	AS salary_price_percentage_difference
FROM t_roman_zavorka_project_SQL_primary_final pf
INNER JOIN (
	SELECT 
		payroll_year, 
		avg(mean_salary_czk) AS former_mean_salary_czk
	FROM t_roman_zavorka_project_SQL_primary_final pf
	WHERE mean_salary_czk IS NOT NULL
	GROUP BY payroll_year) pf2
		ON pf.payroll_year = pf2.payroll_year +1 
INNER JOIN(
	SELECT 
		pf31.price_year, 
		avg(pf31.mean_price_czk) AS latter_mean_price_czk, 
		avg(pf32.mean_price_czk) AS former_mean_price_czk
	FROM t_roman_zavorka_project_SQL_primary_final pf31 
	INNER JOIN (
		SELECT 
			price_year, 
			mean_price_czk 
		FROM t_roman_zavorka_project_SQL_primary_final pf32) pf32
		ON pf31.price_year = pf32.price_year +1
	GROUP BY pf31.price_year )pf3
		ON pf.payroll_year = pf3.price_year
GROUP BY pf.payroll_year
ORDER BY pf.payroll_year DESC;


