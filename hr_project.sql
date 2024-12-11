CREATE DATABASE hr_project;

USE hr_project;

SELECT *
FROM hr;

ALTER TABLE hr
CHANGE COLUMN ï»¿id emp_id VARCHAR(20) NULL;

-- To update the database
SET sql_safe_updates = 0;

-- Reformat birthdate
START TRANSACTION;
UPDATE hr
SET birthdate = CASE
	WHEN Birthdate LIKE '%/%' THEN date_format(str_to_date(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN Birthdate LIKE '%-%' THEN date_format(str_to_date(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN birthdate DATE;

-- Reformat hire_date
UPDATE hr
SET hire_date = CASE
	WHEN hire_date LIKE '%/%' THEN date_format(str_to_date(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN date_format(str_to_date(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

ALTER TABLE hr
MODIFY COLUMN hire_date DATE;

-- Reformatting termdate
UPDATE hr
SET termdate = date(str_to_date(termdate, '%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

SET SQL_MODE = '';

ALTER TABLE hr
MODIFY COLUMN termdate DATE;

-- Add an age column to dataset
ALTER TABLE hr
ADD COLUMN age INT;

UPDATE hr
SET age = timestampdiff(YEAR, birthdate, CURDATE());

-- There are erroneous data about birthdate. Based on the company's hiring policies, outlier records are set to age 40
UPDATE hr
SET 
	age = 40
WHERE 
	age < 22 or age > 65;

-- Add a tenure column to the dataset
ALTER TABLE hr
ADD COLUMN Tenure int;

UPDATE hr
SET Tenure = CASE
		WHEN termdate != 0000-00-00 THEN timestampdiff(YEAR, hire_date, termdate)
		ELSE timestampdiff(YEAR, hire_date, CURDATE())
	END;
    