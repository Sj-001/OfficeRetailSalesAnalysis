# Offline Retail Sales – DWBI Project

## 📌 Project Overview

This project demonstrates the design and implementation of a **Data Warehouse & Business Intelligence (DWBI) pipeline** for analyzing **Offline Retail Sales data**. The pipeline simulates a retail environment where sales data is generated, modeled, stored in a cloud data warehouse, transformed using SQL, and visualized for business insights.

The goal of the project is to showcase **end-to-end data engineering and analytics workflow**, including data modeling, data ingestion, transformation, and visualization.

---

## 🏗️ Architecture Overview

Data Generation (Python)
⬇
Data Modeling (Excel – ER Diagram)
⬇
Data Warehouse (Snowflake)
⬇
Data Transformation (SnowSQL & SQL Worksheets)
⬇
Business Intelligence (Tableau)

---

## 🛠️ Tech Stack

| Tool / Technology  | Purpose                                            |
| ------------------ | -------------------------------------------------- |
| **Excel**          | Data modeling and Entity Relationship (ER) diagram |
| **Python**         | Synthetic retail data generation                   |
| **Snowflake**      | Cloud data warehouse                               |
| **SnowSQL**        | Data loading to Snowflake stage                    |
| **Snowsight**      | Database object creation and data ingestion        |
| **SQL Worksheets** | Data transformation, analytics queries             |
| **Tableau**        | Data visualization and business dashboards         |

---

## 📊 Data Model

The retail data warehouse follows a **star schema design** to support analytical queries.

### Fact Table

* **Fact_Sales**

  * Sales_ID
  * Product_ID
  * Store_ID
  * Customer_ID
  * Date_ID
  * Quantity
  * Sales_Amount
  * Discount
  * Profit

### Dimension Tables

* **Dim_Product**
* **Dim_Customer**
* **Dim_Store**
* **Dim_Date**

The schema enables efficient aggregation and reporting across multiple business dimensions.

---

## ⚙️ Project Workflow

### 1️⃣ Data Modeling (Excel)

* Designed **ER Diagram**
* Defined **Fact and Dimension tables**
* Created relationships for the star schema

---

### 2️⃣ Data Generation (Python)

Python scripts were used to generate realistic synthetic retail datasets including:

* Products
* Customers
* Stores
* Sales transactions
* Dates

Generated datasets were exported as **CSV files** for ingestion.

---

### 3️⃣ Data Loading (Snowflake)

#### Stage Creation

Data files were uploaded to **Snowflake internal stages** using **SnowSQL**.

#### Data Ingestion

Data was loaded into staging tables using:

* `COPY INTO`
* File formats
* Snowflake stages

---

### 4️⃣ Data Transformation (SQL)

SQL transformations were performed using **Snowflake SQL Worksheets**, including:

#### DDL

* Database creation
* Schema creation
* Table definitions

#### DML

* Data cleaning
* Data transformation
* Fact table population

#### Analytical Queries

Used advanced SQL techniques such as:

* **CTEs (Common Table Expressions)**
* **JOINs**
* **Window Functions**
* **Aggregations**

Example:

```sql
WITH sales_summary AS (
    SELECT
        store_id,
        SUM(sales_amount) AS total_sales
    FROM fact_sales
    GROUP BY store_id
)
SELECT *
FROM sales_summary
ORDER BY total_sales DESC;
```

---

## 📈 Data Visualization (Tableau)

The transformed warehouse data was connected to **Tableau** to build interactive dashboards.

### Dashboard Insights

Examples of insights derived:

* Total sales by store
* Monthly revenue trends
* Top selling products
* Customer purchasing patterns
* Profit distribution

---

## 📁 Project Structure

```
offline-retail-dwbi/
│
├── data/
│   ├── generated_data/
│   └── csv_files/
│
├── python/
│   └── data_generation_scripts.py
│
├── snowflake/
│   ├── ddl_scripts.sql
│   ├── data_load.sql
│   └── transformations.sql
│
├── tableau/
│   └── retail_sales_dashboard.twb
│
└── README.md
```

---

## 🚀 Key Learnings

* Designing **star schema data models**
* Implementing **data pipelines in Snowflake**
* Writing advanced **SQL transformations**
* Using **staging and ingestion techniques**
* Creating **interactive BI dashboards**

---

## 📌 Future Improvements

* Implement **incremental data loading**
* Add **data quality checks**
* Automate pipeline using **Airflow / orchestration**
* Add **real-time ingestion**

---

## 👤 Author

**Shruti Jain**

DWBI / Data Engineering Project – Offline Retail Sales
