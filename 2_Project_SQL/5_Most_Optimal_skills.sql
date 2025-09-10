/*
 Question: What are the most optimal skills to learn(high-demand and high-paying)
 _ Identify skills in high demand and associated with high avg salaries for Data Analyst roles.
 _ concentrate on skills that offer job secutrity (high demand) and financial benefits( high salary).
 _ why? targets skills that enhance employability and earning potential.
 */
WITH skills_demand AS (
    SELECT skills_dim.skills,
        skills_job_dim.skill_id,
        COUNT(skills_job_dim.job_id) AS demand_count
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst'
        AND job_postings_fact.job_work_from_home = True
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id,
        skills_dim.skills
),
avg_salary AS (
    SELECT skills_dim.skills,
        skills_job_dim.skill_id,
        ROUND (AVG(job_postings_fact.salary_year_avg), 0) AS avg_salary
    FROM job_postings_fact
        INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
        INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_postings_fact.job_title_short = 'Data Analyst' -- AND job_postings_fact.job_work_from_home = True
        AND job_postings_fact.salary_year_avg IS NOT NULL
    GROUP BY skills_job_dim.skill_id,
        skills_dim.skills
)
SELECT skills_demand.skill_id,
    skills_demand.skills,
    skills_demand.demand_count,
    avg_salary.avg_salary
FROM skills_demand
    INNER JOIN avg_salary ON skills_demand.skill_id = avg_salary.skill_id
WHERE skills_demand.demand_count > 10
ORDER BY avg_salary.avg_salary DESC,
    skills_demand.demand_count DESC
LIMIT 25;