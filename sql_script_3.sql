SELECT
	concat(pf.payroll_year," – ", pf2.payroll_year) AS time_period,
	pf.industry_branch_name, 
	pf.mean_salary_czk AS latter_mean_salary_czk, 
	pf2.mean_salary_czk AS former_mean_salary_czk,  
	round(pf.mean_salary_czk - pf2.mean_salary_czk,2) AS annual_difference_czk,
CASE
	WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) > 0 THEN "increase"
	WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) < 0 THEN "decrease !!!"
	ELSE "stagnancy"
END AS annual_difference_notification
FROM t_roman_zavorka_project_SQL_primary_final pf
INNER JOIN (
	SELECT 
		payroll_year, 
		mean_salary_czk, 
		industry_branch_name
	FROM t_roman_zavorka_project_SQL_primary_final pf
		)pf2 
	ON pf.payroll_year = pf2.payroll_year + 1 
		AND pf.industry_branch_name = pf2.industry_branch_name
ORDER BY 
	pf.industry_branch_name ASC, 
	pf.payroll_year DESC;

