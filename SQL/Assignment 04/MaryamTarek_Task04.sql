-- 1. Retrieve all columns from the Sales table
SELECT * FROM Sales;

-- 2. Retrieve the product_name and unit_price from the Products table
SELECT product_name, unit_price
FROM Products;

-- 3. Retrieve the sale_id and sale_date from the Sales table
SELECT sale_id, sale_date 
FROM Sales;

-- 4. Filter the Sales table to show only sales with a total_price greater that $100
SELECT * FROM Sales
WHERE total_price > 100;

-- 5. Filter the Products table to show only products in the 'Electronics' category
SELECT * FROM Products
WHERE category = 'Electronics';

-- 6. Retrieve the sale_id and total_price from the Sales table for sales made on January 3, 2024
SELECT sale_id, total_price FROM Sales
WHERE sale_date = '2024-01-03';

-- 7. Retrieve the product_id and product_name from the Products table 
--    for products with a unit_price greater than $100
SELECT product_id, product_name FROM Products
WHERE unit_price > 100;

-- 8. Calculate the total revenue generated from all sales in the Sales table
SELECT SUM(total_price) AS "Total Revenue"
FROM Sales;

-- 9. Retrieve sale_id, product_id, and total_price from the Sales table
--    for sales with a quantity_sold greater than 4
SELECT sale_id, product_id, total_price FROM Sales
WHERE quantity_sold > 4;

-- 10. Calculate the total revenue generated from sales of products in the 'Electronics' category
SELECT SUM(total_price) AS "Total Revenue"
FROM Sales s
JOIN Products p
ON s.product_id = p.product_id
WHERE category = 'Electronics';

-- 11. Calculate the total quantity_sold of products in the 'Electronics' category
SELECT SUM(quantity_sold) AS "Electronics Quantity Sold"
FROM Sales s
JOIN Products p
ON s.product_id = p.product_id
WHERE category = 'Electronics';