CREATE DATABASE IF NOT EXISTS hr_analytics_db;
USE hr_analytics_db;

DROP TABLE IF EXISTS hr_data;

CREATE TABLE hr_data (
    Age INT,
    Attrition VARCHAR(10),
    BusinessTravel VARCHAR(50),
    DailyRate INT,
    Department VARCHAR(100),
    DistanceFromHome INT,
    Education INT,
    EducationField VARCHAR(100),
    EmployeeCount INT,
    EmployeeNumber INT,
    EnvironmentSatisfaction INT,
    Gender VARCHAR(10),
    HourlyRate INT,
    JobInvolvement INT,
    JobLevel INT,
    JobRole VARCHAR(100),
    JobSatisfaction INT,
    MaritalStatus VARCHAR(50),
    MonthlyIncome INT,
    MonthlyRate INT,
    NumCompaniesWorked INT,
    Over18 VARCHAR(5),
    OverTime VARCHAR(5),
    PercentSalaryHike INT,
    PerformanceRating INT,
    RelationshipSatisfaction INT,
    StandardHours INT,
    StockOptionLevel INT,
    TotalWorkingYears INT,
    TrainingTimesLastYear INT,
    WorkLifeBalance INT,
    YearsAtCompany INT,
    YearsInCurrentRole INT,
    YearsSinceLastPromotion INT,
    YearsWithCurrManager INT
);

-- ============================================
-- 📊 Query 1: Overall Attrition Rate
-- ============================================
-- This query calculates the total number of employees,
-- how many have left the company, and the attrition rate.
SELECT 
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_percentage
FROM hr_data;

-- ============================================
-- 📊 Query 2: Attrition by Department
-- ============================================
-- This shows how attrition varies across different departments.
SELECT 
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_percentage
FROM hr_data
GROUP BY Department;

-- ============================================
-- 📊 Query 3: Average Monthly Income by Job Role
-- ============================================
-- Compares salary levels across job roles.
SELECT 
    JobRole,
    ROUND(AVG(MonthlyIncome), 2) AS average_income
FROM hr_data
GROUP BY JobRole
ORDER BY average_income DESC;

-- ============================================
-- 📊 Query 4: Overtime vs Attrition
-- ============================================
-- Checks if overtime work is related to employee attrition.
SELECT 
    OverTime,
    Attrition,
    COUNT(*) AS count
FROM hr_data
GROUP BY OverTime, Attrition
ORDER BY OverTime, Attrition;

-- ============================================
-- 📊 Query 5: Attrition by Gender
-- ============================================
-- Compares attrition rates between male and female employees.
SELECT 
    Gender,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    COUNT(*) AS total_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_percentage
FROM hr_data
GROUP BY Gender;

-- ============================================
-- 📊 Query 6: Job Satisfaction vs Performance Rating
-- ============================================
-- Helps analyze how satisfaction and performance are related.
SELECT 
    JobSatisfaction,
    PerformanceRating,
    COUNT(*) AS employee_count
FROM hr_data
GROUP BY JobSatisfaction, PerformanceRating
ORDER BY JobSatisfaction, PerformanceRating;

-- ============================================
-- 📊 Query 7: Attrition by Age Group
-- ============================================
-- Buckets employees into age groups and shows attrition rate
SELECT 
    CASE
        WHEN Age < 25 THEN 'Under 25'
        WHEN Age BETWEEN 25 AND 34 THEN '25-34'
        WHEN Age BETWEEN 35 AND 44 THEN '35-44'
        WHEN Age BETWEEN 45 AND 54 THEN '45-54'
        ELSE '55 and above'
    END AS age_group,
    COUNT(*) AS total,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_percentage
FROM hr_data
GROUP BY age_group
ORDER BY age_group;

-- ============================================
-- 📊 Query 8: Average Income vs Years at Company
-- ============================================
-- Checks if staying longer leads to higher pay
SELECT 
    YearsAtCompany,
    ROUND(AVG(MonthlyIncome), 2) AS avg_income,
    COUNT(*) AS employee_count
FROM hr_data
GROUP BY YearsAtCompany
ORDER BY YearsAtCompany;

-- ============================================
-- 📊 Query 9: Attrition by Education Field
-- ============================================
-- Finds which education fields see higher attrition
SELECT 
    EducationField,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS attrition_count,
    ROUND(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS attrition_rate_percentage
FROM hr_data
GROUP BY EducationField
ORDER BY attrition_rate_percentage DESC;

USE hr_analytics_db;
SELECT COUNT(*) FROM hr_data;




