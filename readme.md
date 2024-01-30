# SQL PROJECT
## ASSIGNMENT
### INTRODUCTION TO THE PROJECT
At your analytical department of an independent company that focuses on the standard of living of citizens, you have agreed to try to answer a few defined research questions that address the availability of basic foodstuffs to the general public. Colleagues have already defined the basic questions they will try to answer and provide this information to the press department. This department will present the results at the next conference focusing on this field.
To do this, they need you to prepare robust data documentation in which it will be possible to see comparisons of food availability based on average incomes over a certain period of time.
As additional material, also prepare a table with GDP, GINI coefficient and population of other European countries in the same period as the primary overview for the Czech Republic.
### DATASETS THAT CAN BE USED TO OBTAIN A SUITABLE DATA BASE
#### PRIMARY TABLES:
1. czechia_payroll - Information on salaries in different sectors over a multi-year period. The dataset comes from the Open Data Portal of the Czech Republic.
2. czechia_payroll_calculation - Codebook of calculations in the payroll table.
3. czechia_payroll_industry_branch - Codebook of industry in the payroll table.
4. czechia_payroll_unit - Codebook of the unit of value in the payroll table.
5. czechia_payroll_value_type - Codebook of value types in the payroll table.
6. czechia_price - Information on prices of selected foodstuffs over a multi-year period. The dataset comes from the Open Data Portal of the Czech Republic.
7. czechia_price_category - Codebook of food categories that appear in our overview.
#### CODEBOOKS OF SHARED INFORMATION ABOUT THE CZECH REPUBLIC:
1. czechia_region - Codebook of regions of the Czech Republic according to the CZ-NUTS 2 standard.
2. czechia_district - Codebook of districts of the Czech Republic according to the LAU standard.
#### ADDITIONAL TABLES:
1. countries - All kinds of information about countries in the world, for example capital city, currency, national food or mean height of population.
2. economies - GDP, GINI, tax incidence, etc. for a given country and year.
#### RESEARCH QUESTIONS
1. Have salaries in all sectors been increasing over the years, or have they been declining in some?
2. How many liters of milk and kilograms of bread can be bought in the first and last comparable periods in the available data on prices and salaries?
3. Which category of food is increasing in price the slowest (has the lowest percentage annual increase)?
4. Is there a year in which the annual increase in food prices was significantly higher than the increase in salaries (greater than 10%)?
5. Does the GDP level affect changes in salaries and food prices? Or, if GDP rises more significantly in one year, does this result in a more significant rise in food prices or salaries in the same or the following year?
#### PROJECT OUTPUT
Help your colleagues with the given task. The output should be two tables in a database from which the required data can be obtained. Name the tables  t_{jmeno}_{prijmeni}_project_SQL_primary_final (for salary and food prices data for the Czech Republic united to the same comparable period - common years) and t_{jmeno}_{prijmeni}_project_SQL_secondary_final (for additional data on other European countries).

Next, prepare a set of SQL to obtain data from the tables you have prepared to answer the research questions. Note that the questions/hypotheses can both support and refute your outputs! It depends on what the data show.

Create a repository on your GitHub account (can be private) where you store all the information for the project - mainly the SQL script that generates the output table, a description of the intermediate results (a guide sheet), and information about the output data (for example, where values are missing, etc.).

Do not edit data in primary tables! If it is necessary to transform values, do so in the tables or views you are creating.

## ANALYSIS
### OVERVIEW OF SOURCE TABLES
For the creation of the primary table, two main tables were available, to which the secondary tables - codebooks - were linked.

czechia_payroll - Information on salaries in different sectors over a multi-year period. The dataset comes from the Open Data Portal of the Czech Republic.  The table consists of 8 columns:
* id
* value - Mean gross salaries and mean numbers of employees in industries.
* value_type_code - Code of the type of value.
* unit_code - Code of the unit in which the values are represented.
* calculation_code - Code of the method of calculation of the value.
* industry_branch_code.
* payroll_year - Year for which the table records are valid.
* payroll_quarter - The quarter for which the table records are valid.

Several supplementary tables are linked to this table:
* czechia_payroll_calculation - Codebook of calculations in the payroll table.
* czechia_payroll_industry_branch - Codebook of industry in the payroll table.
* czechia_payroll_unit - Codebook of the unit of value in the payroll table.
* czechia_payroll_value_type - Codebook of value types in the payroll table.

czechia_price - Information on prices of selected foodstuffs over a multi-year period. The dataset comes from the Open Data Portal of the Czech Republic. This table consists of 6 columns:
* id
* value - Mean prices for each food category.
* category_code - Food category code.
* date_from - start of measurement
* date_to - end of measurement
* region_code - Region code.

The following supporting tables link to this table:
* czechia_price_category - Codebook of food categories that appear in our overview.
* czechia_region - Codebook of regions of the Czech Republic according to the CZ-NUTS 2 standard.

### PRIMARY TABLE CREATION

The purpose of creating the primary table is to merge the tables 'czechia_payroll' and 'czechia_price' (and possibly their supplementary tables - codebooks) into one table through the same comparable period, that is common years, from which it would be possible to obtain data on salaries and food prices for the Czech Republic for the following tasks - answering the given scientific questions.

Both tables contain a large amount of information, which is further described in the following supporting tables - codebooks. The first step was therefore to get familiar with the tables and find out what they contain and, according to the assignment, to consider which data are important for us and which are not. In both of these tables we can see that there are several columns that contain only simple codes that do not tell us anything - these codes are described in the linked codebooks. 

Some codebooks have been used only once: 
* czechia_payroll_value_type - setting of ' value_type_code' to show only the salary values - code 5958.
* czechia_payroll_unit - to find out in which units the values in the 'value' column are expressed (for salaries it is Czech crowns).

Two tables have been permanently attached: 
* czechia_price_category - identification of food categories and their quantity units.
* czechia_payroll_industry_branch - identification of industry sector.

And some tables were not used at all: 
* czechia_payroll_calculation - the method of value calculation is not important for us.
* czechia_region - the data was processed for the Czech Republic as a whole; therefore, the identification of regions was not important for us.

