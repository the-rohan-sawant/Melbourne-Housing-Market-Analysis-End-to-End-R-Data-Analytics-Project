# Melbourne Housing Market Analysis — R Project

## 🏠 Project Overview
This project provides an **end-to-end data analysis** of the Melbourne housing market using R. It demonstrates key data analytics skills including **data loading, cleaning, transformation, aggregation, and visualization**.  

The analysis is based on the **Melbourne Housing dataset** and includes insights into property prices, trends, and distributions across suburbs and property types.

---

## 📂 Dataset
- **Source:** Provided CSV file in the project directory
- **File:** `melb_data.csv`
- **Description:** The dataset contains details of properties sold in Melbourne, including attributes like:
  - Suburb
  - Address
  - Rooms
  - Price
  - Bathroom
  - Car spaces
  - Type (House, Unit, Townhouse)
  - Date of sale
  - Distance from city center
  - Land size and building area
  - Year built

---

## 🛠 Project Workflow

### 1. Data Loading & Exporting
- Load the dataset using `read.csv()`.
- Preview the dataset structure and summary using `head()`, `str()`, and `summary()`.
- Save a cleaned or processed copy using `write.csv()`.

### 2. Selecting, Ordering & Filtering
- Select relevant columns for analysis.
- Order dataset by Price in descending order.
- Filter properties with Price greater than 1,000,000.

### 3. Grouping & Aggregation
- Calculate **average price per Suburb**.
- Calculate **total properties per Type**.
- Calculate **median number of Rooms per Suburb**.

### 4. Data Cleaning
- Replace missing numeric values (Bedroom2, Bathroom, Distance) with medians.
- Trim whitespaces and standardize text columns to lowercase (Suburb, Type).
- Replace zero or unrealistic Price values with median.
- Fill missing categorical values for Car, BuildingArea, and YearBuilt.

### 5. Date Conversion & Feature Extraction
- Convert the `Date` column from character to Date type.
- Extract Year, Month, Day.
- Calculate **days since sale**.
- Filter for properties sold in a specific year (e.g., 2017).

### 6. Removing Duplicates
- Remove full duplicate rows.
- Remove duplicates based on Address while keeping other columns intact.
- Arrange dataset by Suburb ascending and Price descending.

### 7. Data Visualization
- **Boxplot:** Price distribution by Property Type.
- **Scatter Plot:** Rooms vs Price by Property Type.
- **Histogram:** Price distribution.
- **Bar Chart:** Average Price by Number of Rooms.
- **Line Chart:** Average Price trend over Years.

---

## 📊 Tools & Libraries
- **R** — Programming language for statistical computing
- **Libraries:**
  - `dplyr` — Data manipulation
  - `tidyr` — Data cleaning
  - `lubridate` — Date parsing and feature extraction
  - `ggplot2` — Data visualization
  - `scales` — Formatting numbers in plots

---

## 🔍 Key Insights
- Distribution of property prices across different property types.
- Relationship between the number of rooms and property price.
- Trend of average property prices over the years.
- Insights into suburbs with highest average prices and room counts.

---
