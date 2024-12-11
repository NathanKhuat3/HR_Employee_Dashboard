-- QUERIES
USE hr_project;

SELECT *
FROM hr;

-- 1. What is the age distribution of employees?
SELECT
	age, 
    COUNT(age) AS count_age
FROM hr 
WHERE termdate = 0000-00-00
GROUP BY age
ORDER BY age;

-- 2. What is the gender distribution of employees?
SELECT
	gender,
    ROUND(COUNT(*) / (SELECT COUNT(*) FROM hr WHERE termdate = 0000-00-00) * 100, 0) AS percentage
FROM hr
WHERE termdate = 0000-00-00
GROUP BY gender;

-- 3. What is the racial distribution of employees?
SELECT
	race,
    COUNT(*) AS distribution
FROM hr
WHERE termdate = 0000-00-00
GROUP BY race;

-- 4. How do workforce demographics vary by location city?
SELECT
	location_city,
    COUNT(*) AS distribution
FROM hr
WHERE termdate = 0000-00-00
GROUP BY location_city;

-- 5. What is the average age of employees?
SELECT
	ROUND(AVG(age), 0) AS avg_age
FROM hr
WHERE termdate = 0000-00-00;

-- 6. What is the average tenure of employees?
SELECT
	ROUND(AVG(Tenure), 0) AS avg_tenure
FROM hr
WHERE termdate = 0000-00-00;

-- 7. What is the current number of employees
SELECT
	COUNT(emp_id) AS num_emp
FROM hr
WHERE termdate = 0000-00-00;

-- 8. What is the job title that has the highest number of employees?
SELECT
	jobtitle,
	COUNT(emp_id) AS num_emp
FROM hr
WHERE termdate = 0000-00-00
GROUP BY jobtitle
ORDER BY COUNT(emp_id) DESC
LIMIT 1;

-- 9. What is the average annual number of new hires
SELECT	
	ROUND(AVG(avg_new_hire), 0) AS avg_annual_hire
    FROM (SELECT 
			YEAR(hire_date), 
            COUNT(*) AS avg_new_hire 
		FROM hr 
		GROUP BY YEAR(hire_date)) table1;

-- 10. What is the distribution of employees across departments
SELECT
	department,
    COUNT(emp_id) AS distribution
FROM hr
WHERE termdate = 0000-00-00
GROUP BY department;

-- 11. What is the average tenure of employees by department?
SELECT
	department,
    ROUND(AVG(Tenure), 0) AS avg_tenure
FROM hr
WHERE termdate = 0000-00-00
GROUP BY department;

-- 12. What has the hiring trend been during the 5 year period from 2015-2020 in terms of gender and race?
SELECT
    race,
    gender,
    COUNT(emp_id) AS num_emp_hired
FROM hr
WHERE YEAR(hire_date) BETWEEN 2015 AND 2020
GROUP BY  race, gender
ORDER BY race;

-- 13. What has the firing trend been during the 5 year period from 2015-2020 in terms of gender and race?
SELECT
    race,
    gender,
    COUNT(emp_id) AS num_emp_term
FROM hr
WHERE YEAR(termdate) BETWEEN 2015 AND 2020
GROUP BY  race, gender
ORDER BY race;