/*
 Question: what are the top skills based on salary?
 _ Look at the avg salary associated with each skill for data analyst roles
 _ Focuses on roles with specified salary, regardles of location
 _ why? it reveals how differnet skills impact salary levels for data analyst and help identyfy the most financially rewarding skills in the field
 */
SELECT skills_dim.skills,
    ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_postings_fact.job_title_short = 'Data Scientist' -- AND job_postings_fact.job_work_from_home = True
    AND job_postings_fact.salary_year_avg IS NOT NULL
GROUP BY skills_dim.skills
ORDER BY avg_salary DESC
LIMIT 25;