After becoming familiar with the content of the tables, there were several obstacles to overcome in order to create the table. One obstacle was the content of unnecessary records and values. The 'czechia_payroll' table contains not only records on mean gross salaries but also records on mean number of employees in sectors - we are not interested in such values here and so they were excluded. Similarly, values on salaries that did not contain information about the industry, which we consider essential, have been excluded as well. 'NULL' values in 'value' column regarding salaries have not been observed.

In the 'czechia_price' table, 'NULL' values were observed only in the 'region_code' column, but since the data in this project is processed for the Czech Republic as a whole, this missing information about region is not a problem. No records were excluded in the 'czechia_price' table.

Another problem was the extent of the tables, especially 'czechia_price' which has a total of 108 249 records. 'czechia_payroll' had 3 268 of the original 6 880 records after eliminating unnecessary records. The records of both tables have therefore been averaged and grouped (by year and industry sector / food category), thus reducing their size significantly: 'czechia_payroll' to 418 and 'czechia_price' to 342. With these reduced scopes, all operations with these tables shall be significantly faster and their data easier to comprehend. 

Another obstacle was also finding a way to pair the data of the two tables. The tables are basically independent of each other, and the only common feature is the time of measurement - the year. In the 'czechia_payroll' table, this information was contained in the column 'payroll_year.' In the 'czechia_price' table, it was the columns 'date_to' and 'date_from' that contained the full date, where the year was always the same in both columns, so any of the columns could be used.

It is also important to note that the tables do not have the same range of years for which the records are valid: the 'czechia_payroll' table contains records for the years 2000-2021, while the 'czechia_price' table only contains records for the years 2006-2018. Therefore, the tables can only be compared with each other between 2006 and 2018.

In addition to limiting the records (rows), our effort was also to limit the number of columns, where in the 'czechia_payroll' table only three columns containing the following information were finally selected:
* information about year - payroll_year
* industry branch name - cpib.name (from joined codebook 'czechia_payroll_industry_branch')
* mean gross salary - value (averaged and rounded afterwards)

In the 'czechia_price' table it was four columns:
* information about year - date_from (inserted into the year() function afterwards) 
* mean foodstuff price - value (afterwards averaged and rounded). Note: it is not clearly defined in what units the food prices are presented here - we assume they are in Czech crowns.
* food category name (from joined codebook 'czechia_price_category') 
* information about the quantity for which the prices are valid - created by concatenating the 'price_value' and 'price_unit' (from the 'czechia_price_category' codebook) columns via the concat() function.

The selected columns were then renamed where necessary to avoid the problem of duplicate names and to make it clear what they contain.

As the data of the two tables have no direct relation to each other except for the common years, the method of linking via the 'JOIN' clause did not seem appropriate, as all records from one table would be bound to the records with the same year in the other table, hence unnecessary multiplication (duplication) of records would occur, thus negating our efforts to reduce the data to a minimum.

Therefore, the connection of the two mentioned tables was made through the 'UNION' clause.' This way, the tables are connected not through the sides but through the top and bottom, thus avoiding duplication of records.

Since only tables with the same number of columns can be joined via 'UNION' clause, it was necessary to balance the number of columns. In our case this was achieved by inserting additional 'NULL' columns containing empty values. These 'NULL' columns were inserted into both tables so that the records of both tables had their own separate columns (to be more explained in the 'procedure' section). 
### PRIMARY TABLE OUTPUT
The result of our efforts is the table "t_roman_zavorka_project_sql_primary_final" with a range of 760 records and a total of 7 columns:
* payroll_year - information about the year for which the salary records are valid.
* industry_branch_name - the name of the industry sector.
* mean_salary_czk - average gross salaries by year and industry sector.
* price_year - information on the year for which the food price records are valid.
* foodstuff_name - name of the food category.
* mean_price_czk - average prices by year and food category. 
* price_unit - the unit of quantity to which the food price records apply.

Table records show us the mean gross salaries by year and industry branch in the period 2000-2021 and also the mean prices (for a given quantity) by year and food category in the period 2006-2018.

Since the tables have been merged through the 'UNION' clause and into separate columns, we can see that the table contains many empty records, that is, when we look at the records from the 'czechia_payroll' table, the records (columns) from the 'czechia_price' table are empty and the other way around.

## PROCEDURE
### PRIMARY TABLE CREATION
#### INTRODUCTION

The primary table 't_roman_zavorka_project_sql_primary_final' containing data from both tables was created via the 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' clause, where 'CREATE' creates the table and if a table with that name already exists, the 'REPLACE' statement is activated to replace the existing table with the new one, allowing the table to be easily edited and updated if necessary. In our case, the table was created via an SQL query following the 'AS' clause.

As was described above in the analysis section, the creation of the resulting table was done through the 'UNION' clause merging two separate SQL queries; one for the 'czechia_payroll' table and the other for the 'czechia_price' table.

#### QUERY FOR 'CZECHIA_PAYROLL'
In the 'FROM' clause, the name of the corresponding 'czechia_payroll' table (cp) from which the data was loaded was inserted. At the beginning all columns were displayed: 'SELECT *'.

Through the 'INNER JOIN' clause ('LEFT JOIN' could also be used), a supporting table 'czechia_payroll_industry_branch' (cpib) was joined containing a codebook to identify individual branches of industry in the 'cp.industry_branch_code' column. The table has been joined as follows:

"czechia_payroll_industry_branch (cpib) ON cp.industry_branch_code = cpib.code"

The necessary values regarding the mean salary are found in the 'value' column, where we can also find, besides others, the values regarding the 'mean number of persons employed,' which are not needed, so through the 'WHERE' clause the records were limited to values regarding the salaries only: 

'WHERE cp.value_type_code = 5958' (found in codebook 'czechia_payroll_value_type').

Records with 'NULL' values in the 'industry_branch_code' column were also observed, and so we do not know which industry they belong to. Since the industry branch information is relevant to us, these values were also excluded by adding an additional condition to the 'WHERE' clause: 

'AND cp.industry_branch_code IS NOT NULL.'

Note: It is also possible to add the condition 'AND cp.value IS NOT NULL', however no empty records regarding salaries were found in the 'value' column, so this condition was not added.

