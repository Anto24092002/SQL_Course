/*
 Question: What skills are required for the top-paying data Analyst jobs?
 _ Use the top 10 highest paying data analyst jobs available remotely from the previous query.
 _ Add the specific skills required for each job posting.
 Why? It provides a detailed look on which high-paying jobs demand certain skills,
 helping job seekers tailor their skillset to meet market demands.
 */
WITH top_data_analyst_jobs AS (
    SELECT job_postings_fact.job_id,
        job_postings_fact.job_title,
        company_dim.name AS company_name,
        job_postings_fact.salary_year_avg
    FROM job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
    WHERE job_title_short = 'Data Analyst'
        AND salary_year_avg IS NOT NULL
        AND job_location = 'Anywhere'
    ORDER BY salary_year_avg DESC
    LIMIT 10
)
SELECT top_data_analyst_jobs.*,
    skills_dim.skills
FROM top_data_analyst_jobs
    INNER JOIN skills_job_dim ON top_data_analyst_jobs.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY top_data_analyst_jobs.salary_year_avg DESC;
/*
 Here’s the breakdown of the most frequent skills across those jobs:
 
 SQL → appears in 8 out of 10 jobs
 
 Python → appears in 7 out of 10 jobs
 
 Tableau → appears in 6 out of 10 jobs
 
 R → appears in 4 out of 10 jobs
 
 Snowflake, Pandas, Excel → each in 3 jobs
 
 Azure, Bitbucket, Go → each in 2 jobs
 
 ✅ Conclusion:
 The skill that appears the most in the top 10 highest-paying jobs is SQL, followed closely by Python.
 
 Do you want me to also show you a visual chart of this skill frequency for the top 10 jobs?
 */