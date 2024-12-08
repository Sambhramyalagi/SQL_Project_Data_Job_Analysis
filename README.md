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
# What I learned
Throughout this adventure, I've turbocharged my SQL toolkit with some series firepower:
- **Complex Query Crafting:** Mastered the art of advanced SQL, mergiing tables like a pro and wielding WITH clauses for ninja-level temp table maneuvers.
- **Data Aggregation:** Got cozy with GROUP BY and turned aggregate functions like COUNT() and AVG() into my data-summarizing sidekicks.
- **SQL Joins:** Mastered the art of using joins in SQL from this project
# Conclusions

### Closing Thoughts

This project enhanced my SQL skills and provided valuable insights into the data analyst job market. The findings from the analysis serve as a guide to prioritizing skill development and job search efforts. Aspiring data analysis can better position themselves in a competative job market by focusing on high-demand, high-salary skills. This exploration highlights the importance of continous learning and adaption to emerging trends in the field of data analytics.