At this moment, all columns are displayed and records are limited to salary records for each year in each quarter in each industry. However, the data in this layout is still very extensive, and so we can reduce it significantly by averaging with avg() functions and grouping through 'GROUP BY' clause. In our case, the records were grouped by year for which records are valid and secondarily by industry name (attached codebook):

'GROUP BY cp.payroll_year, cpib.name'

This averaging and grouping of all records, in addition to reducing the table size, will also help us significantly in future tasks, because the data set in this way is easier to interpret and in some cases it is no longer necessary to use the avg() function.

In addition to records, limitations were also made in the number of columns, where only three important columns were ultimately selected in the 'SELECT' clause:
* cp.payroll_year - contains information about the period for which records are valid (the column name suits us as it is).
* cpib.name AS industry_branch_name - the column with the names of industry sectors from the attached table (codebook) 'czechia_payroll_industry_branch', so there is no need for the column 'cp.industry_branch_code' anymore.
* round(avg(cp.value),2) AS mean_salary_czk - the column 'cp.value' containing values about gross salaries has been averaged and rounded to two decimal places via avg() and round() functions. Since the salary value is expressed in Czech crowns, the abbreviation 'czk' has been added to the name.	

Now that the 'aliases' have been set, we can replace 'cpib.name' with 'industry_branch_name' in the GROUP BY clause:

'GROUP BY cp.payroll_year, industry_branch_name'

The final output of this table was then ordered in descending order by year and ascending order by industry name via an 'ORDER BY' clause: 

'ORDER BY cp.payroll_year DESC, industry_branch_name ASC'

At this point, the result is a table with three columns: payroll_year, industry_branch_name and mean_salary_czk; the table range is 418 rows in total. The table shows us mean salaries in each year in each industry and is ordered in descending order by year and ascending order by industry name.
#### QUERY FOR 'CZECHIA_PRICE'
The table name 'czechia_price' (cpr) was inserted into the 'FROM' clause and initially all columns were displayed using 'SELECT *'.

Values regarding food prices are found in the 'value' column, (same name as in the 'czechia_payroll' table), with foodstuff being identified only in the 'category_code' column.

In order to clearly identify individual food categories, the table 'czechia_price_category' (cpc) containing the codebook was joined using the 'INNER JOIN' clause ('LEFT JOIN' can be used as well). The table was joined as follows:

'czechia_price_category (cpc) ON cp.category_code = cpc.code'

With the exception of the 'region_code' column, the records are complete and do not contain 'NULL' values. Since the data in the following tasks is processed for the country as a whole, the information about the region in the 'region_code' column is not important. At the end, it is not necessary to limit the record range in this table.

The required columns were then selected in the 'SELECT' clause. Firstly we need the information about the year to which each record belongs. There are two columns in the table providing this information: 'date_from' and 'date_to.' The records are in a format where the full date and time are given. Since we only need to know the information about the year to connect to the first table, the year() function was used.

Through a follow-up query, it was found that both dates are always in the same year, so either of the two columns can be used:

'SELECT * FROM czechia_price cp WHERE year(date_from) != year(date_to)'

In this case the column 'date_from' was selected: 
* year(cpr.date_from) AS price_year
* The next column was chosen from the attached table 'czechia_price_category' (cpc) providing the name of the food category: cpc.name AS foodstuff_name - ( therefore the column cpr.category_code is no longer needed).
* Similarly, we performed the averaging and rounding of the values in the 'cpr.value' column as in the czechia_payroll table: round(avg(cpr.value),2) AS mean_price_czk.
* The last column of this table was created by concatenating the 'cpc.price_value' and 'cpc.price_unit' columns from the joined table 'czechia_price_category' (cpc) using the concat() function: concat(cpc.price_value," ",cpc.price_unit) AS price_unit. This column specifies the quantity to which the prices of each food category are related (for example, the price for 0.5 liters of beer).

As in the 'czechia_payroll' table, there are to many records, so the food price values have been averaged and grouped by the 'GROUP BY' clause by year and food category: 

'GROUP BY price_year, foodstuff_name'

The output of our query for this table was then ordered in descending order by year and ascending order by food category using the 'ORDER BY' clause: 

'ORDER BY price_year DESC, foodstuff_name ASC'

The current output consists of the fields 'price_year', 'foodstuff_name', 'mean_price_czk' and 'price_unit' with a total of 342 records. The individual records show us what the mean prices of each foodstuff category are in each year for a given quantity and are ordered in descending order by year and ascending order by foodstuff name.

#### MERGING OF QUERIES 
Now that the scope of our two tables is ready, we can step by step proceed to merge them through the 'UNION' clause. 

The first obstacle that stood in the way of the merging of the two tables was the unequal number of columns (3 to 4). In addition, I also decided that I wanted the data from both tables to be in separate columns.This was achieved by adding 'null' columns to both of our tables, with the newly added 'null' columns in the upper table carrying the column names of the lower table, and the 'null' columns in the lower table being included in the first three columns of the upper table:

czechia_payroll (the upper table):
 
* cp.payroll_year, 
* cpib.name AS industry_branch_name, 
* round(avg(cp.value),2) AS mean_salary_czk,
* null AS price_year, 
* null AS foodstuff_name, 
* null AS mean_price_czk, 
* null AS price_unit

czechia_price (the lower table):
 
* null, 
* null, 
* null, 
* year(cpr.date_from) AS price_year, 
* cpc.name AS foodstuff_name, 
* round(avg(cpr.value),2) AS mean_price_czk, 
* concat(cpc.price_value," ",cpc.price_unit) AS price_unit

This way the problem with unequal number of columns was solved and at the same time the columns of both tables have been separated. After that it was necessary to wrap the queries of the two tables in parentheses and merge them using the 'UNION' clause, which completes the SQL query for displaying all necessary items of both tables (it can also be performed through 'UNION ALL', but the result would be the same).

Even though both SQL queries have been ordered descending by year and ascending by industry/food category through the 'ORDER BY' clause, the output of our 'united' query is not ordered as we expected. Thus, this 'united' query was additionally nested into a new query, through which we display all the data ordered according to our expectation:

'ORDER BY payroll_DESC, industry_branch_name ASC, price_year DESC, foodstuff_name ASC

