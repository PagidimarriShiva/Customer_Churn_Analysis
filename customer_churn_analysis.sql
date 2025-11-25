create database churn;
use churn;
show tables;
select * from churn;
alter table df rename to churn ;
-- Count total customers and churn rate ?
select count(*) as total_customers,
 sum(churn) as churned_customers,
 round(sum(churn)/count(*) * 100,2) as churn_rate_percent
 from churn;
-- Churn by Subscription Type ?
select subscription_type,
count(*) as total_customers,
sum(churn) as churned,
round(sum(churn)/count(*)*100,2)as churn_rate
from churn
group by subscription_type
order by churn_rate desc;

-- churn by contract length
select contract_length,
count(*) as total_customers,
sum(churn) as churned,
round(sum(churn)/count(*)*100,2)as churn_rate
from churn
group by contract_length
order by churn_rate desc;

-- churn by gender
select gender,
count(*) as total_customers,
sum(churn) as churned,
round(sum(churn)/count(*)*100,2)as churn_rate
from churn
group by gender;

-- average metrics by churn status
select
   churn,
round(avg(tenure),2) as avg_tenure,
round(avg(usage_frequency),2) as avg_usage,
round(avg(support_calls),2) as avg_support_calls,
round(avg(payment_delay),2) as avg_payment_delay,
round(avg(total_spend),2) as avg_spend
from churn
group by churn;

-- top 10 high_value churned customers ?
SELECT 
    customerid,
    total_spend,
    subscription_type,
    contract_length,
    payment_delay
FROM churn
WHERE churn = 1
ORDER BY total_spend DESC
LIMIT 10;

-- contract vs churn rate ?
select contract_length,
round(avg(tenure),2) as avg_tenure,
round(avg(payment_delay),2) as avg_payment_delay,
round(avg(churn)*100,2) as churn_rate
from churn
group by contract_length
order by churn_rate desc;

-- create a summary view for dashboard 
CREATE OR REPLACE VIEW churn_summary AS
SELECT 
    subscription_type,
    contract_length,
    ROUND(SUM(churn) / COUNT(*) * 100, 2) AS churn_rate_percent,
    ROUND(AVG(total_spend), 2) AS avg_spend,
    ROUND(AVG(payment_delay), 2) AS avg_delay
FROM churn
GROUP BY subscription_type, contract_length;
