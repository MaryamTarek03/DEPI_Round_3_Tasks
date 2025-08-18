/*
Project Overview: Online Retail Company
--------------------------------------
A.	Database Design
	-- Database Name: OnlineRetailDB

B.	Tables:
	-- Customers: Stores customer details.
	-- Products: Stores product details.
	-- Orders: Stores order details.
	-- OrderItems: Stores details of each item in an order.
	-- Categories: Stores product categories.

C.	Insert Sample Data:
	-- Populate each table with sample data.

D. Write Queries:
	-- Retrieve data (e.g., customer orders, popular products).
	-- Perform aggregations (e.g., total sales, average order value).
	-- Join tables for comprehensive reports.
	-- Use subqueries and common table expressions (CTEs).
*/

/* LET'S GET STARTED */

-- Create the database
CREATE DATABASE OnlineRetailDB;
GO

-- Use the database
USE OnlineRetailDB;
Go

-- Create the Customers table
CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY IDENTITY(1,1),
	FirstName VARCHAR(50) not null,
	LastName VARCHAR(50) not null,
	Email VARCHAR(100) not null,
	Phone VARCHAR(50) not null,
	City VARCHAR(50),
	StateName VARCHAR(50),
	ZipCode VARCHAR(50),
	Country VARCHAR(50),
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create the Products table
CREATE TABLE Products (
	ProductID INT PRIMARY KEY IDENTITY(1,1),
	ProductName VARCHAR(100) not null,
	CategoryID INT,
	Price DECIMAL(10,2),
	Stock INT,
	CreatedAt DATETIME DEFAULT GETDATE()
);

-- Create the Categories table
CREATE TABLE Categories (
	CategoryID INT PRIMARY KEY IDENTITY(1,1),
	CategoryName VARCHAR(100),
	DescriptionCat VARCHAR(255)
);

-- Create the Orders table
CREATE TABLE Orders (
	OrderId INT PRIMARY KEY IDENTITY(1,1),
	CustomerId INT,
	OrderDate DATETIME DEFAULT GETDATE(),
	TotalAmount DECIMAL(10,2),
	FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);


-- Create the OrderItems table
CREATE TABLE OrderItems (
	OrderItemID INT PRIMARY KEY IDENTITY(1,1),
	OrderID INT,
	ProductID INT,
	Quantity INT,
	Price DECIMAL(10,2),
	FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
	FOREIGN KEY (OrderId) REFERENCES Orders(OrderID)
);

-- Insert sample data into Categories table
INSERT INTO Categories (CategoryName, DescriptionCat) 
VALUES 
('Electronics', 'Devices and Gadgets'),
('Clothing', 'Apparel and Accessories'),
('Books', 'Printed and Electronic Books');

-- Insert sample data into Products table
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES 
('Smartphone', 1, 699.99, 50),
('Laptop', 1, 999.99, 30),
('T-shirt', 2, 19.99, 100),
('Jeans', 2, 49.99, 60),
('Fiction Novel', 3, 14.99, 200),
('Science Journal', 3, 29.99, 150);

-- Insert sample data into Customers table
INSERT INTO Customers(FirstName, LastName, Email, Phone, City, StateName, ZipCode, Country)
VALUES 
('Sameer', 'Khanna', 'sameer.khanna@example.com', '123-456-7890', 'Springfield', 
'IL', '62701', 'USA'),
('Jane', 'Smith', 'jane.smith@example.com', '234-567-8901','Madison', 
'WI', '53703', 'USA'),
('harshad', 'patel', 'harshad.patel@example.com', '345-678-9012', 'Mumbai', 
'Maharashtra', '41520', 'INDIA');

-- Insert sample data into Orders table
INSERT INTO Orders(CustomerId, OrderDate, TotalAmount)
VALUES 
(1, GETDATE(), 719.98),
(2, GETDATE(), 49.99),
(3, GETDATE(), 44.98);

-- Insert sample data into OrderItems table
INSERT INTO OrderItems(OrderID, ProductID, Quantity, Price)
VALUES 
(1, 1, 1, 699.99),
(1, 3, 1, 19.99),
(2, 4, 1,  49.99),
(3, 5, 1, 14.99),
(3, 6, 1, 29.99);


--Query 1: Retrieve all orders for a specific customer
SELECT o.OrderID, o.OrderDate, o.TotalAmount, oi.ProductID, p.ProductName, oi.Quantity, oi.Price
FROM Orders o
JOIN OrderItems oi ON o.OrderId = oi.OrderID
JOIN Products p ON oi.ProductID = p.ProductID
WHERE o.CustomerID = 1;