Now, as already mentioned at the beginning, all that is now needed to do is just to add the clause 'CREATE OR REPLACE TABLE t_roman_zavorka_project_sql_primary_final AS,' above the current query which will give the command to create or replace the table 't_roman_zavorka_project_sql_primary_final.'

### SECONDARY TABLE CREATION
#### INTRODUCTION
Similar to the primary table, the secondary table was created through the 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS' clause, which creates or replaces the t_roman_zavorka_project_SQL_secondary_final table from the SQL query following the 'AS' part of the clause.

The secondary table, as already mentioned in the project assignment, is supposed to contain an additional overview of GDP, GINI coefficient and population size of other European countries in the same period as the primary overview for the Czech Republic. The table was created by combining the tables 'economies' and 'countries.' 

#### LINKING OF THE TABLES
Since the two tables contain records that are directly related to each other through a common column 'country', through which the two tables can be linked without causing unwanted duplication of records, in this case they were linked through the 'INNER JOIN' clause.

The 'countries' table was chosen as the first and so was inserted into the FROM clause. In the SELECT * clause, all the columns were displayed initially.

Next, the 'economies' table was joined using the 'INNER JOIN' ('LEFT JOIN' could be used as well) clause through the 'country' column: 

'INNER JOIN economies c ON e.country = c.country'

Since the table is supposed to contain data for other European countries, but it is not clearly specified which ones, all countries located on the European continent were selected. 

The second condition is that the records are supposed to be for the same period as the primary overview for the Czech Republic; czechia_payroll: 2000-2021 and czechia_price 2006-2018 -> the records were therefore limited to the year 2000 and above. These conditions were set via the 'WHERE' clause as follows:

"WHERE c.continent = 'Europe' AND e.`year`>= 2000"

Now that the two tables have been successfully joined and the records have been limited according to our needs, the columns in the resulting table are to be specified using the 'SELECT' clause.

The objective is to provide data regarding GDP, GINI coefficient and population size in other European countries in specific years, this information can be found in the table 'economies.' From the table 'countries', some basic additional information about the countries has been added beyond the scope of the assignment. In the end, the following columns have been selected:

* c.country - names of individual countries
* c.capital_city - name of capital city
* c.region_in_world - closer description of country localization
* c.currency_code - local currency abbreviation
* e.`year` - year for which the data is valid
* e.GDP AS gdp - gross domestic product
* e.gini - gini coefficient
* e.population - data on population trend in years; column c.populaton from the second table does not show the population trend in years (it is fixed), so it was not selected.

That completes the SQL query to select the data for the secondary table. The resulting table consists of a total of 8 columns and its range is 945 records. The table provides us with some basic information about European countries (capital city, location on the continent, abbreviation of local currency) and the development of economic indicators GDP and gini and population in years between 2000 to 2020.

At this point, same as with the primary table, all that is now needed to do is to add the clause 'CREATE OR REPLACE TABLE t_roman_zavorka_project_SQL_secondary_final AS' above the existing query which will give command to create or replace the table 't_roman_zavorka_project_SQL_secondary_final.'
### QUERY FOR QUESTION 1: 
In order to find out whether salaries in individual industry sectors are rising or declining, a column was created showing the differences in salaries between years for each sector. This was accomplished by joining a duplicate table 'pf2.'

The following columns were selected from our primary table 'pf' via a 'SELECT' clause:
* pf.payroll_year - the years for which the salary records are valid
* pf.industry_branch_name - industry sector name
* pf.mean_salary_en - mean salaries

In order to calculate the annual salary differences, a duplicate table 'pf2' was joined to our table using the 'INNER JOIN' clause, which was similarly limited to the same columns as the first table 'pf' through a nested query. 

The tables were linked through common years and matching industry: 

'ON pf.payroll_year = pf2.payroll_year + 1 AND pf.industry_branch_name = pf2.industry_branch_name'

To the year in the second table 'pf2', +1 was added to shift all its records one year back. 'INNER JOIN' was chosen for the linking to exclude unwanted 'NULL' values in the second table resulting from shifting records a year back in year 2000 (1999 is not available). 

The 'INNER JOIN' also ensures that the selected columns will not display 'NULL' values resulting from the merging of the 'czechia_payroll' and 'czechia_price' tables through the 'UNION' clause (see 'PRIMARY TABLE CREATION').

After successful joining of two tables, the fields (columns) in the outer 'SELECT' clause were set as follows:
* pf2.payroll_year was concatenated to the first column 'pf.payroll_year' via concat(): 'concat(pf.payroll_year," - ", pf2.payroll_year) AS time_period'
* pf.industry_branch_name
* pf.mean_salary_czk AS latter_mean_salary_czk 
* pf2.mean_salary_czk AS former_mean_salary_czk
* Calculation and rounding of the difference between years: round(pf.mean_salary_czk - pf2.mean_salary_czk,2) AS annual_difference_czk

Note: since the values for salaries were averaged and grouped by year and industry sector during the creation of the primary table, there is no need to use the avg() function or the 'GROUP BY' clause.

To highlight the conclusion of the annual difference, an 'annual_difference_notification' column was added using the 'CASE' clause to point out whether there was an increase, decrease or stagnation in salaries between years:

* CASE
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) > 0 THEN "increase"
* WHEN round((pf.mean_salary_czk - pf2.mean_salary_czk),2) < 0 THEN "decrease !!!"
* ELSE "stagnancy"
* END AS annual_difference_notification

The results were ordered in ascending order by name of industry branch and descending order by year of measurement: 

'ORDER BY pf.industry_branch_name ASC, pf.payroll_year DESC'

The SQL query to answer question 1 is now complete and reveals us the mean salary values and their annual differences by year and industry sector and also whether there has been a decrease or increase in these salaries between years.
### QUERY FOR QUESTION 2: 
Since the assignment refers to salaries in individual years in general and not by sector, it was necessary to calculate the overall mean salary from all sectors for each year.

From the primary table 'pf' in the section regarding salaries 
the column containing the year and the column calculating the mean of the salaries rounded to two decimal places was selected in the 'SELECT' clause:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk

Then, all values were grouped by years: 

'GROUP BY pf.payroll_year'

