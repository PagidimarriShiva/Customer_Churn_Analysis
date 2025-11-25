# Customer Churn Analysis — End-to-End Data Analytics Project
This project aims to analyze customer churn for a subscription-based service and identify key factors influencing customer attrition. The workflow includes data collection, cleaning, feature engineering, SQL-based aggregation, exploratory analysis in Python, and interactive dashboards in Power BI/Tableau. The goal is to help business teams understand churn drivers and build actionable retention strategies.
## 📑 Table of Contents

- Project Overview

- Data Source

- Tools Used

- Data Cleaning & Preparation

- Exploratory Data Analysis

- Data Analysis

- Results

- Recommendations

- Limitations

## 📝 Project Overview

This end-to-end churn analysis project identifies the factors that drive customer churn using Excel, Python, MySQL, and BI tools (Power BI & Tableau).
The goal is to help stakeholders understand:

- Why customers are leaving

- Which segments churn the most

- What actions can reduce churn

- How behavior, spending, and contract terms influence churn

-- This project showcases data cleaning → EDA → SQL analytics → Insights → Dashboards.

## 📂 Data Source

### The dataset contains real-world-like subscription, demographic and behavioral data, including:

- Customer ID

- Age & Gender

- Subscription Type

- Contract Length

- Tenure

- Usage Frequency

- Payment Delay

- Support Calls

- Total Spend

- Churn (0/1)

## 🛠 Tools Used
### Task	Tool
- Data Cleaning	Excel
- EDA & Feature Engineering	Python (Pandas, NumPy, Matplotlib, Seaborn)
- Database Management	MySQL
- SQL Analytics	MySQL Workbench
- Dashboards	Power BI, Tableau

## 🧹 Data Cleaning & Preparation
<details> <summary>📌 Click to Expand — View Full Cleaning Steps</summary>
✔ Missing value handling

Numerical missing values → imputed with median

Categorical missing values → imputed as "Unknown"

✔ Duplicate removal

Duplicate Customer IDs identified and removed

✔ Outlier treatment

IQR used for extremes in:

total_spend

payment_delay

Outliers capped at 99th percentile for visual clarity

✔ Feature Engineering

Tenure buckets: Short, Medium, Long

Avg_monthly_spend = total_spend ÷ tenure

Delay_flag: (delay > 0)

High_value_customer: 90th percentile spend above threshold

✔ Data Export

Cleaned data exported into MySQL for querying and BI reporting

</details>
🔍 Exploratory Data Analysis
<details> <summary>📈 Click to Expand — EDA Insights</summary>

Churn distribution heatmaps

Customer churn by:

Gender

Subscription Type

Contract Length

Total Spend vs Payment Delay

Churn trend by Tenure

Distribution of Support Calls

Visual tools: Python, Seaborn, Matplotlib.

</details>
📊 Data Analysis
Python Code Example
import pandas as pd

df = pd.read_csv("customer_churn.csv")

# Overall churn rate
churn_rate = df['churn'].mean() * 100
print("Churn Rate: {:.2f}%".format(churn_rate))

# Churn by subscription type
print(df.groupby('subscription_type')['churn'].mean() * 100)

MySQL Query Example
CREATE VIEW churn_summary AS
SELECT 
    subscription_type,
    contract_length,
    ROUND(SUM(churn)/COUNT(*) * 100, 2) AS churn_rate_percent,
    ROUND(AVG(total_spend), 2) AS avg_spend,
    ROUND(AVG(payment_delay), 2) AS avg_delay
FROM churn
GROUP BY subscription_type, contract_length;

## 🧾 Results

🔹 Overall churn rate: 47.37%

🔹 Highest churn: Monthly contract customers

🔹 Basic plan users churn more than Premium

🔹 Payment delays strongly correlate with churn

🔹 High support callers show high dissatisfaction

🔹 Low tenure users (0–6 months) churn early

🔹 Female customers churn slightly more than males

🔹 High spenders also churn, impacting revenue

## 📌 Recommendations

⭐ Offer discounts to upgrade Monthly → Quarterly/Annual plans

⭐ Improve onboarding journey for new customers

⭐ Build early-warning churn models using behavior scores

⭐ Reduce payment friction by sending reminders

⭐ Improve support quality by analyzing high-call customers

⭐ Introduce loyalty benefits for long-tenure users

⭐ Target high-value, high-risk customers with retention campaigns

## ⚠️ Limitations

Dataset does not include marketing or activity logs

No timestamps → cannot build cohort churn

Payment delay may depend on billing cycle not visible to us

Self-reported churn reason missing

No external factors (competition, seasonality)
