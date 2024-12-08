/*
    Question: What are the top paying jobs for data analyst?
    -- Identify the top 10 highest paying Data Analyst job roles available in India.
    -- Focuses on job postings with specified salaries (remove nulls).
    -- Why? Highlight the top-paying opportunities for data analyst and offer insights into employment opportunities
*/

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
        job_location LIKE '%India' AND
        salary_year_avg IS NOT NULL
ORDER BY salary_year_avg DESC
LIMIT 10;

/*
Insights on Top-Paying Data Analyst Job Roles in India:
Highest Paying Role: Staff Applied Research Engineer at ServiceNow in Hyderabad leads with an average annual 
salary of ₹1,77,283, followed by roles like Data Architect and Technical Data Architect with salaries around ₹1.6–₹1.7 LPA.

Key Locations and Industries: High-paying roles are concentrated in Hyderabad, Bengaluru, and Gurugram, 
spanning industries like healthcare, product analytics, and technology.

Specialization and Seniority: Senior-level roles (e.g., Data Architect, Senior Analyst) and niche expertise 
significantly drive higher salaries, emphasizing the value of advanced skills and experience.
*/