The results were also ordered in descending order by year:

'ORDER BY pf.payroll_year DESC'

At this point, our query would show us total mean salaries in descending order by year.

The next step was to obtain the necessary mean food prices grouped by year and foodstuff category. Since food prices were already averaged and grouped this way when the primary table was created, there is no need to modify them.

As the food records needed to be presented alongside the salary records by common year of measurement (which the existing 'pf' table does not allow now), a duplicate 'pf2' table was added.

The selection of the columns in the attached table 'pf2' was limited through a nested query to columns with year, mean foodstuff price, foodstuff category name and quantity units:
* pf.price_year
* pf.mean_price_czk
* pf.foodstuff_name - food categories
* pf.price_unit - quantity units

The question specifies that the calculations are to be performed for the first and last comparable periods and only for the categories 'mléko' (milk) and 'chléb' (bread).

Note: for salaries, we have records available for years 2000-2021, while for foodstuff prices we only have records for years 2006-2018, so the first comparable period is 2006 and the last is 2018.

The records in the nested query have therefore been limited through the 'WHERE' clause as follows:

"WHERE pf.price_year IN (2006, 2018) AND (pf.foodstuff_name LIKE '%mléko%' OR pf.foodstuff_name LIKE '%chléb%')"

These conditions will ensure that only records in year 2006 and 2018 will be displayed, and at the same time only food categories with 'mléko' or 'chléb' in their name will be displayed.

The nested query is now complete and executing it will show us a table with 4 columns and 4 records: the mean prices for 1 kg of bread and 1 l of milk in 2006 and 2018.

The nested query is now complete and its execution shows us a table with 4 columns and 4 records: mean prices for 1 kg of bread (chléb) and 1 l of milk (mléko) in year 2006 and 2018.

Afterwards, the tables were linked through common years:

'ON pf.payroll = pf2.price_year'

For linking of the two tables, the 'INNER JOIN' clause was chosen so that all records were afterwards limited only to the selected years and food categories in the joined secondary table 'pf2.'

Note: by limiting the records in the joined table 'pf2' through a nested query, the execution speed of the entire SQL query is greatly improved.

Next, columns regarding foodstuff prices were added to the outer 'SELECT' clause; the column layout now looked like this:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk
* pf2.foodstuff_name
* pf2.mean_price_czk
* pf2.price_unit

Since columns regarding food prices were added to the 'SELECT' clause, it was also necessary to make an adjustment to the 'GROUP BY' clause by adding the 'pf2.foodstuff_name' column to group the records primarily by year and secondarily by foodstuff category:

'GROUP BY pf.payroll_year, pf2.foodstuff_name'

At this point we have overall mean 'gross' salaries and mean prices for milk and bread at our disposal. However, in order to calculate how much of the given groceries we can buy for given salaries, we need to convert the gross salaries into net salaries:

2018: 
* mean gross salary: 32535,86 CZK
* health (4,5%) and social insurance (6,5%): total 3580 CZK
* tax base: 32535,86*1,34 rounded up to the nearest hundred: 43600 CZK
* income tax: 43600*0,15-2070(tax discount): 4470 CZK
* net salary: 32535,86-3580-4470 = 24 486 CZK (rounded up)

2006:
* average gross wage: 20753,79 CZK
* health (4,5%) and social insurance (8%): total 2595 CZK
* tax base: 20753,79-2595 = 18158,79 CZK rounded up to the nearest hundred: 18200 CZK
* income tax: (18200-18200)*0.25+2715-600(discount): 2115 CZK
* net salary: 18158,79-2115 = 16 044 CZK (rounded up)

Note: the calculation is made with only the basic tax discount. The methodological procedure for calculating net salaries was in both years different.

Now that the net pay for our two periods has been calculated,
the columns with the net salary and the calculation of how much food can be purchased with the given mean net salaries and prices have been added to the 'SELECT' clause:

