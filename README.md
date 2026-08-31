# azure-healthcare-data-engineering
End-to-end Healthcare Data Engineering project using Azure Synapse Analytics, ADLS Gen2, PySpark, Delta Lake, Serverless SQL and Power BI.

##  Project Overview

This project demonstrates the implementation of an end-to-end Healthcare Data Engineering solution using Microsoft Azure.

The objective is to ingest raw healthcare data, evaluate data quality, clean and transform the data using PySpark, build an analytical data model, and make the resulting data available for reporting and business analysis in Power BI.

The solution follows the Medallion Architecture:

- **Bronze Layer:** Raw data ingestion and preservation
- **Silver Layer:** Data cleaning, standardization, validation, and data quality
- **Gold Layer:** Business-ready analytical model using Fact and Dimension tables

The complete workflow is orchestrated with an Azure Synapse Pipeline and automatically executed using a scheduled trigger.

## Business Objective

Healthcare organizations generate large volumes of operational data related to patients, hospital admissions, medical conditions, insurance providers, billing, and length of stay.

Raw data cannot always be used directly for business analysis because it may contain duplicates, missing values, inconsistent formats, or invalid business rules.

The goal of this project is therefore to build a reliable data pipeline that transforms raw healthcare data into trusted analytical information that can support questions such as:

- How many hospital admissions occurred?
- Which medical conditions generate the most admissions?
- What is the average length of stay?
- What is the total billing amount?
- How do admissions vary by hospital and insurance provider?

## Technologies Used

| Technology | Purpose |
|---|---|
| Azure Data Lake Storage Gen2 | Data storage |
| Azure Synapse Analytics | Data engineering and orchestration |
| Synapse Pipelines | Data ingestion and pipeline automation |
| Apache Spark / PySpark | Data profiling, cleaning and transformation |
| Delta Lake | Reliable storage for transformed data |
| Synapse Serverless SQL | SQL access to analytical data |
| Power BI | Data modeling, KPIs and visualization |
| GitHub | Source control and project documentation |

##  Solution Architecture

The project follows a Medallion Architecture to progressively transform raw healthcare data into reliable, business-ready analytical data.
<img width="1076" height="506" alt="architecture final" src="https://github.com/user-attachments/assets/ceb0be29-4817-471f-8036-3baf6e4e694b" />
##  Data Quality Results

Data quality checks were performed before the data was made available for analytical consumption.

| Data Quality Check | Result / Action |
|---|---|
| Initial number of records | 55,173 |
| Duplicate records | 67 duplicates detected |
| Records after deduplication | 55,106 |
| Missing values | Analyzed and handled during Silver processing |
| Column names | Standardized |
| Date consistency | Validated |
| Output format | Delta |

The data quality process ensures that the Gold layer is built from cleaned and validated data rather than directly from the raw source.




