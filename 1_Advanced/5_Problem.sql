/*
 Find job Postings from the first quarter that have a salary greater than $70K
 - Combine job posting table from the first quarter of 2023 (Jan-Mar)
 - Gets job Postings with an average yearly salary > $70,000
 */
SELECT q1_job_postings.job_location,
    q1_job_postings.job_via,
    q1_job_postings.job_posted_date::DATE,
    q1_job_postings.salary_year_avg
FROM (
        SELECT *
        FROM january_jobs
        UNION ALL
        SELECT *
        FROM february_jobs
        UNION ALL
        SELECT *
        FROM march_jobs
    ) AS q1_job_postings
WHERE q1_job_postings.salary_year_avg > 70000
    AND job_title_short = 'Data Analyst'
ORDER BY q1_job_postings.salary_year_avg DESC;