--Query 2: Find the total sales for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity * oi.Price) AS TotalSales
FROM OrderItems oi
JOIN Products p 
ON oi.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSales DESC;


--Query 3: Calculate the average order value
SELECT AVG(TotalAmount) AS AverageOrderValue FROM Orders;

--Query 4: List the top 5 customers by total spending
SELECT CustomerID, FirstName, LastName, TotalSpent, rn
FROM
(SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpent,
ROW_NUMBER() OVER (ORDER BY SUM(o.TotalAmount) DESC) AS rn
FROM Customers c
JOIN Orders o
ON c.CustomerID = o.CustomerId
GROUP BY c.CustomerID, c.FirstName, c.LastName)
sub WHERE rn <= 5;

--Query 5: Retrieve the most popular product category
SELECT CategoryID, CategoryName, TotalQuantitySold, rn
FROM (
SELECT c.CategoryID, c.CategoryName, SUM(oi.Quantity) AS TotalQuantitySold,
ROW_NUMBER() OVER (ORDER BY SUM(oi.Quantity) DESC) AS rn
FROM OrderItems oi
JOIN Products p 
ON oi.ProductID = p.ProductID
JOIN Categories c
ON p.CategoryID = c.CategoryID
GROUP BY c.CategoryID, c.CategoryName) sub
WHERE rn = 1;


----- to insert a product with zero stock
INSERT INTO Products(ProductName, CategoryID, Price, Stock)
VALUES ('Keyboard', 1, 39.99, 0);

--Query 6: List all products that are out of stock, i.e. stock = 0
SELECT * FROM Products WHERE Stock = 0;

SELECT ProductID, ProductName, Stock FROM Products WHERE Stock = 0;

-- with category name
SELECT p.ProductID, p.ProductName, c.CategoryName, p.Stock 
FROM Products p JOIN Categories c
ON p.CategoryID = c.CategoryID
WHERE Stock = 0;

--Query 7: Find customers who placed orders in the last 30 days
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone
FROM Customers c JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderDate >= DATEADD(DAY, -30, GETDATE());

--Query 8: Calculate the total number of orders placed each month
SELECT YEAR(OrderDate) as OrderYear,
MONTH(OrderDate) as OrderMonth,
COUNT(OrderID) as TotalOrders
FROM Orders
GROUP BY YEAR(OrderDate), MONTH(OrderDate)
ORDER BY OrderYear, OrderMonth;

--Query 9: Retrieve the details of the most recent order
SELECT TOP 1 o.OrderID, o.OrderDate, o.TotalAmount, c.FirstName, c.LastName
FROM Orders o JOIN Customers c
ON o.CustomerID = c.CustomerID
ORDER BY o.OrderDate DESC;

--Query 10: Find the average price of products in each category

SELECT c.CategoryID, c.CategoryName, AVG(p.Price) as AveragePrice 
FROM Categories c JOIN Products p
ON c.CategoryID = p.ProductID
GROUP BY c.CategoryID, c.CategoryName;

--Query 11: List customers who have never placed an order
SELECT c.CustomerID, c.FirstName, c.LastName, c.Email, c.Phone, O.OrderID, o.TotalAmount
FROM Customers c LEFT OUTER JOIN Orders o
ON c.CustomerID = o.CustomerID
WHERE o.OrderId IS NULL;

--Query 12: Retrieve the total quantity sold for each product
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalQuantitySold
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY p.ProductName;

--Query 13: Calculate the total revenue generated from each category
SELECT c.CategoryID, c.CategoryName, SUM(oi.Quantity * oi.Price) AS TotalRevenue
FROM OrderItems oi JOIN Products p
ON oi.ProductID = p.ProductID
JOIN Categories c
ON c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName
ORDER BY TotalRevenue DESC;

--Query 14: Find the highest-priced product in each category
SELECT c.CategoryID, c.CategoryName, p1.ProductID, p1.ProductName, p1.Price
FROM Categories c JOIN Products p1
ON c.CategoryID = p1.CategoryID
WHERE p1.Price = (SELECT Max(Price) FROM Products p2 WHERE p2.CategoryID = p1.CategoryID)
ORDER BY p1.Price DESC;

--Query 15: Retrieve orders with a total amount greater than a specific value (e.g., $500)
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName, o.TotalAmount
FROM Orders o JOIN Customers c
ON o.CustomerID = c.CustomerID
WHERE o.TotalAmount >= 49.99
ORDER BY o.TotalAmount DESC;

--Query 16: List products along with the number of orders they appear in
SELECT p.ProductID, p.ProductName, COUNT(oi.OrderID) as OrderCount
FROM Products p JOIN OrderItems oi
ON p.ProductID = oi.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY OrderCount DESC;

