-- 1. CLEAN SLATE
DROP DATABASE IF EXISTS retail_analysis;
CREATE DATABASE retail_analysis;
USE retail_analysis;

-- 2. CREATE TABLE
CREATE TABLE walmart_sales (
    store_id INT,
    dept_id INT,
    date DATE,
    weekly_sales DECIMAL(12,2),
    is_holiday BOOLEAN
);

-- 3. INSERT PROPER DATA (13 rows this time)
INSERT INTO walmart_sales VALUES
(1, 1, '2023-01-06', 57284.00, 0),
(1, 1, '2023-01-13', 51382.00, 0),
(1, 1, '2023-02-03', 48021.00, 0),
(1, 1, '2023-02-10', 49283.00, 0),
(1, 1, '2023-11-24', 104821.00, 1),
(1, 2, '2023-01-06', 42817.00, 0),
(1, 2, '2023-01-13', 40192.00, 0),
(1, 2, '2023-02-03', 39201.00, 0),
(1, 2, '2023-11-24', 89217.00, 1),
(2, 1, '2023-01-06', 62109.00, 0),
(2, 1, '2023-01-13', 58721.00, 0),
(2, 1, '2023-02-03', 54218.00, 0),
(2, 1, '2023-11-24', 112843.00, 1);

-- 4. VERIFY (Should show 13 rows)
SELECT COUNT(*) AS total_rows FROM walmart_sales;


-- =============================================
-- REAL BUSINESS INSIGHTS ANALYSIS
-- =============================================

-- 1. OVERALL BUSINESS HEALTH
SELECT 
    COUNT(*) AS total_weeks_analyzed,
    ROUND(SUM(weekly_sales), 2) AS total_revenue,
    ROUND(AVG(weekly_sales), 2) AS average_weekly_sales,
    ROUND(MAX(weekly_sales), 2) AS best_week_sales,
    ROUND(MIN(weekly_sales), 2) AS worst_week_sales
FROM walmart_sales;

-- 2. STORE PERFORMANCE COMPARISON
SELECT 
    store_id,
    COUNT(*) AS weeks_recorded,
    ROUND(SUM(weekly_sales), 2) AS total_revenue,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales 
GROUP BY store_id
ORDER BY total_revenue DESC;

-- 3. HOLIDAY VS REGULAR WEEK PERFORMANCE
SELECT 
    CASE 
        WHEN is_holiday = 1 THEN 'Holiday Week'
        ELSE 'Regular Week'
    END AS week_type,
    COUNT(*) AS number_of_weeks,
    ROUND(AVG(weekly_sales), 2) AS average_sales,
    ROUND(MAX(weekly_sales), 2) AS peak_sales
FROM walmart_sales 
GROUP BY is_holiday;

-- 4. DEPARTMENT PERFORMANCE ANALYSIS
SELECT 
    dept_id,
    COUNT(*) AS weeks_tracked,
    ROUND(SUM(weekly_sales), 2) AS dept_revenue,
    ROUND(SUM(weekly_sales) / (SELECT SUM(weekly_sales) FROM walmart_sales) * 100, 2) AS revenue_percentage
FROM walmart_sales 
GROUP BY dept_id
ORDER BY dept_revenue DESC;

-- 5. MONTHLY SALES TRENDS
SELECT 
    YEAR(date) AS year,
    MONTH(date) AS month,
    ROUND(SUM(weekly_sales), 2) AS monthly_sales
FROM walmart_sales 
GROUP BY year, month
ORDER BY year, month;

SELECT date, weekly_sales 
FROM walmart_sales 
ORDER BY date;

SELECT 
    YEAR(date) AS year,
    MONTH(date) AS month, 
    SUM(weekly_sales) AS monthly_sales
FROM walmart_sales 
GROUP BY year, month;

# Query 1 = TOTAL BUSINESS HEALTH
SELECT 
    ROUND(SUM(weekly_sales), 2) AS total_revenue,
    ROUND(AVG(weekly_sales), 2) AS avg_weekly_sales
FROM walmart_sales;

# QUERY 2: HOLIDAY IMPACT
SELECT 
    CASE 
        WHEN is_holiday = 1 THEN 'Holiday Week'
        ELSE 'Regular Week'
    END AS week_type,
    ROUND(AVG(weekly_sales), 2) AS avg_sales,
    ROUND(MAX(weekly_sales), 2) AS peak_sales
FROM walmart_sales 
GROUP BY is_holiday;
-- Regular Weeks: $50,322 average sales
-- Holiday Weeks: $102,293 average sales (+103%)
-- Holiday weeks deliver more than double the revenue of regular weeks, indicating that seasonal optimization should be a primary focus for resource allocation.
-- Recommended Action : Increase holiday inventory by 80-100%, Develop holiday-specific marketing campaigns, Optimize staffing schedules for holiday peaks.alter

# QUERY 3: DEPARTMENT PERFORMANCE
SELECT 
    dept_id,
    ROUND(SUM(weekly_sales), 2) AS dept_revenue
FROM walmart_sales 
GROUP BY dept_id
ORDER BY dept_revenue DESC;
-- Department dominance analysis reveals a 74/26 revenue split, indicating both a strength in Department 1's performance and a strategic need for portfolio diversification to mitigate concentration risk."

# Walmart Sales Analysis - Business Insights Report

## Executive Summary
-- Analysis of 13 weeks of sales data ($810K total revenue) revealed critical business patterns requiring strategic attention.

## Key Findings

### 1. Holiday Sales Optimization Opportunity
-- **Regular Weeks:** $50,322 average sales
-- **Holiday Weeks:** $102,293 average sales (+103%)
-- **Insight:** Holiday weeks deliver more than double the revenue, indicating massive seasonal opportunity

### 2. Revenue Concentration Risk
-- **Primary Department:** $598,682 (74% of total revenue)
-- **Secondary Department:** $211,427 (26% of total revenue)  
-- **Insight:** Over-reliance on one department creates business vulnerability

### 3. Monthly Sales Trends
-- **January:** $312,505 (Strong start to year)
-- **February:** $190,723 (Seasonal dip)
-- **November:** $306,881 (Holiday surge)
-- **Insight:** Clear seasonal patterns inform inventory planning

## Strategic Recommendations
-- 1. **Maximize holiday performance** through targeted marketing and inventory
-- 2. **Diversify revenue streams** by boosting secondary department performance
-- 3. **Plan resources** around identified seasonal patterns