/*
 Question: What are the top-paying data Analayst jobs?
 _ Identify the top 10 highest paying data analyst jobs available remotely.
 _ Focuse on job postnigs with specified salaries (remove nulls).
 _ Why? Highlight the top-paying opportunities for data analyst, offering insights into employment trends and salary benchmarks in the field.
 */
SELECT job_postings_fact.job_id,
    job_postings_fact.job_title,
    job_postings_fact.job_schedule_type,
    job_postings_fact.job_location,
    company_dim.name AS company_name,
    job_postings_fact.salary_year_avg,
    job_postings_fact.job_posted_date
FROM job_postings_fact
    LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_location = 'Anywhere'
ORDER BY salary_year_avg DESC
LIMIT 10;