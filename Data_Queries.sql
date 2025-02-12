-- I was able to do these queries mostly independently, but I did need some assistnace with a few things, such DATE_TRUNC 
-- and setting up the CASE for the age groups.

-- 1. Purchased products (purchase count and quantity purchased) per month
SELECT DATE_TRUNC('month', PurchaseDate) AS purchase_month, 
COUNT(*) AS purchase_count, 
SUM(Quantity) AS quantity_purchased
FROM CustomerPurchaseHistory cp
GROUP BY purchase_month
ORDER BY purchase_month;

-- 2. Average age of customer per product sold
SELECT p.ProductName AS Product_Name, ROUND(AVG(cd.age)) AS Average_age 
FROM customerdemographics cd 
JOIN customerpurchasehistory cp ON cd.customerid = cp.customer
JOIN product p ON cp.ProductID = p.ProductID
GROUP BY p.ProductName;
-- ORDER BY Average_age DESC; if you wanted to order it by age

-- 3. Which products are purchased most by age group (18-28, 29-38, etc.)
SELECT DISTINCT ON (Age_Group)  
    CASE 
        WHEN cd.Age BETWEEN 18 AND 28 THEN '18-28'
        WHEN cd.Age BETWEEN 29 AND 38 THEN '29-38'
        WHEN cd.Age BETWEEN 39 AND 48 THEN '39-48'
        WHEN cd.Age BETWEEN 49 AND 58 THEN '49-58'
    ELSE '59+'
END AS Age_group,
p.productname,
COUNT(*) AS Total_Purchases
FROM customerdemographics cd 
JOIN customerpurchasehistory cp ON cd.customerid = cp.customer
JOIN product p ON cp.ProductID = p.ProductID
GROUP BY Age_group, p.productname
ORDER BY Age_group, Total_Purchases DESC;

-- 4. Repeat customers
SELECT cd.CustomerID, cd.firstname, cd.lastname
FROM customerdemographics cd
JOIN customerpurchasehistory cp ON cd.customerid = cp.customer
GROUP BY cd.CustomerID, cd.firstname, cd.lastname
HAVING COUNT(*) > 1;
-- 5. Based on the dataset, provide any other metrics that could be useful to the business.
-- Since we are tracking location for customers, we may want use that information to query what is purchased from various locations, 
-- assuming we have a locations table that provides location details.
-- Inventory Replenishment Information - determine the demand for products, based on sales
-- We can query products that are most frequently purchased together
-- We can find out how many customers stop buying over time
