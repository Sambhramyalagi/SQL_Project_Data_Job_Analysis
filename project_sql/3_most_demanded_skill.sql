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

/*
Insights on In-demand skill for Data Analyst in India:

SQL Leads the Demand:
SQL is the most in-demand skill with 2,561 mentions. This indicates that it is essential 
for Data Analysts, as it is widely used for querying and managing data in relational databases.

Python: Versatile and Highly Sought After:
Python ranks second with 1,802 mentions. Its demand highlights its versatility, as it can 
handle data analysis, visualization, and machine learning tasks. This makes it a valuable tool in data analytics.

Excel: A Classic Skill Still in High Demand:
Excel remains relevant with 1,718 mentions, proving its importance in data handling, reporting, and 
visualization, especially for smaller-scale or quick analyses.

Tableau: A Key Player in Data Visualization:
Tableau has 1,346 mentions, reflecting its popularity as a powerful tool for creating interactive and 
shareable dashboards.

Power BI: A Growing Competitor:
Power BI, with 1,043 mentions, is another important tool for data visualization and business intelligence. 
Its integration with Microsoft Office products makes it a preferred choice for many organizations.

Visualization Tools are Key:
Combining Tableau and Power BI demand (total 2,389 mentions) shows that data visualization skills are 
highly valued, almost as much as SQL.


Recommendations for Aspiring Data Analysts:
Prioritize SQL Mastery: Start with SQL as it is foundational and indispensable for data manipulation.

Learn Python: Focus on its libraries like Pandas, NumPy, and Matplotlib for data manipulation and visualization.

Get Proficient in Excel: Enhance your skills in advanced Excel functionalities like pivot tables, VLOOKUP, 
and macros.

Master at Least One Visualization Tool: Choose either Tableau or Power BI based on industry preferences, 
though knowing both is advantageous.

Keep Upgrading: Explore related skills like statistical analysis, R, or cloud platforms like AWS or Azure 
to further enhance employability.

*/