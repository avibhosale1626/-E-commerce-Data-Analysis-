select * from zepto_v2;
-- count rows--
select count(*) from zepto_v2;

--sample data --
select * from zepto_v2
limit 10;
-- checking null--
select * from zepto_v2
where Category is null
or
name is null
or
mrp is null
or
discountPercent is null
or
availableQuantity is null
or
discountedSellingPrice is null
or
weightInGms is null
or
outOfStock is null
or
quantity is null;

-- --product categorys --
select distinct Category
from zepto_v2
order by Category;


ALTER TABLE zepto_v2
ADD COLUMN sku_id INT NOT NULL AUTO_INCREMENT PRIMARY KEY;

-- products whichs is in stocks
select outOfStock, count(*)
from zepto_v2
group by outOfStock;

-- products names present multiple times-- 
select name,count(sku_id) as "number of skus"
from zepto_v2
group by name
having count(sku_id)>1
order by count(sku_id)desc;

-- data cleaning

-- products with price 0 

select * from zepto_v2
where mrp= 0 or discountedSellingPrice= 0;

SET SQL_SAFE_UPDATES = 0;

delete from zepto_v2
where mrp= 0;

-- convert paise into rupees
update zepto_v2
set mrp=mrp/100.0,
discountedSellingPrice=discountedSellingPrice/100.0;

select mrp,discountedSellingPrice from zepto_v2
order by mrp,discountedSellingPrice;


-- Found top 10 best-value products based on discount percentage 

select distinct name, mrp,discountPercent
from zepto_v2
order by  discountPercent desc
limit 10;

-- Identified high-MRP products that are currently out of stock
select name, mrp,availableQuantity
from zepto_v2
where availableQuantity=0
order by mrp  desc
limit 5;

-- stimated potential revenue for each product category
SELECT Category,
       SUM(discountedSellingPrice * availableQuantity) AS total_revenue
FROM zepto_v2
GROUP BY Category
ORDER BY total_revenue;

-- Filtered expensive products (MRP > ₹500) with minimal discount

select distinct name , mrp ,discountPercent
from zepto_v2
where mrp>500 AND discountPercent<10
order by  mrp desc;

-- Ranked top 5 categories offering highest average discounts

select distinct Category, 
avg(discountPercent) as  average_discounts
from zepto_v2
group by Category 
order by  average_discounts desc
limit 5;

-- Calculated price per gram to identify value-for-money products
SELECT name,
       weightInGms,
       discountedSellingPrice,
       ROUND(discountedSellingPrice / weightInGms, 2) AS per_gms
FROM zepto_v2
WHERE weightInGms > 100
ORDER BY per_gms;


-- Grouped products based on weight into Low, Medium, and Bulk categories
SELECT DISTINCT Category,
       weightInGms,
       CASE 
           WHEN weightInGms < 100 THEN 'low'
           WHEN weightInGms < 5520 THEN 'medium'
           ELSE 'bulk'
       END AS weight
FROM zepto_v2;


-- Measured total inventory weight per product category
SELECT Category,
       SUM(weightInGms*availableQuantity)  as total_weight
FROM zepto_v2
GROUP BY Category
ORDER BY total_weight DESC;