--Query 17: Find the top 3 most frequently ordered products
SELECT TOP 3 p.ProductID, p.ProductName, COUNT(oi.OrderID) AS OrderCount
FROM OrderItems oi JOIN  Products p
ON oi.ProductID = p.ProductID
GROUP BY  p.ProductID, p.ProductName
ORDER BY OrderCount DESC;

--Query 18: Calculate the total number of customers from each country
SELECT Country, COUNT(CustomerID) AS TotalCustomers
FROM Customers GROUP BY Country ORDER BY TotalCustomers DESC;

--Query 19: Retrieve the list of customers along with their total spending
SELECT c.CustomerID, c.FirstName, c.LastName, SUM(o.TotalAmount) AS TotalSpending
FROM Customers c JOIN Orders o
ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName;


--Query 20: List orders with more than a specified number of items (e.g., 5 items)
SELECT o.OrderID, c.CustomerID, c.FirstName, c.LastName, COUNT(oi.OrderItemID) AS NumberOfItems
FROM Orders o JOIN OrderItems oi
ON o.OrderID = oi.OrderID
JOIN Customers c 
ON o.CustomerID = c.CustomerID
GROUP BY o.OrderID, c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(oi.OrderItemID) >= 1
ORDER BY NumberOfItems;



/*
===============================
Implementing Views
===============================
*/

-- View for Product Details: A view combining product details with category names.
CREATE VIEW vw_ProductDeails AS
SELECT p.ProductID, p.ProductName, p.Price, p.Stock, c.CategoryName
FROM Products p INNER JOIN Categories c
ON p.CategoryID = c.CategoryID;
GO

-- Display product details with category names using view
SELECT * FROM vw_ProductDeails;

-- View for Customer Orders : A view to get a summary of orders placed by each customer.
CREATE VIEW vw_CustomerOrders 
AS
SELECT c.CustomerID, c.FirstName, c.LastName, COUNT(o.OrderID) AS TotalOrders,
SUM(oi.Quantity * p.Price) as TotalAmount
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
GROUP BY c.CustomerID, c.FirstName, c.LastName;
GO


-- View for Recent Orders: A view to display orders placed in the last 30 days.
CREATE VIEW vw_RecentOrders 
AS
SELECT o.OrderID, o.OrderDate, c.CustomerID, c.FirstName, c.LastName,
SUM(oi.Quantity * oi.Price) as OrderAmount
FROM Customers c 
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY o.OrderID, o.OrderDate, c.CustomerID, c.FirstName, c.LastName;
GO

--Query 31: Retrieve All Products with Category Names
--Using the vw_ProductDetails view to get a list of all products along with their category names.
SELECT * FROM vw_ProductDeails;

--Query 32: Retrieve Products within a Specific Price Range
--Using the vw_ProductDetails view to find products priced between $100 and $500.
SELECT * FROM vw_ProductDeails WHERE Price BETWEEN 10 AND 500;

--Query 33: Count the Number of Products in Each Category
--Using the vw_ProductDetails view to count the number of products in each category.
SELECT CategoryName, Count(ProductID) AS ProductCount
FROM vw_ProductDeails GROUP BY CategoryName; 

--Query 34: Retrieve Customers with More Than 1 Orders
--Using the vw_CustomerOrders view to find customers who have placed more than 1 orders.
SELECT * FROM vw_CustomerOrders WHERE TotalOrders > 1;

--Query 35: Retrieve the Total Amount Spent by Each Customer
--Using the vw_CustomerOrders view to get the total amount spent by each customer.
SELECT CustomerID, FirstName, LastName, TotalAmount FROM vw_CustomerOrders
ORDER BY TotalAmount DESC;

--Query 36: Retrieve Recent Orders Above a Certain Amount
--Using the vw_RecentOrders view to find recent orders where the total amount is greater than $1000.
SELECT * FROM vw_RecentOrders WHERE OrderAmount > 1000;

--Query 37: Retrieve the Latest Order for Each Customer
--Using the vw_RecentOrders view to find the latest order placed by each customer.
SELECT ro.OrderID, ro.OrderDate, ro.CustomerID, ro.FirstName, ro.LastName, ro.OrderAmount
FROM vw_RecentOrders ro
INNER JOIN 
(SELECT CustomerID, Max(OrderDate) as LatestOrderDate FROM vw_RecentOrders GROUP BY CustomerID)
latest
ON ro.CustomerID = latest.CustomerID AND ro.OrderDate = latest.LatestOrderDate
ORDER BY ro.OrderDate DESC;
GO

--Query 38: Retrieve Products in a Specific Category
--Using the vw_ProductDetails view to get all products in a specific category, such as 'Electronics'.
SELECT * FROM vw_ProductDeails WHERE CategoryName = 'Books';

