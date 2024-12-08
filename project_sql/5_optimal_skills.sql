/*
    Question: What are the most optimal skills to learn (aka its's in high demand and a high-paying skill)?
    -- Identify skills in high demand and associated with high average salaries for Data Analyst roles
    -- Concentrates on India based jobs with specified salaries
    -- Why?Targets skills that offer job security (high demand) and financial benefits (high salaries),
        offering strategic insights for career development in data analysis.
*/

WITH skill_demand AS
(
    SELECT 
            skills_dim.skill_id,
            skills_dim.skills,
            COUNT(job_postings_fact.job_id) AS demand_count
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
            job_title_short = 'Data Analyst' AND
            job_location LIKE '%India'
    GROUP BY 
            skills_dim.skill_id
),
salary_avg AS
( 
    SELECT 
            skills_job_dim.skill_id,
            ROUND (AVG (salary_year_avg), 0)AS avg_salary
    FROM job_postings_fact
    INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE 
            job_title_short = 'Data Analyst' AND
            job_location LIKE '%India' AND
            salary_year_avg IS NOT NULL
    GROUP BY 
            skills_job_dim.skill_id
)
SELECT 
        skill_demand.skill_id,
        skill_demand.skills,
        skill_demand.demand_count,
        salary_avg.avg_salary
FROM skill_demand
INNER JOIN salary_avg ON skill_demand.skill_id = salary_avg.skill_id
WHERE
        demand_count > 10
ORDER BY
        avg_salary DESC,
        demand_count DESC
LIMIT 25;

/*

High Demand and Salary Skills: Skills like MySQL, Pyspark, and Databricks have high demand (over 100 mentions)
and offer an average salary of around ₹165,000, making them highly valuable for a Data Analyst.

Key Skills for Career Growth: Tools like Power BI (with 1043 mentions and a salary of ₹109,832), Spark, and Hadoop 
are in high demand, signaling their importance for expanding data analytics roles and career opportunities.

Specialized Skills with Niche Demand: Skills such as GDPR, Airflow, and Kafka have a moderate demand (37-70 mentions) 
but still offer competitive salaries, making them valuable for specialized roles in data governance, workflow automation,
and data streaming.

*/