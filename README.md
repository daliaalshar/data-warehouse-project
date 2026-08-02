# 🏛️ Tourism Data Warehouse & ETL Analysis

## Overview

This project develops a **Data Warehouse** for tourism data in Saudi Arabia by integrating multiple datasets related to tourism, climate, and visitor statistics. The project demonstrates the complete ETL (Extract, Transform, Load) process, schema matching, data cleaning, star schema design, and OLAP analysis to support data-driven decision making.

## Objectives

* Integrate tourism data from multiple sources.
* Clean and standardize the datasets.
* Design a Star Schema for analytical reporting.
* Build an ETL pipeline.
* Analyze tourism trends and generate business insights.

## Datasets

The project combines multiple structured datasets, including:

* Saudi Arabia Tourism & Climate Data (2018–2023)
* Arabia Tourism Saudi Dataset (2015–2024)
* Top Ten Inbound Source Markets

## Technologies Used

* Python
* Pandas
* SQL
* Excel
* Data Warehouse Concepts
* ETL Process

## Data Preparation

The preprocessing stage included:

* Date standardization
* Duplicate removal
* Missing value handling
* Data type conversion
* Country and location standardization
* Outlier treatment
* Schema matching and schema mapping

## Data Warehouse Design

### ETL Process

* **Extract:** Multiple tourism datasets
* **Transform:** Data filtering, cleaning, feature transformation, and season assignment
* **Load:** Star Schema tables

### Star Schema

The warehouse includes:

* **DIM_DATE**
* **DIM_LOCATION**
* **DIM_PURPOSE**
* **FACT_TOURISM**

## Business Analysis

The project answers several strategic questions, including:

* Which tourism purpose generates the highest spending?
* How does temperature affect tourist nights?
* Which regions attract the most visitors?
* What is the average spending per trip for domestic versus international tourists?

## Key Insights

* Leisure tourism generated the highest tourism revenue.
* Summer is the strongest tourism season.
* Albaha recorded the highest number of tourist nights.
* Domestic tourists spend more per trip than international tourists.

## Skills Demonstrated

* Data Warehousing
* ETL Pipeline
* Data Integration
* Data Cleaning
* Schema Matching
* Schema Mapping
* Star Schema Design
* OLAP Analysis
* Business Intelligence

