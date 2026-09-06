# 📉 Customer Churn Analysis — End-to-End Data Analytics Project

> Identifying key drivers of customer attrition for a subscription-based service using Excel, Python, MySQL, Power BI, and Tableau.

![Excel](https://img.shields.io/badge/Excel-217346?style=flat-square&logo=microsoftexcel&logoColor=white)
![Python](https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white)
![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power%20BI-F2C811?style=flat-square&logo=powerbi&logoColor=black)
![Tableau](https://img.shields.io/badge/Tableau-E97627?style=flat-square&logo=tableau&logoColor=white)

---

# Customer Churn Analysis

## 📌 Project Overview

This project analyzes customer churn to understand **why customers leave, which customer groups have higher observed churn rates, and where the business should focus retention efforts**.

The analysis follows a data analyst approach using **MySQL for data analysis and Power BI for visualization and reporting**.

The project focuses on descriptive and statistical analysis rather than machine learning or individual-level churn prediction.

---

## 🎯 Business Objective

The company wants to understand customer churn and identify customer groups with higher observed churn rates so that retention efforts can be better targeted.

### Key Business Questions

1. What is the overall churn rate?
2. Which customer characteristics are associated with churn?
3. Do payment delays relate to churn?
4. Do support calls relate to churn?
5. Does usage frequency differ between churned and retained customers?
6. Does contract length affect churn?
7. Are there meaningful differences by subscription type or gender?
8. What customer segments have the highest observed churn?
9. What actions can the business take based on these findings?

---

## 🗂️ Dataset

The dataset contains **64,374 customer records** and **12 variables**.

| Column            | Description                                |
| ----------------- | ------------------------------------------ |
| CustomerID        | Unique customer identifier                 |
| Age               | Customer age                               |
| Gender            | Customer gender                            |
| Tenure            | Customer tenure                            |
| Usage Frequency   | Customer usage frequency                   |
| Support Calls     | Number of support calls                    |
| Payment Delay     | Payment delay measure                      |
| Subscription Type | Basic, Standard, or Premium                |
| Total Spend       | Customer total spend                       |
| Last Interaction  | Last interaction measure                   |
| Contract Length   | Monthly, Quarterly, or Annual              |
| Churn             | Churn indicator: 0 = Retained, 1 = Churned |

### Data Quality

* Rows: **64,374**
* Columns: **12**
* Missing values: **0**
* Churn values: **0 and 1**
* Customer IDs: **64,374 unique customers**

---

## 🛠️ Tools Used

* **MySQL** — Data validation, cleaning checks, aggregation, segmentation, and analysis
* **Power BI** — Dashboard development, KPI reporting, and visualization
* **DAX** — Power BI measures for churn KPIs and analysis
* **Python** — Exploratory analysis and statistical validation

---

# 🔄 Analytical Approach

The project follows a structured data analytics workflow:

```text
Business Understanding
        ↓
Data Understanding
        ↓
Data Validation & Preparation
        ↓
Exploratory Data Analysis
        ↓
Churn Analysis
        ↓
Customer Segmentation
        ↓
Statistical Validation
        ↓
Power BI Dashboard
        ↓
Business Insights
        ↓
Recommendations
```

---

# 📊 Key Findings

## Overall Churn

The overall observed churn rate is:

**47.37%**

| Customer Status | Customers | Percentage |
| --------------- | --------: | ---------: |
| Churned         |    30,493 |     47.37% |
| Retained        |    33,881 |     52.63% |
| Total           |    64,374 |       100% |

---

## 💳 Payment Delay

Payment delay was one of the strongest observed relationships with churn.

| Customer Group | Average Payment Delay |
| -------------- | --------------------: |
| Retained       |                 12.45 |
| Churned        |                 22.33 |

Churned customers had an average payment delay approximately **9.88 units higher** than retained customers.

Payment delay groups also showed a strong increase in observed churn as delay increased.

---

## 📞 Support Calls

| Customer Group | Average Support Calls |
| -------------- | --------------------: |
| Retained       |                  4.50 |
| Churned        |                  6.40 |

Churned customers had approximately **1.90 more support calls on average**.

This suggests that customers with repeated support interactions should be investigated for unresolved service problems or customer dissatisfaction.

---

## 📱 Usage Frequency

| Customer Group | Average Usage Frequency |
| -------------- | ----------------------: |
| Retained       |                   16.04 |
| Churned        |                   14.01 |

Churned customers had lower average usage frequency by approximately **2.03 units**.

This indicates that low customer engagement is associated with higher observed churn.

---

## 📄 Contract Length

| Contract Length | Churn Rate |
| --------------- | ---------: |
| Monthly         |     51.61% |
| Annual          |     46.22% |
| Quarterly       |     44.05% |

Monthly-contract customers had the highest observed churn rate.

The difference between monthly and quarterly contracts was approximately **7.56 percentage points**.

---

## 👥 Gender

| Gender | Churn Rate |
| ------ | ---------: |
| Female |     55.05% |
| Male   |     38.58% |

A noticeable difference in observed churn rates exists between the two groups.

However, this is an **association, not evidence that gender causes churn**. Other customer characteristics may explain part of the difference.

---

## 📦 Subscription Type

| Subscription Type | Churn Rate |
| ----------------- | ---------: |
| Basic             |     48.28% |
| Standard          |     47.33% |
| Premium           |     46.50% |

The difference between subscription types is relatively small.

Therefore, subscription type appears to be a **weak standalone churn differentiator** in this dataset.

---

# 🔎 Customer Segmentation

To identify higher-risk observed customer groups, the analysis combines multiple variables.

### Key segmentation dimensions

* Payment Delay
* Support Calls
* Usage Frequency
* Contract Length

Examples of analyzed combinations include:

```text
Payment Delay × Support Calls
Payment Delay × Usage Frequency
Contract Length × Payment Delay
```

The analysis indicates that customers with **high payment delays, high support-call volume, and low usage frequency** form particularly high-churn observed segments.

These segments can help the business prioritize retention analysis.

---

# 📈 Power BI Dashboard

The Power BI report contains:

### Executive Overview

* Total Customers
* Churned Customers
* Retention Rate
* Overall Churn Rate
* Churn by Payment Delay
* Churn by Support Calls
* Churn by Usage Frequency
* Churn by Contract Length
* Churn by Gender
* Churn by Subscription Type

### Customer Risk Segmentation

* Payment Delay × Support Calls
* Payment Delay × Usage Frequency
* Contract Length × Payment Delay
* High observed churn segments

---

# 🧮 Key DAX Measures

### Total Customers

```DAX
Total Customers =
DISTINCTCOUNT(Customer_Churn[CustomerID])
```

### Churned Customers

```DAX
Churned Customers =
CALCULATE(
    DISTINCTCOUNT(Customer_Churn[CustomerID]),
    Customer_Churn[Churn] = 1
)
```

### Retained Customers

```DAX
Retained Customers =
CALCULATE(
    DISTINCTCOUNT(Customer_Churn[CustomerID]),
    Customer_Churn[Churn] = 0
)
```

### Churn Rate

```DAX
Churn Rate =
DIVIDE(
    [Churned Customers],
    [Total Customers],
    0
)
```

### Retention Rate

```DAX
Retention Rate =
DIVIDE(
    [Retained Customers],
    [Total Customers],
    0
)
```

---

# 🗄️ MySQL Analysis

The SQL analysis covers:

```text
Data validation
NULL checks
Duplicate checks
Churn distribution
Overall churn rate
Average metrics by churn status
Churn by gender
Churn by subscription type
Churn by contract length
Payment delay segmentation
Support call segmentation
Usage frequency segmentation
Payment Delay × Support Calls
Payment Delay × Usage Frequency
Contract Length × Payment Delay
```

Example:

```sql
SELECT
    `Contract Length`,
    COUNT(*) AS customers,
    SUM(Churn) AS churned_customers,
    ROUND(AVG(Churn) * 100, 2) AS churn_rate
FROM customer_churn
GROUP BY `Contract Length`
ORDER BY churn_rate DESC;
```

---

# 📐 Statistical Validation

Statistical analysis was used to validate whether observed differences between churned and retained customers were statistically meaningful.

### Numeric Variables

Independent two-sample comparisons were used for variables such as:

* Payment Delay
* Support Calls
* Usage Frequency
* Tenure
* Total Spend
* Age
* Last Interaction

Effect sizes were also considered to distinguish **statistical significance from practical importance**.

### Categorical Variables

Chi-square tests and Cramér's V were used to evaluate associations between churn and:

* Gender
* Contract Length
* Subscription Type

### Important Result

A variable can be statistically significant without being practically important.

For example, subscription type showed a statistically significant difference, but the practical effect was very small.

---

# 💡 Business Recommendations

### 1. Focus on payment-related issues

Customers with high payment delays show substantially higher observed churn.

Possible actions:

* Proactive payment reminders
* Billing issue resolution
* Easier payment processes
* Early intervention for repeated delays

### 2. Investigate repeated support interactions

Customers with high support-call volume should be reviewed for unresolved issues and service problems.

### 3. Re-engage low-usage customers

Customers with low usage frequency can be targeted with:

* Product education
* Engagement campaigns
* Feature recommendations
* Customer onboarding support

### 4. Review monthly-contract customers

Monthly customers have the highest observed churn rate.

The business should investigate why these customers are more likely to leave and evaluate appropriate retention strategies.

### 5. Prioritize customer segments

Retention efforts should focus on combinations of risk indicators rather than relying on a single variable.

---

# ⚠️ Limitations

* The analysis identifies **associations**, not causal relationships.
* Customer-level churn probability was not modeled.
* No machine learning model was used.
* The risk segments are exploratory and should not be treated as validated prediction rules.
* `CustomerID` is an identifier and should not be used as a predictive/business feature.
* The exact meaning/unit of `Last Interaction` is not established from the available dataset documentation.
* Statistical significance should be interpreted together with effect size and business relevance.

---

# 🚀 Conclusion

This project demonstrates an end-to-end **Data Analyst workflow for customer churn analysis**.

The analysis shows that **payment delay and support-call volume are the most practically important observed factors**, while lower usage frequency and monthly contracts also show higher observed churn.

The findings provide a basis for the business to focus retention efforts on customers showing combinations of payment, support, and engagement-related risk indicators.

The project intentionally focuses on **descriptive analytics, statistical validation, SQL, and Power BI**.
