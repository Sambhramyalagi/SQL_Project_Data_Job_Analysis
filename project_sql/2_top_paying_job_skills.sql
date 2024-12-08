/*
    Question: What skills are required for the top-paying data analyst jobs?
    -- Use the top 10 highest_paying data analyst jobs from the first query.
    -- Add the specific skills required for these roles.
    Why? It provides a detailed look at which high_paying jobs demand certain skills,
        helping job seekers understand which skills to develop that align with top salaries
*/
WITH top_paying_jobs AS (
        SELECT
                job_id,
                job_title,
                salary_year_avg,
                name AS company_name
        FROM 
                job_postings_fact
        LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
        WHERE 
                job_title_short = 'Data Analyst' AND
                job_location LIKE '%India' AND
                salary_year_avg IS NOT NULL
        ORDER BY salary_year_avg DESC
        LIMIT 10
)
SELECT 
        top_paying_jobs.*,
        skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id;

/*
Core Skills for High-Paying Data Roles: Commonly required technical skills include SQL, 
Python, NoSQL databases (e.g., MongoDB, PostgreSQL, Neo4j), cloud platforms (Azure, AWS), 
and data engineering tools like Spark, Hadoop, and Airflow. Additionally, proficiency in data 
visualization tools like Power BI and Tableau is highly valued.

Emerging Trends and Specialized Skills: Specialized technologies such as Databricks, Kafka, 
Snowflake, and GDPR compliance knowledge are in demand for roles like Data Architect and Senior 
Analyst, reflecting the evolving complexity of data management in industries like healthcare and genomics.

Role-Specific Diversification: Business-focused roles (e.g., Senior Business Analyst) emphasize soft 
skills and tools like Excel, Jira, and Confluence, while technical roles prioritize shell scripting, 
programming languages like Scala and Go, and operational tools like Jenkins and GitLab.
*/