/*
    Answer: What are the skills based on salary?
    -- Look at the average salary associated with each skill for Data Analyst positions
    -- Focuses on roles with specified salaries, reguardless of location
    -- Why? It reveals how different skills impact salary levels for Data Analysts and
        helps identify the most financially rewarding skills to acquire or improve
*/

SELECT 
        skills,
        ROUND (AVG (salary_year_avg), 0)AS avg_salary
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%India%' AND
        salary_year_avg IS NOT NULL
GROUP BY skills
ORDER BY avg_salary DESC
LIMIT 25;

/*
Key Insights:

Top-Paying Skills:
The highest-paying skills with an average salary of $165,000 are:
Linux
GitLab
PySpark
MySQL
PostgreSQL
These skills primarily belong to data engineering, system administration, and database management domains.

Emerging Skills:
GDPR and Neo4j stand out with salaries of $163,782, indicating a demand for expertise in data privacy compliance and graph databases, respectively.
Both are niche areas, with GDPR being compliance-specific and Neo4j focused on graph database modeling.

Moderate-Paying Skills:
Tools like Airflow ($138,088), Databricks ($135,994), and MongoDB ($135,994) show a steady demand in data pipeline automation and cloud-based data platforms.
Programming languages like Scala ($135,994) are critical in big data and backend development.

Popular Data Tools:
Pandas ($122,463) and Matplotlib ($111,175) demonstrate the high demand for data analytics and visualization skills in data science.
Lower-End of High-Paying Skills:

Skills like Electron, Bash, and Snowflake ($111,175–$111,213) still offer lucrative opportunities but are slightly lower compared to cutting-edge or niche technologies.

Trends and Recommendations:

High Demand in Big Data and Cloud:
Skills like PySpark, Databricks, Airflow, and Hadoop indicate a strong trend in big data frameworks and cloud-based platforms. Upskilling in these areas can be highly lucrative.

Cross-Functional Skills in DevOps:
Tools such as GitLab, Jira, and Confluence are crucial in collaboration and version control. These skills bridge development and operations, making them essential in agile environments.

Specialization Pays:
Niche skills like Neo4j and GDPR compliance cater to specialized industries and roles, often commanding higher salaries due to limited talent availability.

Focus on Automation:
Tools like Airflow and scripting languages like Shell and Bash are key to workflow automation and system efficiency, showing the increasing importance of automation expertise.
*/