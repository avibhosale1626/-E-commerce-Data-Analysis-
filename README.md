# -E-commerce-Data-Analysis-
SQL‑based analysis of Zepto e‑commerce dataset. Includes queries for revenue, discounts, inventory weight, and per‑unit pricing. Demonstrates GROUP BY, HAVING, CASE, ROUND, subqueries, and cross‑database alias rules for practical business insights.

🛒 E-commerce Data Analysis (Zepto Dataset)

SQL-based data analysis project on the Zepto E-commerce dataset.
This project focuses on extracting meaningful business insights using structured SQL queries.

It demonstrates practical use of:

GROUP BY

HAVING

CASE

ROUND

Subqueries

Cross-database alias rules

Aggregate functions (SUM, AVG, COUNT)

Filtering and sorting techniques

📌 Project Objective

To analyze e-commerce transaction and inventory data to:

Calculate total revenue

Evaluate discount impact

Analyze inventory weight

Compute per-unit pricing

Generate category-wise insights

Identify high-value and low-value products

🗂 Dataset Overview

The dataset contains product-level details such as:

Product Name

Category

MRP (Maximum Retail Price)

Discounted Price

Discount Percentage

Weight (grams/kg)

Quantity Sold

Stock Availability

📊 Key SQL Analysis Performed
1️⃣ Revenue Analysis

Total revenue calculation

Revenue per category

Revenue after discount impact

Top-performing products by revenue

SELECT category,
       ROUND(SUM(discounted_price * quantity_sold), 2) AS total_revenue
FROM zepto_v2
GROUP BY category
ORDER BY total_revenue DESC;
2️⃣ Discount Analysis

Average discount percentage

Products with highest discount

Revenue loss due to discount

SELECT 
    ROUND(AVG(discount_percent), 2) AS avg_discount
FROM zepto_v2;
3️⃣ Inventory & Weight Analysis

Total inventory weight

Heavy vs light product classification using CASE

SELECT 
    product_name,
    CASE 
        WHEN weight > 1000 THEN 'Heavy Product'
        ELSE 'Light Product'
    END AS weight_category
FROM zepto_v2;
4️⃣ Per-Unit Pricing Analysis

Price per gram / kg calculation

Identifying expensive products per unit

SELECT 
    product_name,
    ROUND(discounted_price / weight, 4) AS price_per_gram
FROM zepto_v2;
5️⃣ HAVING Clause Usage

Filtering grouped results:

SELECT category,
       SUM(quantity_sold) AS total_units
FROM zepto_v2
GROUP BY category
HAVING SUM(quantity_sold) > 100;
6️⃣ Subqueries Example
SELECT *
FROM zepto_v2
WHERE discounted_price > (
    SELECT AVG(discounted_price) FROM zepto_v2
);
💡 Business Insights Generated

Identified top revenue-generating categories

Measured discount impact on profitability

Compared per-unit product pricing

Detected high-inventory-weight products

Filtered high-demand product categories