--Query 39: Retrieve Total Sales for Each Category
--Using the vw_ProductDetails and vw_CustomerOrders views to calculate the total sales for each category.
SELECT pd.CategoryName, SUM(oi.Quantity * p.Price) AS TotalSales
FROM OrderItems oi
INNER JOIN Products p ON oi.ProductID = p.ProductID
INNER JOIN vw_ProductDeails pd ON p.ProductID = pd.ProductID
GROUP BY pd.CategoryName
ORDER BY TotalSales DESC;

--Query 40: Retrieve Customer Orders with Product Details
--Using the vw_CustomerOrders and vw_ProductDetails views to get customer orders along with the details 
-- of the products ordered.
SELECT co.CustomerID, co.FirstName, co.LastName, o.OrderID, o.OrderDate,
pd.ProductName, oi.Quantity, pd.Price
FROM Orders o 
INNER JOIN OrderItems oi ON o.OrderID = oi.OrderID
INNER JOIN vw_ProductDeails pd ON oi.ProductID = pd.ProductID
INNER JOIN vw_CustomerOrders co ON o.CustomerID = co.CustomerID
ORDER BY o.OrderDate DESC;

--Query 41: Retrieve Top 5 Customers by Total Spending
--Using the vw_CustomerOrders view to find the top 5 customers based on their total spending.
SELECT TOP 5 CustomerID, FirstName, LastName, TotalAmount 
FROM vw_CustomerOrders ORDER BY TotalAmount DESC;

--Query 42: Retrieve Products with Low Stock
--Using the vw_ProductDetails view to find products with stock below a certain threshold, such as 10 units.
SELECT * FROM vw_ProductDeails WHERE Stock < 50;

--Query 43: Retrieve Orders Placed in the Last 7 Days
--Using the vw_RecentOrders view to find orders placed in the last 7 days.
SELECT * from vw_RecentOrders WHERE OrderDate >= DATEADD(DAY, -7, GETDATE());

--Query 44: Retrieve Products Sold in the Last Month
--Using the vw_RecentOrders view to find products sold in the last month.
SELECT p.ProductID, p.ProductName, SUM(oi.Quantity) AS TotalSold
FROM vw_RecentOrders ro
INNER JOIN OrderItems oi ON ro.OrderID = oi.OrderID
INNER JOIN Products p ON oi.ProductID = p.ProductID
WHERE ro.OrderDate >= DATEADD(MONTH, -1, GETDATE())
GROUP BY p.ProductID, p.ProductName
ORDER BY TotalSold DESC;

/*
=========================================================
Implementing Security / Role-Based Access Control (RBAC)
=========================================================

To manage access control in SQL Server, you'll need to use a combination of SQL Server's security features, 
such as logins, users, roles, and permissions. 

Here's a step-by-step guide on how to do this:

### Step 1: Create Logins
----------------------------------
			First, create logins at the SQL Server level. 
			Logins are used to authenticate users to the SQL Server instance.
*/
-- Create a login with SQL Server Authentication
CREATE LOGIN SalesUser WITH PASSWORD = 'strongpassword';

/*
### Step 2: Create Users
----------------------------------
			Next, create users in the `OnlineRetailDB` database for each login. 
			Users are associated with logins and are used to grant access to the database.
*/
USE OnlineRetailDB;
GO

-- Create a user in the database for the SQL Server Login
CREATE USER SalesUser FOR LOGIN SalesUser;


/*
### Step 3: Create Roles
----------------------------------
			Define roles in the database that will be used to group users with similar permissions. 
			This helps simplify permission management.
*/
-- Create roles in the database
CREATE ROLE SalesRole;
CREATE ROLE MarketingRole;

/*
### Step 4: Assign Users to Roles
----------------------------------
			Add the users to the appropriate roles.
*/
-- Add users to roles
EXEC sp_addrolemember 'SalesRole', 'SalesUser';

/*
### Step 5: Grant Permissions
----------------------------------
			Grant the necessary permissions to the roles based on the access requirements
*/
-- GRANT SELECT permission on the Customers Table to the SalesRole
GRANT SELECT ON Customers TO SalesRole;

-- GRANT INSERT permission on the Orders Table to the SalesRole
GRANT INSERT ON Orders TO SalesRole;

-- GRANT UPDATE permission on the Orders Table to the SalesRole
GRANT UPDATE ON Orders TO SalesRole;

-- GRANT SELECT permission on the Products Table to the SalesRole
GRANT SELECT ON Products TO SalesRole;

--//////////////////Eng.Mohamed Mahmoud ///////////////////////--