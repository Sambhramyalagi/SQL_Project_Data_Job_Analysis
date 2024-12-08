# Introduction
Dive into the data job market! Focusing on data analyst roles, this project explores top_paying jobs, in_demand skills and where high demand meets high salary in data analytics.

Sql queries? check them out here: [project_sql folder](/project_sql/)
# Background
Driven by a quest to navigate the data analyst job market more effectively, this project was born from a desire to pinpoint top_paid and in_demand skills, stremlining others work to find optimal jobs.

## The questions I wanted to answer through my SQL queries were:

1. What are the top_paying data analyst jobs in india?
2. What skills are required for these top_paying jobs?
3. What skills are most in demand for data analytics?
4. which skills are associated with higher salaries?
5. What are the most optimal skills to learn?

# Tools I Have Used
For my deep dive into the data analyst job market,
I harnessed the power of several key tolls:

- **SQL:** The backbone of my analysis, allowing me to query the database and unearth critical insights.
- **PostgresSQL:** The chosen database management system, ideal for handling the job posting data.
- **Visual Studio Code:** My go-to for database management and executing SQL queries.
- **Git & HitHub:** Essentials for version control and sharing my SQL scripts and analysis, ensuring collabration and project tracking.
# The Analysis
Each query for this project aimed at investigating specific aspects of the data analyst job market.
Here's how  approached each question:

### 1. Top Paying Data Analyst Jobs
To identify the highest-paying roles, I filtered data anayst positions by average yearly salary and location, focusing on India based jobs. This query highlights the high paying opportunities in the field.

```sql
SELECT
        job_id,
        job_title,
        job_location,
        job_schedule_type,
        salary_year_avg,
        job_posted_date,
        name AS company_name
FROM 
        job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE 
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%India%' AND
        salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;
```
Insights on Top-Paying Data Analyst Job Roles in India:

- **Highest Paying Role:** Staff Applied Research Engineer at ServiceNow in Hyderabad leads with an average annual 
salary of ₹1,77,283, followed by roles like Data Architect and Technical Data Architect with salaries around ₹1.6–₹1.7 LPA.

- **Key Locations and Industries:** High-paying roles are concentrated in Hyderabad, Bengaluru, and Gurugram, 
spanning industries like healthcare, product analytics, and technology.

- **Specialization and Seniority:** Senior-level roles (e.g., Data Architect, Senior Analyst) and niche expertise 
significantly drive higher salaries, emphasizing the value of advanced skills and experience.

### 2. Skills for Top Paying Jobs
To Understand what skills are required for the top-paying jobs. I joined the job postings with the skills data, providing insights into what employers value for high-compensation roles.

```sql
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
                job_location LIKE '%India%' AND
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
```
Insights on skills required for top-paying jobs:

- **Core Skills for High-Paying Data Roles:** Commonly required technical skills include SQL, Python, NoSQL databases (e.g., MongoDB, PostgreSQL, Neo4j), cloud platforms (Azure, AWS), and data engineering tools like Spark, Hadoop, and Airflow. Additionally, proficiency in data visualization tools like Power BI and Tableau is highly valued.

- **Emerging Trends and Specialized Skills:** Specialized technologies such as Databricks, Kafka, Snowflake, and GDPR compliance knowledge are in demand for roles like Data Architect and Senior Analyst, reflecting the evolving complexity of data management in industries like healthcare and genomics.

- **Role-Specific Diversification:** Business-focused roles (e.g., Senior Business Analyst) emphasize soft skills and tools like Excel, Jira, and Confluence, while technical roles prioritize shell scripting, programming languages like Scala and Go, and operational tools like Jenkins and GitLab.

### 3. In-Demand Skills for Data Analysts
This query helped identify the skills most frequently requested in job postings, directing focus to area with high demand skills

```sql
SELECT 
        skills AS skill_name,
        COUNT(job_postings_fact.job_id) AS demand_count
FROM job_postings_fact
INNER JOIN skills_job_dim ON job_postings_fact.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE 
        job_title_short = 'Data Analyst' AND
        job_location LIKE '%India%'
GROUP BY skill_name
ORDER BY demand_count DESC
LIMIT 5;
```

