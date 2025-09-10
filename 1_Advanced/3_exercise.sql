/*
 find the count of the number of remote job posting per skill
 -display the top 5 skills by their demand in remote jobs
 -include the skill ID, and count of postinggs requiringg the skill
 */
WITH remote_jobs_skills AS (
    SELECT skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim AS skills_to_job
        INNER JOIN job_postings_fact AS job_postings ON skills_to_job.job_id = job_postings.job_id
    WHERE job_work_from_home = 'true'
        AND job_title_short = 'Data Analyst'
    GROUP BY skill_id
)
SELECT remote_jobs_skills.skill_id,
    skills.skills,
    remote_jobs_skills.skill_count
FROM remote_jobs_skills
    INNER JOIN skills_dim AS skills ON remote_jobs_skills.skill_id = skills.skill_id
ORDER BY remote_jobs_skills.skill_count DESC
LIMIT 5;