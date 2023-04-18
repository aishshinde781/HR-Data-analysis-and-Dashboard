
-- 1. What is the gender breakdoun of emlpoyes in the company?
SELECT gender,count(*) AS count
FROM hr
WHERE age >=18 AND termdate = ''
GROUP BY gender;

-- 2. What is the race breskdown of employees in the company?
SELECT race,count(*) AS count
FROM hr
WHERE age>=18 AND termdate = ''
GROUP BY race
ORDER BY count(*)DESC;

-- 3. What is the age distribution of employees in the company?
SELECT
   min(age) AS youngest,
   max(age) AS oldest
FROM hr
WHERE age>= 18 AND termdate = ''

SELECT
   CASE
     WHEN age>= 18 AND age<=24 THEN '18-24'
     WHEN age>= 25 AND age<=34 THEN '25-34'
     WHEN age>= 32 AND age<=44 THEN '35-44'
     WHEN age>= 45 AND age<=54 THEN '45-54'
     WHEN age>= 55 AND age<=64 THEN '55-64'
     ELSE '65+'
END AS age_group,
count(*) AS count
FROM hr
WHERE age>=18 AND termdate = ''
GROUP BY age_group
ORDER BY age_group;

SELECT
   CASE
     WHEN age>= 18 AND age<=24 THEN '18-24'
     WHEN age>= 25 AND age<=34 THEN '25-34'
     WHEN age>= 32 AND age<=44 THEN '35-44'
     WHEN age>= 45 AND age<=54 THEN '45-54'
     WHEN age>= 55 AND age<=64 THEN '55-64'
     ELSE '65+'
END AS age_group,gender,
count(*) AS count
FROM hr
WHERE age>=18 AND termdate = ''
GROUP BY age_group,gender
ORDER BY age_group,gender;

-- 4. How maqny employees work at headquarters versus remote locations?
SELECT location,count(*) AS count
FROM hr
WHERE age>=18 AND termdate = ''
GROUP BY location;

-- 5. What is the average length of employement for employees who have been terminated?
SELECT
  round(avg(datediff(termdate,hire_date))/365,0) AS avg_length_employement
   FROM hr
   WHERE termdate <= curdate() AND termdate<> '' AND age>=18;

-- 6. How does the gender distribution vary across departments and job titles?
SELECT department,gender,COUNT(*) AS count
FROM hr
WHERE age>= 18 AND termdate = ''
GROUP BY department,gender
ORDER BY department;

-- 7. What is the distribution of jobtitle across the company?
SELECT jobtitle,count(*) AS count
FROM hr
WHERE age>=18 AND termdate = ''
GROUP BY jobtitle
ORDER BY jobtitle DESC;

-- 8. Which department has the highest temination rate?
SELECT department,
   total_count,
   terminated_count,
   terminated_count/total_count AS termination_rate
FROM(
  SELECT department,
  count(*) AS total_count,
  SUM(CASE WHEN termdate<>'' AND termdate <=curdate() THEN 1 ELSE 0 END) AS terminated_count
  FROM hr
  WHERE age>= 18
  GROUP BY department
  ) AS subquery
ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state,count(*) AS count
FROM hr
WHERE age>=18 AND termdate = ''
GROUP BY location_state
ORDER BY count DESC;

-- 10. How has the company's employee count changed over time based on hire and term dates?
SELECT
year,
hires,
terminations,
hires-terminations AS net_change,
round((hires-terminations)/hires*100,2) AS net_change_percent
FROM(
    SELECT YEAR(hire_date) AS year,
    count(*) AS hires,
    SUM(CASE WHEN termdate<> '' AND termdate <= curdate()THEN 1 else 0 END) AS terminations
    FROM hr
	WHERE age >=18
    GROUP BY YEAR(hire_date)
    ) AS subquery
ORDER BY year ASC;

-- 11. What is the tenure distribution for each department?
SELECT department,round(avg(datediff(termdate,hire_date)/365),0) AS avg_tenure
FROM hr
WHERE termdate <= curdate() AND termdate<> '' AND age >= 18
GROUP BY department;




     
   