Now that the net salary for the two periods has been calculated the columns with the net salary and the calculation of the amount of food that can be purchased at the given mean net salaries and prices have been added to the 'SELECT' clause:
* pf.payroll_year
* round(avg(pf.mean_salary_czk),2) AS mean_salary_czk
* CASE WHEN pf.payroll_year = 2018 THEN 24486 ELSE 16044 END AS mean_net_salary_czk
* pf2.foodstuff_name
* pf2.mean_price_czk
* CASE WHEN pf.payroll_year = 2018 THEN round(24486 / pf2.mean_price_czk,2) ELSE round(16044 / pf2.mean_price_czk,2 END AS possible_purchase_amount
* pf2.price_unit

Since the result net salaries were inserted "manually", these new additional columns were created using the 'CASE' clause to bind the correct value to each year.

The output was afterwards ordered in descending order by year and ascending order by foodstuff category name:

'ORDER BY pf.payroll_year DESC, pf2.foodstuff_name ASC'

The SQL query for answering the question 2 is thereby completed and its output is a table with 4 records that tells us what the mean gross and net salaries and the mean prices of bread and milk were in years 2006 and 2018 and how much of these foodstuffs could be bought with the given salaries.
### QUERY FOR QUESTION 3: 
In order to find out how food prices have been developing between years, annual differences were calculated from the mean annual prices for individual foodstuffs; the procedure in this case was similar to that used in query for question 1.

From the primary table 'pf', columns providing information regarding year, food category name and mean price were selected via the 'SELECT' clause:
* pf.price_year
* pf.foodstuff_name
* pf.mean_price_czk

For calculation of the annual differences, a duplicate table 'pf2' was added, where the same columns as in our main table 'pf' were selected through a nested query ('SELECT') and at the same time the empty ('NULL') records that were created in the primary table by merging the tables 'czechia_payroll' and 'czechia_price' through 'UNION' were excluded:

'WHERE mean_price_czk IS NOT NULL'

The tables were linked through matching food categories and years, where an extra year was added to the joined table 'pf2', thus shifting its records one year back:

'ON pf.price_year = pf2.price_year +1 AND pf.foodstuff_name = pf2.foodstuff_name

The table was joined using 'INNER JOIN' to remove undesired records with 'NULL' values resulting from shifting records in 'pf2' one year back -> records prior to 2006 are not available. At the same time, this also removed the empty values generated when the 'pf' table was created by merging 'cp' and 'cpr' through 'UNION' clause.

After successful joining of table 'pf2' the following changes were made in the outer 'SELECT' clause in the layout of the displayed columns:
* concat(pf.price_year," – ", pf2.price_year) AS time_period
* pf.foodstuff_name,
* pf.mean_price_czk AS latter_mean_price_czk
* pf2.mean_price_czk AS former_mean_price_czk
* round((pf.mean_price_czk - pf2.mean_price_czk) / pf2.mean_price_czk*100,2) AS percentage_price_difference

The selection above now displays the mean food prices and annual percentage differences of these mean prices between years. The records were then primarily ordered in descending order by year and then in ascending order by foodstuff category name in the first table:

'ORDER BY pf.price_year DESC, pf.foodstuff_name ASC'

Since the values regarding food prices were averaged and grouped by year and food category when the primary table was created, it was not necessary to set the 'GROUP BY' clause at this point (the results would be displayed the same). 

Because the number of records displayed at this point is very large (315 rows in total), it is not simple to interpret the data and form a conclusion about the rate of price changes for individual groceries; therefore, an overall mean was calculated from the annual differences of each foodstuff category.

In order to calculate this overall mean percentage difference, the entire existing query was nested in a new 'FROM' clause ('pf3') and through a new outer 'SELECT' clause, the mean percentage difference for each foodstuff category was calculated:
* pf3.foodstuff_name
* round(avg(pf3.percentage_price_difference,2) AS mean_percentage_price_difference

In order to group the calculations by food categories, it was necessary to set the 'GROUP BY' clause in our new outer query:

'GROUP BY pf3.foodstuff_name'

The final output was also ordered in ascending order by the newly calculated mean and foodstuff category name:

'ORDER BY mean_percentage_price_difference ASC, foodstuff_name ASC'

The SQL query to answer question 3 is now completed, and by executing it we get a list of groceries with their mean percentage year-to-year difference, which is ordered primarily by the level of this difference and secondarily by the name of each grocery.

### QUERY FOR QUESTION 4: 
Because the task requires us to determine whether there is a year in which the annual increase in food prices was significantly higher than the increase in salaries (greater than 10%), we needed to calculate the percentage differences between the annual means for salaries and food prices. To achieve this, supporting duplicate tables 'pf2' and 'pf3' were joined.

The first of the two tables 'pf2' was used for the calculation of the annual differences in salaries between years, so the columns with information about the year and the calculation of the mean salary were selected through a nested query:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (shall be rounded in further calculations)

The results in the table have also been stripped of blank records and grouped by year:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

At this point, the nested query of our table shows the total unrounded mean salaries for individual years. The table was then joined through 'INNER JOIN' by common years, where an extra year was added to 'pf2' to shift its records one year back:

'ON pf.payroll_year = pf2.payroll_year +1' 

Through this connection, an annual salary differences  were calculated in the external 'SELECT' clause (to be shown later).

The second supporting table 'pf3' was used to calculate the year-on-year differences in food prices. As the salary differences have been calculated via tables 'pf1' and 'pf2', a similar calculation method is not appropriate as the nature of the 'UNION' merging of tables 'cp' and 'cpr' would cause problems in displaying the results for food price differences. For this reason, the following columns have been prepared in this table for later calculation of the annual food price differences:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

In order to display these columns, a support table has been joined in the nested query: pf32 (pf31 is the first one), with its records shifted one year back:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

The tables were joined using 'INNER JOIN,' which removed unwanted 'NULL' records. Afterwards, the averaged values were grouped by year in the 'pf31' table:

'GROUP BY pf31.price_year'

The nested query in table 'pf3' is now complete and shows us two columns with unrounded mean food prices for each year, with one of the columns having the means shifted one year back so that the year-on-year differences could be calculated later.

The supporting table 'pf3' was then joined to the 'pf' table using 'INNER JOIN' based on common years:

'ON pf.payroll_year = pf3.price_year'

The 'INNER JOIN' ensures that the final outputs are limited to the common comparable periods for prices and salaries (2006-2018).

Note: by doing some of the calculations (averaging and grouping) already inside the supporting tables, the speed of running the final query is greatly increased.

Now that all the necessary sub-calculations have been made, the year-on-year percentage differences in mean salaries and prices were calculated through an external 'SELECT' clause; the annual difference between salaries and prices of foodstuffs was also calculated from these differences as follows:
* concat(pf.payroll_year," – ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* round(((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100),2) - round(((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100),2) AS salary_price_percentage_difference

Since the question is whether there is any year in which the annual increase in food prices was significantly higher than the increase in salaries, the difference was calculated in the following format: annual price difference % - annual salary difference %.

This completes the query to answer question 4. and running it shows us a summary of the year-on-year percentage differences in mean prices and salaries, as well as the differences in these year-on-year differences between salaries and food prices.
### QUERY FOR QUESTION 5: 
Since the task requires us to find out whether the level of GDP and its changes influence the development of salaries and food prices, we needed to calculate the year-on-year percentage differences for salaries, food prices and GDP. To achieve this, supporting duplicate tables 'pf2', 'pf3' and the secondary table containing data regarding GDP 'sf' have been joined.

As we need to calculate the percentage annual differences in salaries and food prices similarly to the previous query for question 4, the first part regarding the joining of the supporting tables 'pf2' and 'pf3' was basically the same, and so a large part of the query was taken over:

Table 'pf2' is to be used to calculate the year-on-year salary difference, therefore columns regarding the year and the calculation of the mean salary were selected through the nested query:
* payroll_year
* avg(mean_salary_czk) AS former_mean_salary_czk (to be rounded later)

Afterwards, the results were cleared of blank ('NULL'
) records and grouped by year:

'WHERE mean_salary_czk IS NOT NULL'
'GROUP BY payroll_year'

At the moment, the nested query of the supporting table shows the total mean salaries for each year. The table was then joined using 'INNER JOIN' by common years, where an extra year was added to 'pf2' to shift its records one year back:

'ON pf.payroll_year = pf2.payroll_year +1' 

Through this connection, year-on-year differences in salaries have been calculated in the external 'SELECT' clause (to be shown later).

We now proceed to table 'pf3' which is used to calculate the annual differences in food prices. Since the annual salary differences have been calculated through tables 'pf' and 'pf2', as in the previous task, we cannot use a similar calculation method because the 'UNION' merging of the tables 'cp' and 'cpr' would cause problems with the display of the results regarding food price differences. Therefore, the following columns have been prepared in this table for later calculation of the year-on-year food price differences:
* pf31.price_year
* avg(pf31.mean_price_czk) AS latter_mean_price_czk
* avg(pf32.mean_price_czk) AS former_mean_price_czk

In order to be able to display the columns shown above, secondary table has been joined in the nested query: pf32 (pf31 is the first one), whose records have been shifted one year back:
* price_year
* mean_price_czk

'ON pf31.price_year = pf32.price_year +1

The tables have been joined through 'INNER JOIN,' to remove undesired 'NULL' records. The results were then grouped by year:

'GROUP BY pf31.price_year'

The nested query in the supporting table 'pf3' is now complete and shows us two columns of unrounded mean foodstuff prices for each year, with one of the columns having the records shifted one year back so that the year-on-year differences could be calculated later.

Table 'pf3' was afterwards joined through an 'INNER JOIN' to table 'pf' through common years:

'ON pf.payroll_year = pf3.price_year'

Note: The 'INNER JOIN' ensures here that the final outputs are limited to the common comparable periods for both prices and salaries (2006-2018).

Note: similar to the previous task (query for question 4), some of the calculations (averaging and grouping) were already done within the supporting tables to increase the speed of running the whole query.

Now that duplicate tables 'pf2' and 'pf3' have been joined, it is time to join the secondary table (t_roman_zavorka_project_sql_secondary_final) 'sf,' containing data regarding the development of GDP in years:

As the calculations of the percentage annual differences in GDP are relatively simple (there is no need to calculate means or to group the data), they were calculated directly in the nested query through the following columns:
* sf11.`year`
* round((sf11.gdp - sf12.gdp) / sf12.gdp*100,2) AS annual_percentage_hdp_difference

However, in order to calculate the percentage annual differences in GDP, it was necessary to join the supporting duplicate table 'sf12' first ('sf11' is the first of the tables); following columns have been selected:
* country
* `year`
* gdp

Since the table contains data for different European countries, the records needed to be limited to the Czech Republic only:

"WHERE country = 'Czech republic'"

The inner table 'sf12' containing the GDP values in years for the Czech Republic was then joined to table 'sf11' using 'INNER JOIN' through common years and country name, with the records in 'sf12' shifted one year back:

'ON sf11.`year` = sf12.`year` +1 AND sf11.country = sf12.country'

Note: 'INNER JOIN' limits the records according to the selection in the inner table 'sf12' , that is records only for the Czech Republic.

At this point, the nested query for the 'sf' table is complete and running it shows us the percentage annual differences in GDP for the Czech Republic. The 'sf' table was then joined to the 'pf' table via 'INNER JOIN' ('LEFT JOIN' could also be used) through common years:

'ON pf.payroll_year = sf.`year`'

Next, once the three supporting tables have been joined, columns were then set up in the main 'SELECT' clause to calculate the percentage annual differences for salaries, foodstuff prices and hdp in years:
* concat(pf.payroll_year," – ",pf2.payroll_year) AS time_period
* round((avg(pf.mean_salary_czk) - pf2.former_mean_salary_czk) / pf2.former_mean_salary_czk*100,2) AS annual_percentage_salary_difference
* round((pf3.latter_mean_price_czk - pf3.former_mean_price_czk) / pf3.former_mean_price_czk*100,2) AS annual_percentage_price_difference
* sf.gdp_annual_difference (already calculated in the joined table)

In order to group these calculations by year (column 'pf.payroll_year' was selected), the 'GROUP BY' clause for the main query 'pf' was set as follows:

'GROUP BY pf.payroll_year'

Using the same column, the resulting records were ordered in descending order by year:

'ORDER BY pf.payroll_year DESC'

So far, the query shows us a table showing the development of the percentage differences in mean salaries and food prices and GDP between years. We can already see in this display a certain relationship between the development of GDP and the development of salaries and prices. 

However, in order to assess this relationship better, a breakdown of how the growth or decline rate developes between years - in other words, the difference of the annual percentage differences - has also been calculated.

To achieve this, our existing query was nested into a new 'outer' query in the 'FROM' clause, where the nested query was named 'pf4.' Following this, a copy of our nested query was joined via 'LEFT JOIN' which we named 'pf5. ' An additional column 'pf.payroll_year,' which we can use to link these queries together, was inserted into both 'pf4' and 'pf5,' and the 'pf5' records were shifted one year back:

'ON pf4.payroll_year = pf5.payroll_year +1'

'LEFT JOIN' was used to keep a record in the first year where the result is missing in the calculation of the change in growth rate.

Now that these tables have been linked, the columns in the main 'SELECT' clause have been set as follows:
* time_period
* pf4.annual_percentage_salary_difference
* pf4.annual_percentage_salary_difference-pf5.annual_percentage_salary_difference AS annual_percentage_salary_growth_difference
* pf4.annual_percentage_price_difference
* pf4.annual_percentage_price_difference-pf5.annual_percentage_price_difference AS annual_percentage_price_growth_difference
* pf4.annual_percentage_gdp_difference

This completes the query to answer question 5. The result is a summary of the percentage changes in salaries, food prices and GDP between years, as well as the differences in percentage increases (changes in growth or decline rates) between years.

## RESULTS
### QUESTION 1
Have salaries in all sectors been increasing over the years, or have they been declining in some?

According to the available data, there are only four sectors in which salaries have been increasing continuously:
* Doprava a skladování (Transportation and Warehousing)
* Ostatní èinnosti (Other activities)
* Zdravotní a sociální péèe (Health and social work activities)
* Zpracovatelský prùmysl (Manufacturing industries)

In the vast majority of the industries we analyzed, declines of different levels have been observed. These were mostly sudden, short-term declines (especially in year 2013), after which salaries started to rise again:
* Administrativní a podpùrné èinnosti (Administrative and support activities)
* Èinnosti v oblasti nemovitostí (Real estate activities)
* Informaèní a komunikaèní èinnosti	 (Information and communication activities (IT))	
* Penìžnictví a pojišovnictví	(Financial and insurance activities)
* Profesní, vìdecké a technické èinnosti (Professional, scientific and technical activities)
* Tìžba a dobývání (Mining and quarrying)
* Ubytování, stravování a pohostinství (Accommodation, catering and food service activities)
* Velkoobchod a maloobchod; opravy a údržba motorových vozidel  (Wholesale and retail trade; repair and maintenance of motor vehicles)
* Výroba a rozvod elektøiny, plynu, tepla a klimatiz. vzduchu (Production and distribution of electricity, gas, heat and air conditioning)
* Zásobování vodou; èinnosti související s odpady a sanacemi (Water supply; waste management and sanitation activities)

We also observed several sectors where, among other things, a gradual decline in increase and following decline in salaries can be observed at the end of the period for which data are available; therefore, this may not be just a simple drop, but there may be a long term decline in salaries in future years:
* Kulturní, zábavní a rekreaèní èinnosti (Culture, entertainment and recreation activities)
* stavebnictví (Construction activities)
* Veøejná správa a obrana; povinné sociální zabezpeèení (Public administration and defence; mandatory social security)
* Vzdìlávání (Education)
* Zemìdìlství, lesnictví, rybáøství (Agriculture, forestry, fishing)
### QUESTION 2
How many liters of milk and kilograms of bread can be bought in the first and last comparable periods in the available data on prices and salaries?

In the first comparable period, that is in 2006, the mean net salary was (with the basic tax discount) 16 044 CZK and a Kg of bread cost on the average 16,12 CZK and a litre of milk 14,44 CZK.

In the second comparable period in 2018, the mean net salary was (with the basic tax discount) 24 486 CZK. The average price per Kg of bread was 24,24 CZK and per litre of milk 19,82 CZK.

Therefore, for a given salary in 2006, it was possible to buy 995,29 Kg of bread and 1111,08 litres of milk, while for a given salary in 2018 it was 1010.15 Kg of bread and 1235,42 litres of milk; therefore, in the second comparative period, it was possible to buy more of these given foods.

Note: it should be noted here that the value of net pay is also significantly affected by various tax discounts ( for example child, spouse etc.) and so for simplicity only the basic taxpayer discount has been applied.
### QUESTION 3
Which category of food is increasing in price the slowest (has the lowest percentage annual increase)?

In the results we can see that, on average, the prices of the vast majority of foods are increasing; the exceptions are 'krystalový cukr' (crystal sugar) and 'Rajská jablka èervená kulatá' (red round tomatoes), which are decreasing by -1.92% and -0.74% on average per year. 

Therefore, according to the data, the hypothetical food category that is 'slowest in price increase' is 'Banány žluté' (yellow bananas), which on average increases in price by only 0.81% per year, followed by 'Vepøová peèenì s kostí' (pork roast with bones) with 0.99% per year. 

In contrast, food with the fastest price increasing on average seems to be 'Papriky' (peppers): 7.29% per year, followed by 'Máslo' (butter): 6.68% per year. 
### QUESTION 4
Is there a year in which the annual increase in food prices was significantly higher than the increase in salaries (greater than 10%)?

According to the results so far, the largest increase in prices compared to the increase in salaries was observed between years 2013-2012, where prices increased by 5.1% while salaries decreased by -1.56%, so the total difference is 6.66% in favour of the increase in prices. Thus, in no year did the difference reach even 10%. 

On the other hand, the lowest or largest difference in favour of salaries was observed between 2009-2008, where salaries rose by 3.16% while food prices fell by -6.42% and the overall difference is therefore -9.58% in favour of salaries.

In the period 2010-2009, the increase in salaries was at the same rate as the increase in food prices: 1.95%.

We can also observe that in these data the year 2013 is the only year where the mean annual percentage difference in salaries reached negative values; this is also confirmed by the results in results for question 1, where the vast majority of sectors showed a decrease in average salaries in this year.
### QUESTION 5
Does the GDP level affect changes in salaries and food prices? Or, if GDP rises more significantly in one year, does this result in a more significant rise in food prices or salaries in the same or the following year?

If we look at the changes in GDP over the years, we can see that for most years GDP has been growing, however, the exceptions are the periods 2009-2008 which shows a fairly significant decline of -4.66% and also smaller declines of -0.79% and -0.05% in the periods 2012-2011 and 2013-2012.

Comparing the development of GDP and the development of food prices, we can notice that at some points prices develop similarly to GDP, especially in 2007, 2008, and 2009, where GDP growth slows down and then it starts to fall (-4.66%), as do food prices (-6.42%). Then in 2010 and 2011, when GDP starts to grow again, prices also rise.

However, a change occurs in the periods 2012-2011 and 2013-2012, where GDP falls again, but more slightly (-0.05% and -0.79%) -> food price growth starts to slow down first, and only in the periods 2015-2014 and 2016-2015 do food prices fall (-0.55% and -1.19%), while GDP rises again by this time. After these delayed declines, food prices start to rise again, but the rate of increase oscillates strangely.

As with food prices, some response to GDP development can be seen in salaries, but it does not seem to be as visible. Except for the period 2013-2012, salaries are steadily rising.

In 2009-2008, when the decline in GDP was the largest (-4.66%), salaries in this and the following period only experienced a decline in the growth rate (-4.71% and -1.21%), which eventually started to recover. The decline in salaries was only observed in the period 2013-2012, when salaries fell by -1.56%, whereas in this and the previous period only slight declines in GDP (-0.05% and -0.79%) were observed in general, and it is therefore a question of whether this decline in salaries was due to these two milder declines or whether it was a delayed response to the strong decline in GDP of 2009-2008. In the following years, as GDP started to pick up again and growth accelerated, the growth in salaries started to accelerate as well.

From the data so far, it appears that the rate of GDP growth or decline affects the development of prices and salaries, so if GDP falls or rises significantly, it is very likely that there will be a fall or rise in salaries and food prices, or at least a change in the rate of growth or decline, but that effect may not occur until some time has passed. 

