CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_primary_final AS
SELECT *
FROM(
	(SELECT 
		cp.payroll_year, 
		cpib.name AS industry_branch_name, 
		round(avg(cp.value),2) AS mean_salary_czk,
		null AS price_year, 
		null AS foodstuff_name, 
		null AS mean_price_czk, 
		null AS price_unit
	FROM czechia_payroll cp
	INNER JOIN czechia_payroll_industry_branch cpib 
		ON cp.industry_branch_code = cpib.code
	WHERE cp.value_type_code = 5958 
		AND cp.industry_branch_code IS NOT NULL
	GROUP BY 
		cp.payroll_year, 
		industry_branch_name
	ORDER BY 
		cp.payroll_year DESC, 
		industry_branch_name ASC)
	UNION
	(SELECT 
		null, 
		null, 
		null, 
		year(cpr.date_from) AS price_year, 
		cpc.name AS foodstuff_name, 
		round(avg(cpr.value),2) AS mean_price_czk, 
		concat(cpc.price_value," ",cpc.price_unit) AS price_unit 
	FROM czechia_price cpr
	INNER JOIN czechia_price_category cpc
		ON cpr.category_code = cpc.code 
	GROUP BY 
		price_year, 
		foodstuff_name
	ORDER BY 
		price_year DESC,  
		foodstuff_name ASC)) pf3
ORDER BY 
	payroll_year DESC, 
	industry_branch_name ASC, 
	price_year DESC, 
	foodstuff_name ASC;


