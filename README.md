# 📉 Customer Churn Analysis — End-to-End Data Analytics Project

> Identifying key drivers of customer attrition for a subscription-based service using Excel, Python, MySQL, and Power BI / Tableau.

![Excel](https://img.shields.io/badge/Excel-217346?style=flat&logo=microsoft-excel&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat&logo=powerbi&logoColor=black)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat&logo=tableau&logoColor=white)

---

## 📑 Table of Contents

- [Project Overview](#-project-overview)
- [Data Source](#-data-source)
- [Tools Used](#️-tools-used)
- [Data Cleaning & Preparation](#-data-cleaning--preparation)
- [Exploratory Data Analysis](#-exploratory-data-analysis)
- [Data Analysis](#-data-analysis)
- [Results](#-results)
- [Recommendations](#-recommendations)
- [Limitations](#️-limitations)

---

## 📝 Project Overview

This end-to-end churn analysis project identifies the factors that drive customer churn using **Excel**, **Python**, **MySQL**, and BI tools (**Power BI & Tableau**). The goal is to help stakeholders understand:

- 🔍 Why customers are leaving
- 📊 Which segments churn the most
- 💡 What actions can reduce churn
- 💳 How behavior, spending, and contract terms influence churn

> **Pipeline:** `Data Cleaning` → `Feature Engineering` → `EDA` → `SQL Analytics` → `Dashboards` → `Insights`

---

## 📂 Data Source

The dataset contains real-world-like subscription, demographic, and behavioral data including:

| Field | Description |
|---|---|
| `customer_id` | Unique customer identifier |
| `age` / `gender` | Demographic attributes |
| `subscription_type` | Basic / Standard / Premium |
| `contract_length` | Monthly / Quarterly / Annual |
| `tenure` | Months since signup |
| `usage_frequency` | Product engagement metric |
| `payment_delay` | Days payment was delayed |
| `support_calls` | Number of support interactions |
| `total_spend` | Cumulative spend amount |
| `churn` | Target variable — 0 (retained) / 1 (churned) |

---

## 🛠️ Tools Used

| Task | Tool |
|---|---|
| Data Cleaning | Microsoft Excel |
| EDA & Feature Engineering | Python (Pandas, NumPy, Matplotlib, Seaborn) |
| Database Management | MySQL |
| SQL Analytics | MySQL Workbench |
| Dashboards | Power BI, Tableau |

---

## 🧹 Data Cleaning & Preparation

<details>
<summary><strong>Click to expand — Full Cleaning Steps</strong></summary>

<br>

**✔ Missing Value Handling**
- Numerical columns → imputed with **column median**
- Categorical columns → imputed as `"Unknown"`

**✔ Duplicate Removal**
- Duplicate `customer_id` records identified and removed

**✔ Outlier Treatment**
- IQR method applied to `total_spend` and `payment_delay`
- Extreme values capped at the **99th percentile** for visual clarity

**✔ Feature Engineering**

| Feature | Logic | Purpose |
|---|---|---|
| `tenure_bucket` | Short / Medium / Long | Lifecycle segmentation |
| `avg_monthly_spend` | `total_spend ÷ tenure` | Normalized spend metric |
| `delay_flag` | `payment_delay > 0` | Binary late-pay indicator |
| `high_value_customer` | spend > 90th percentile | Flag top-revenue at-risk customers |

**✔ Data Export**
- Cleaned data exported to MySQL for querying and BI reporting

</details>

---

## 🔍 Exploratory Data Analysis

<details>
<summary><strong>Click to expand — EDA Insights</strong></summary>

<br>

Visual analysis was conducted in Python using **Seaborn** and **Matplotlib**, covering:

- Churn distribution heatmaps across all categorical dimensions
- Customer churn by **Gender**, **Subscription Type**, and **Contract Length**
- **Total Spend vs. Payment Delay** scatter analysis segmented by churn
- Churn trend by **Tenure** — identifying early high-risk windows
- Distribution of **Support Calls** among churned vs. retained customers

</details>

---

## 📊 Data Analysis

### Python

```python
import pandas as pd

df = pd.read_csv("customer_churn.csv")

# Overall churn rate
churn_rate = df['churn'].mean() * 100
print("Churn Rate: {:.2f}%".format(churn_rate))

# Churn rate by subscription type
print(df.groupby('subscription_type')['churn'].mean() * 100)

# Feature engineering
df['avg_monthly_spend'] = df['total_spend'] / df['tenure']

threshold = df['total_spend'].quantile(0.90)
df['high_value_customer'] = (df['total_spend'] > threshold).astype(int)
```

### MySQL

```sql
CREATE VIEW churn_summary AS
SELECT
    subscription_type,
    contract_length,
    ROUND(SUM(churn) / COUNT(*) * 100, 2)  AS churn_rate_percent,
    ROUND(AVG(total_spend), 2)              AS avg_spend,
    ROUND(AVG(payment_delay), 2)            AS avg_delay
FROM churn
GROUP BY subscription_type, contract_length;
```

---

## 🧾 Results

| # | Finding |
|---|---|
| 🔹 | Overall churn rate: **47.37%** |
| 🔹 | Highest churn among **Monthly contract** customers |
| 🔹 | **Basic plan** users churn more than Premium subscribers |
| 🔹 | **Payment delays** strongly correlate with churn |
| 🔹 | Customers with **high support calls** show elevated dissatisfaction |
| 🔹 | **Low-tenure users (0–6 months)** churn early in the lifecycle |
| 🔹 | **Female customers** churn slightly more than male customers |
| 🔹 | **High spenders** also churn, directly impacting revenue |

---

## 📌 Recommendations

- ⭐ Offer discounts to upgrade **Monthly → Quarterly / Annual** plans
- ⭐ Improve the **onboarding journey** for new customers (0–6 months)
- ⭐ Build an **early-warning churn model** using payment delay and support call scores
- ⭐ Reduce payment friction via **automated reminders** before due dates
- ⭐ Analyze **high-support-call** customers to identify systemic service issues
- ⭐ Introduce **loyalty benefits** for long-tenure users
- ⭐ Launch **targeted retention campaigns** for high-value, high-risk segments

---

## ⚠️ Limitations

- Dataset does not include marketing logs or campaign exposure data
- No timestamps available — cohort-based churn analysis is not possible
- Payment delay may reflect billing cycle timing rather than true financial distress
- Self-reported churn reasons are absent — qualitative drivers are unknown
- No external factors modeled (competition, seasonality, pricing changes)

---

*Tools: Excel • Python • MySQL • Power BI • Tableau*
