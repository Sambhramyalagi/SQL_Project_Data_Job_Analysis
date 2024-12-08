/*
    Question: What are the most in-demand skills for my role?
    -- Display the top 5 skills by their demand in India
    -- Include skill Id, name,a nd count of postings requiring the skill
*/

SELECT 
        skills AS skill_name,
        COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%India'
GROUP BY skill_name
ORDER BY demand_count DESC
LIMIT 5;