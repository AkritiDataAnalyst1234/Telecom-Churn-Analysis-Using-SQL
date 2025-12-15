# Telecom-Churn-Analysis-Using-SQL



## 📌 Project Overview
This project focuses on analyzing **customer churn behavior** in a telecom company using **SQL**.  
The objective is to clean the raw data, perform exploratory churn analysis, and identify key factors contributing to customer attrition.

The analysis helps answer questions such as:
- Who is churning more?
- Which customer segments are at higher risk?
- What services and payment methods are linked to higher churn?

---

## 🗂 Dataset Description
The dataset contains customer-level information with the following key attributes:
- Customer demographics (Gender, SeniorCitizen, Partner, Dependents)
- Service usage (InternetService, TechSupport, Streaming services, etc.)
- Contract & payment details
- Charges (MonthlyCharges, TotalCharges)
- Target variable: **Churn (Yes/No)**

---

## 🛠 Tools & Technologies
- **SQL (PostgreSQL)**
- Window Functions
- CTEs
- Aggregate Functions
- Data Cleaning & Transformation

---

## 🔄 Data Cleaning & Preparation

### 1️⃣ Handling Incorrect Data Types
- Identified `TotalCharges` stored as a **string**
- Checked for blank and null values
- Replaced missing values with `0`
- Converted column type from `VARCHAR` to `FLOAT`


2️⃣ Handling Missing & Invalid Records

-Checked for blank or null CustomerID
-Ensured data integrity before analysis

3️⃣ Duplicate Detection

Duplicates were checked using:

-GROUP BY + HAVING
-ROW_NUMBER() with CTE

4️⃣ Data Standardization

-Converted SeniorCitizen from integer to categorical values (Yes / No)

## 📊 Exploratory Data Analysis (EDA)
🔹 Overall Churn Distribution

-Calculated total churned vs retained customers
-Compared churn behavior across genders
-Identified churn patterns among senior vs non-senior customers

## Key Business Insights

-High churn during the initial tenure period

-Senior Citizens are more likely to churn

-Month-to-month contracts increase churn risk

-Electronic Check payment method correlates with high churn

-Fiber Optic service users churn more frequently