Insights on In-demand skills for Data Analyst in India:

1. **SQL Leads the Demand**
- SQL is the most in-demand skill with 2,561 mentions. This indicates that it is essential for Data Analysts, as it is widely used for querying and managing data in relational databases.
2. **Python: Versatile and Highly Sought After**
- Python ranks second with 1,802 mentions. Its demand highlights its versatility, as it can handle data analysis, visualization, and machine learning tasks. This makes it a valuable tool in data analytics.
3. **Excel: A Classic Skill Still in High Demand**
- Excel remains relevant with 1,718 mentions, proving its importance in data handling, reporting, and visualization, especially for smaller-scale or quick analyses.
4. **Tableau: A Key Player in Data Visualization**
- Tableau has 1,346 mentions, reflecting its popularity as a powerful tool for creating interactive and shareable dashboards.
5. **Power BI: A Growing Competitor**
- Power BI, with 1,043 mentions, is another important tool for data visualization and business intelligence. Its integration with Microsoft Office products makes it a preferred choice for many organizations.
6. **Visualization Tools are Key**
- Combining Tableau and Power BI demand (total 2,389 mentions) shows that data visualization skills are highly valued, almost as much as SQL.

#### Recommendations for Aspiring Data Analysts:
1. **Prioritize SQL Mastery:** Start with SQL as it is foundational and indispensable for data manipulation.
2. **Learn Python:** Focus on its libraries like Pandas, NumPy, and Matplotlib for data manipulation and visualization.
3. **Get Proficient in Excel:** Enhance your skills in advanced Excel functionalities like pivot tables, VLOOKUP, and macros.
4. **Master at Least One Visualization Tool:** Choose either Tableau or Power BI based on industry preferences, though knowing both is advantageous.
5. **Keep Upgrading:** Explore related skills like statistical analysis, R, or cloud platforms like AWS or Azure to further enhance employability.

### 4. Skills based on salary
Exploring the average salaries associated with different skills revealed which skills are the highest paying.

```sql
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
```
Insights on skills which are required for high-pay jobs:

1. **High-paying skills revolve around data technologies and programming:** Skills such as PySpark, GitLab, PostgreSQL, and MySQL are highly valued, with an average salary of around $165,000. These tools are crucial in data engineering, database management, and software development.

2. **Big Data and Cloud technologies are in demand:** Tools like Neo4j, Airflow, Kafka, and Databricks show significant earning potential, suggesting that expertise in big data technologies and cloud computing can lead to high-paying roles.

3. **Data analytics and visualization tools also offer good salaries:** Skills related to data analysis, such as Pandas, DAX, and Matplotlib, although slightly lower in salary, still provide lucrative opportunities with an average salary around $110,000 to $120,000.

### 5. Most optimal skills to learn 
Combining insights from demand and salary data, this query aimed to pinpoint skills that are both in high demand and have high salaries, offering a strategic focus for skill deveelopment.

```sql
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
            job_location LIKE '%India%'
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
            job_location LIKE '%India%' AND
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
```

Insights on most optimal skills to learn (aka high in-demand as well as high-paying jobs in India):

1. **High Demand and Salary Skills:** Skills like MySQL, Pyspark, and Databricks have high demand (over 100 mentions) and offer an average salary of around ₹165,000, making them highly valuable for a Data Analyst.

2. **Key Skills for Career Growth:** Tools like Power BI (with 1043 mentions and a salary of ₹109,832), Spark, and Hadoop are in high demand, signaling their importance for expanding data analytics roles and career opportunities.

3. **Specialized Skills with Niche Demand:** Skills such as GDPR, Airflow, and Kafka have a moderate demand (37-70 mentions) but still offer competitive salaries, making them valuable for specialized roles in data governance, workflow automation, and data streaming.

# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some series firepower:
- **Complex Query Crafting:** Mastered the art of advanced SQL, mergiing tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **SQL Joins:** Mastered the art of using joins in SQL from this project
# Conclusions

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysis can better position themselves in a competative job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continous learning and adaption to emerging trends in the field of data analytics.