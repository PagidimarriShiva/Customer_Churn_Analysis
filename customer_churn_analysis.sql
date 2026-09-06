CREATE DATABASE customer_churn_analysis;
USE customer_churn_analysis;
show tables;
-- Create the Table 
CREATE TABLE customer_churn (
    CustomerID INT,
    Age INT,
    Gender VARCHAR(20),
    Tenure INT,
    `Usage_Frequency` INT,
    `Support_Calls` INT,
    `Payment_Delay` INT,
    `Subscription_Type` VARCHAR(20),
    `Total_Spend` DECIMAL(10,2),
    `Last_Interaction` INT,
    `Contract_Length` VARCHAR(20),
    Churn TINYINT
);
-- Import the Data 
LOAD DATA LOCAL INFILE 'C:\Users\ppagi\OneDrive\Documents\Power BI projects\churnproject\customer_churn_dataset.csv'
INTO TABLE customer_churn
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- First Check
SELECT COUNT(*) AS total_rows
FROM customer_churn;

--  Check top 10
SELECT *
FROM customer_churn
LIMIT 10;

-- Check all columns for NULL values
SELECT
    SUM(CustomerID IS NULL) AS CustomerID_NULLS,
    SUM(Age IS NULL) AS Age_NULLS,
    SUM(Gender IS NULL) AS Gender_NULLS,
    SUM(Tenure IS NULL) AS Tenure_NULLS,
    SUM(`Usage Frequency` IS NULL) AS Usage_Frequency_NULLS,
    SUM(`Support Calls` IS NULL) AS Support_Calls_NULLS,
    SUM(`Payment Delay` IS NULL) AS Payment_Delay_NULLS,
    SUM(`Subscription Type` IS NULL) AS Subscription_Type_NULLS,
    SUM(`Total Spend` IS NULL) AS Total_Spend_NULLS,
    SUM(`Last Interaction` IS NULL) AS Last_Interaction_NULLS,
    SUM(`Contract Length` IS NULL) AS Contract_Length_NULLS,
    SUM(Churn IS NULL) AS Churn_NULLS
FROM customer_churn;

-- Check duplicate customers
SELECT
    CustomerID,
    COUNT(*) AS customer_count
FROM customer_churn
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- Check Churn values
SELECT
    Churn,
    COUNT(*) AS customers
FROM customer_churn
GROUP BY Churn
ORDER BY Churn;

-- Overall Churn Rate 

SELECT
    COUNT(*) AS total_customers,
    SUM(Churn) AS churned_customers,
    SUM(CASE WHEN Churn = 0 THEN 1 ELSE 0 END) AS retained_customers,
    ROUND(SUM(Churn) * 100.0 / COUNT(*), 2) AS churn_rate,
    ROUND(
        SUM(CASE WHEN Churn = 0 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS retention_rate
FROM customer_churn;

-- Payment Delay vs Churn
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(`Payment Delay`), 2) AS avg_payment_delay
FROM customer_churn
GROUP BY Churn;

-- Support Calls vs Churn
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(`Support_Calls`), 2) AS avg_support_calls
FROM customer_churn
GROUP BY Churn;

-- Usage Frequency vs Churn
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(`Usage_Frequency`), 2) AS avg_usage_frequency
FROM customer_churn
GROUP BY Churn;

-- Contract Length vs Churn
SELECT
    `Contract_Length`,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY `Contract Length`
ORDER BY churn_rate DESC;

-- Subscription Type vs Churn
SELECT
    `Subscription_Type`,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY `Subscription Type`
ORDER BY churn_rate DESC;

-- Gender vs Churn
SELECT
    Gender,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY Gender
ORDER BY churn_rate DESC;

-- Total Spend vs Churn
SELECT
    Churn,
    COUNT(*) AS customers,
    ROUND(AVG(`Total Spend`), 2) AS avg_total_spend
FROM customer_churn
GROUP BY Churn;

-- Payment Delay Segmentation
SELECT
    CASE
        WHEN `Payment_Delay` <= 10 THEN 'Low (0-10)'
        WHEN `Payment_Delay` <= 19 THEN 'Medium (11-19)'
        WHEN `Payment_Delay` <= 25 THEN 'High (20-25)'
        ELSE 'Very High (26-30)'
    END AS payment_delay_group,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY payment_delay_group
ORDER BY churn_rate DESC;

-- Support Calls Segmentation
SELECT
    CASE
        WHEN `Support_Calls` <= 3 THEN 'Low (0-3)'
        WHEN `Support_Calls` <= 6 THEN 'Medium (4-6)'
        WHEN `Support_Calls` <= 8 THEN 'High (7-8)'
        ELSE 'Very High (9-10)'
    END AS support_calls_group,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY support_calls_group
ORDER BY churn_rate DESC;

-- Usage Frequency Segmentation
SELECT
    CASE
        WHEN `Usage_Frequency` <= 7 THEN 'Low (1-7)'
        WHEN `Usage_Frequency` <= 15 THEN 'Medium (8-15)'
        WHEN `Usage_Frequency` <= 23 THEN 'High (16-23)'
        ELSE 'Very High (24-30)'
    END AS usage_frequency_group,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY usage_frequency_group
ORDER BY churn_rate DESC;

-- Payment Delay × Support Calls

This is one of the most important queries for your project.

SELECT
    CASE
        WHEN `Payment_Delay` <= 10 THEN 'Low'
        WHEN `Payment_Delay` <= 19 THEN 'Medium'
        WHEN `Payment_Delay` <= 25 THEN 'High'
        ELSE 'Very High'
    END AS payment_delay_group,

    CASE
        WHEN `Support_Calls` <= 3 THEN 'Low'
        WHEN `Support_Calls` <= 6 THEN 'Medium'
        WHEN `Support_Calls` <= 8 THEN 'High'
        ELSE 'Very High'
    END AS support_calls_group,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY
    payment_delay_group,
    support_calls_group
ORDER BY churn_rate DESC;

-- Payment Delay × Usage Frequency
SELECT
    CASE
        WHEN `Payment_Delay` <= 10 THEN 'Low'
        WHEN `Payment_Delay` <= 19 THEN 'Medium'
        WHEN `Payment Delay` <= 25 THEN 'High'
        ELSE 'Very High'
    END AS payment_delay_group,

    CASE
        WHEN `Usage_Frequency` <= 7 THEN 'Low'
        WHEN `Usage_Frequency` <= 15 THEN 'Medium'
        WHEN `Usage_Frequency` <= 23 THEN 'High'
        ELSE 'Very High'
    END AS usage_frequency_group,

    COUNT(*) AS customers,

    SUM(Churn) AS churned_customers,

    ROUND(AVG(Churn) * 100, 2) AS churn_rate

FROM customer_churn

GROUP BY
    payment_delay_group,
    usage_frequency_group

ORDER BY churn_rate DESC;
-- Monthly Contract × Payment Delay

SELECT
    Contract_Length,
    CASE
        WHEN `Payment_Delay` <= 10 THEN 'Low'
        WHEN `Payment_Delay` <= 19 THEN 'Medium'
        WHEN `Payment_Delay` <= 25 THEN 'High'
        ELSE 'Very High'
    END AS payment_delay_group,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY
    `Contract Length`,
    payment_delay_group
ORDER BY churn_rate DESC;
