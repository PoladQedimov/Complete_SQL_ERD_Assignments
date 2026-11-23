-- ONE-FILE SUBMISSION: Complete SQL & Relational Database Design assignment
-- SQLite 3; includes setup, B01-B10 and Scenarios 1-6.
-- Execute against a fresh/practice database: setup resets the four tables.



-- ===========================================================================
-- FILE: 00_setup.sql
-- ===========================================================================
-- SQL & Relational Database Design | Complete assignment
-- DBMS: SQLite 3
-- Source: Complete_SQL_ERD_Assignments_Expanded.pdf, pages 2-7
-- Run this first. It recreates the CLEAN reference dataset.
PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS Orders;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Employees;

CREATE TABLE Customers (
    CustomerID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Country VARCHAR(50) NOT NULL,
    Score INTEGER
);

CREATE TABLE Products (
    ProductID INTEGER PRIMARY KEY,
    Product VARCHAR(100) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INTEGER PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Department VARCHAR(50) NOT NULL,
    BirthDate DATE,
    Gender VARCHAR(10),
    Salary DECIMAL(10,2),
    ManagerID INTEGER,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Orders (
    OrderID INTEGER PRIMARY KEY,
    ProductID INTEGER NOT NULL,
    CustomerID INTEGER NOT NULL,
    SalesPersonID INTEGER NOT NULL,
    OrderDate DATE NOT NULL,
    ShipDate DATE,
    OrderStatus VARCHAR(30) NOT NULL,
    ShipAddress VARCHAR(150),
    BillAddress VARCHAR(150),
    Quantity INTEGER NOT NULL,
    Sales DECIMAL(10,2) NOT NULL,
    CreationTime DATETIME NOT NULL,
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (SalesPersonID) REFERENCES Employees(EmployeeID)
);

-- Reference: 9 customers.
INSERT INTO Customers (CustomerID, FirstName, LastName, Country, Score) VALUES
(1, 'Ayla', 'Karimova', 'Azerbaijan', 720),
(2, 'John', 'Miller', 'USA', 450),
(3, 'Emma', 'Schmidt', 'Germany', 860),
(4, 'Sara', 'Martin', 'France', 280),
(5, 'Lukas', 'Weber', 'Germany', 550),
(6, 'Noah', 'Adams', 'USA', 610),
(7, 'Lea', 'Fischer', 'Germany', 680),
(8, 'Sofia', 'Rossi', 'Italy', 700),
(9, 'Ali', 'Hasanov', 'Azerbaijan', 330);

-- Reference: 8 products.
INSERT INTO Products (ProductID, Product, Category, Price) VALUES
(101, 'Wireless Mouse', 'Electronics', 55.00),
(102, 'Office Chair', 'Furniture', 230.00),
(103, 'Laptop', 'Electronics', 850.00),
(104, 'Notebook', 'Stationery', 12.00),
(105, 'Smart Phone', 'Electronics', 420.00),
(106, 'Standing Desk', 'Furniture', 380.00),
(107, 'USB Hub', 'Electronics', 45.00),
(108, 'Desk Lamp', 'Furniture', 65.00);

-- Insert manager (12) before direct reports (11, 13, 14, 15).
INSERT INTO Employees
    (EmployeeID, FirstName, LastName, Department, BirthDate, Gender, Salary, ManagerID)
VALUES
(12, 'Maya', 'Brown', 'Sales', '1990-07-09', 'Female', 2400.00, NULL),
(11, 'David', 'Lee', 'Sales', '1987-05-14', 'Male', 2200.00, 12),
(13, 'Alex', 'Green', 'Support', '1994-11-21', 'Male', 1900.00, 12),
(14, 'Omar', 'Ali', 'Sales', '1995-02-17', 'Male', 2100.00, 12),
(15, 'Nina', 'Stone', 'Sales', '1998-08-03', 'Female', 2000.00, 12);

-- Reference: 24 orders. Each Sales amount is already the FULL order total.
-- CreationTime is OrderDate at 10:00:00. NULL is a real SQL NULL.
-- Orders 221 and 222 intentionally contain shipment-date anomalies: DO NOT FIX.
INSERT INTO Orders
    (OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate,
     OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(201, 101, 1, 11, '2026-10-04', '2026-10-06', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 2, 110, '2026-10-04 10:00:00'),
(202, 103, 3, 12, '2026-10-08', '2026-10-18', 'Shipped', '22 Oak St, Berlin', '22 Oak St, Berlin', 1, 850, '2026-10-08 10:00:00'),
(203, 102, 2, 11, '2026-10-12', NULL, 'Pending', NULL, '45 Main St, New York', 1, 230, '2026-10-12 10:00:00'),
(204, 105, 5, 12, '2026-10-15', '2026-10-19', 'Delivered', '16 Park Rd, Munich', '16 Park Rd, Munich', 1, 420, '2026-10-15 10:00:00'),
(205, 103, 3, 12, '2026-10-20', '2026-10-22', 'Delivered', '22 Oak St, Berlin', '22 Oak St, Berlin', 8, 6800, '2026-10-20 10:00:00'),
(206, 105, 2, 11, '2026-10-21', '2026-10-23', 'Delivered', '45 Main St, New York', '9 Pine St, Boston', 3, 1260, '2026-10-21 10:00:00'),
(207, 102, 6, 14, '2026-10-22', '2026-10-24', 'Delivered', '31 Oak St, Boston', '31 Oak St, Boston', 4, 920, '2026-10-22 10:00:00'),
(208, 101, 4, 11, '2026-10-23', NULL, 'Pending', NULL, '8 Rue Lyon, Paris', 2, 110, '2026-10-23 10:00:00'),
(209, 106, 1, 14, '2026-10-24', '2026-10-27', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 2, 760, '2026-10-24 10:00:00'),
(210, 103, 6, 14, '2026-10-25', NULL, 'Cancelled', '31 Oak St, Boston', '31 Oak St, Boston', 2, 1700, '2026-10-25 10:00:00'),
(211, 104, 5, 11, '2026-10-26', '2026-10-28', 'Delivered', '16 Park Rd, Munich', '16 Park Rd, Munich', 10, 120, '2026-10-26 10:00:00'),
(212, 105, 3, 12, '2026-10-27', NULL, 'Pending', NULL, '22 Oak St, Berlin', 2, 840, '2026-10-27 10:00:00'),
(213, 107, 2, 11, '2026-10-28', '2026-10-30', 'Shipped', '45 Main St, New York', '45 Main St, New York', 3, 135, '2026-10-28 10:00:00'),
(214, 103, 8, 14, '2026-10-29', '2026-11-01', 'Delivered', '18 Via Roma, Milan', '18 Via Roma, Milan', 1, 850, '2026-10-29 10:00:00'),
(215, 106, 5, 12, '2026-10-30', NULL, 'Pending', '16 Park Rd, Munich', '16 Park Rd, Munich', 1, 380, '2026-10-30 10:00:00'),
(216, 101, 1, 11, '2026-11-02', '2026-11-04', 'Delivered', '10 Nizami St, Baku', '10 Nizami St, Baku', 1, 55, '2026-11-02 10:00:00'),
(217, 102, 7, 14, '2026-11-03', '2026-11-05', 'Shipped', '9 River St, Berlin', '9 River St, Berlin', 1, 230, '2026-11-03 10:00:00'),
(218, 105, 6, 14, '2026-11-04', NULL, 'Pending', '31 Oak St, Boston', NULL, 1, 420, '2026-11-04 10:00:00'),
(219, 103, 3, 12, '2026-11-05', '2026-11-06', 'Shipped', '22 Oak St, Berlin', '22 Oak St, Berlin', 1, 850, '2026-11-05 10:00:00'),
(220, 104, 2, 11, '2026-11-06', '2026-11-07', 'Delivered', '45 Main St, New York', '45 Main St, New York', 5, 60, '2026-11-06 10:00:00'),
(221, 107, 6, 14, '2026-10-28', NULL, 'Shipped', '31 Oak St, Boston', '31 Oak St, Boston', 1, 45, '2026-10-28 10:00:00'),
(222, 102, 4, 11, '2026-10-31', '2026-10-30', 'Shipped', '8 Rue Lyon, Paris', '8 Rue Lyon, Paris', 1, 230, '2026-10-31 10:00:00'),
(223, 102, 2, 11, '2026-10-29', '2026-10-31', 'Delivered', '45 Main St, New York', '45 Main St, New York', 1, 230, '2026-10-29 10:00:00'),
(224, 101, 3, 12, '2026-11-02', NULL, 'Pending', '22 Oak St, Berlin', '22 Oak St, Berlin', 2, 110, '2026-11-02 10:00:00');

-- Validation (expect: 9 / 8 / 5 / 24):
SELECT 'Customers' AS TableName, COUNT(*) AS RowCount FROM Customers
UNION ALL SELECT 'Products', COUNT(*) FROM Products
UNION ALL SELECT 'Employees', COUNT(*) FROM Employees
UNION ALL SELECT 'Orders', COUNT(*) FROM Orders;

-- Expect no rows: every relation is valid.
PRAGMA foreign_key_check;


-- ===========================================================================
-- FILE: 01_basic_tasks.sql
-- ===========================================================================
-- PART I: BASIC SQL | B01-B10 | SQLite 3
-- Read-only queries first; B10 is safely rolled back.

-- [B01] All customer columns; then selected columns.
SELECT * FROM Customers;
SELECT FirstName, LastName, Country FROM Customers;

-- [B02] Customers from Germany.
SELECT CustomerID, FirstName, LastName, Country
FROM Customers
WHERE Country = 'Germany';

-- [B03] Score >= 300 AND Germany/France.
SELECT CustomerID, FirstName, LastName, Country, Score
FROM Customers
WHERE Score >= 300 AND Country IN ('Germany', 'France');

-- [B04] Highest priced products first.
SELECT ProductID, Product, Category, Price
FROM Products
ORDER BY Price DESC;

-- [B05] Price between 50 and 300, inclusive.
SELECT Product, Price
FROM Products
WHERE Price BETWEEN 50 AND 300;

-- [B06] Product name contains 'Phone'.
SELECT Product, Category
FROM Products
WHERE Product LIKE '%Phone%';

-- [B07] Each category exactly once.
SELECT DISTINCT Category
FROM Products
ORDER BY Category;

-- [B08] Pair each order with its customer.
SELECT o.OrderID, c.FirstName, c.LastName
FROM Orders AS o
INNER JOIN Customers AS c ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID;

-- [B09] Count orders and sum STORED Sales by status.
SELECT OrderStatus, COUNT(*) AS OrderCount, SUM(Sales) AS TotalSales
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalSales DESC;

-- [B10] Safe INSERT, UPDATE, verify, DELETE (not permanent).
-- WHERE is essential: otherwise UPDATE/DELETE affects every product.
SAVEPOINT basic_task_b10;
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (999, 'Practice Product', 'Electronics', 20.00);
SELECT * FROM Products WHERE ProductID = 999; -- Preview
UPDATE Products SET Price = 25.00 WHERE ProductID = 999;
SELECT * FROM Products WHERE ProductID = 999; -- Verify updated price
DELETE FROM Products WHERE ProductID = 999;
SELECT * FROM Products WHERE ProductID = 999; -- Empty = deleted
ROLLBACK TO SAVEPOINT basic_task_b10; -- Restore original reference
RELEASE SAVEPOINT basic_task_b10;


-- ===========================================================================
-- FILE: 02_scenario_1.sql
-- ===========================================================================
-- SCENARIO 1: Customer loyalty and sales analysis | 1.1-1.7
-- All stored orders count in this scenario, regardless of their status.

-- [1.1] Customers with Score above 500.
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Score > 500
ORDER BY Score DESC;

-- [1.2] Target-country customers with Score >= 300.
SELECT FirstName, LastName, Country, Score
FROM Customers
WHERE Country IN ('Germany', 'France', 'USA') AND Score >= 300;

-- [1.3] Each order with full customer name, date and stored Sales.
SELECT c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderID, o.OrderDate, o.Sales
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
ORDER BY o.OrderID;

-- [1.4] Customers without ANY orders: LEFT JOIN keeps unmatched customers.
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country
FROM Customers AS c
LEFT JOIN Orders AS o ON o.CustomerID = c.CustomerID
WHERE o.OrderID IS NULL
ORDER BY c.CustomerID;

-- [1.5] Every purchaser's total stored Sales (not Sales * Quantity).
SELECT c.CustomerID, c.FirstName || ' ' || c.LastName AS CustomerName,
       SUM(o.Sales) AS TotalSales
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalSales DESC, c.CustomerID;

-- [1.6] Purchasers with total Sales > 1000. HAVING filters groups.
SELECT c.CustomerID, c.FirstName || ' ' || c.LastName AS CustomerName,
       SUM(o.Sales) AS TotalSales
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING SUM(o.Sales) > 1000
ORDER BY TotalSales DESC, c.CustomerID;

-- [1.7] Top five customers, including country.
SELECT c.CustomerID, c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country, SUM(o.Sales) AS TotalSales
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Country
ORDER BY TotalSales DESC, c.CustomerID
LIMIT 5;

-- Explanation: 'no orders' means no Orders row exists for a customer.
-- 'No qualifying orders' may mean orders exist but fail a date/status filter.


-- ===========================================================================
-- FILE: 03_scenario_2.sql
-- ===========================================================================
-- SCENARIO 2: Order and delivery investigation | 2.1-2.9
-- 2.5-2.7 operate on a temporary practice copy via SAVEPOINT.

-- [2.1] All October orders, inclusive of both month boundaries.
SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus
FROM Orders
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
ORDER BY OrderDate, OrderID;

-- [2.2] Pending queue from oldest to newest.
SELECT OrderID, CustomerID, OrderDate, ShipDate, OrderStatus
FROM Orders
WHERE OrderStatus = 'Pending'
ORDER BY OrderDate, OrderID;

-- [2.3] More than seven days between OrderDate and ShipDate.
-- julianday(date2) - julianday(date1) returns elapsed days in SQLite.
SELECT o.OrderID, c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate, o.ShipDate
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
WHERE julianday(o.ShipDate) - julianday(o.OrderDate) > 7
ORDER BY o.OrderID;

-- [2.4] Unique customers affected by delays found in 2.3.
SELECT DISTINCT c.CustomerID, c.FirstName, c.LastName, c.Country
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
WHERE julianday(o.ShipDate) - julianday(o.OrderDate) > 7
ORDER BY c.CustomerID;

SAVEPOINT scenario_2_practice;

-- Create three valid TEMPORARY records; IDs 105, 110 and 999 do NOT exist in the reference.
INSERT INTO Orders
(OrderID, ProductID, CustomerID, SalesPersonID, OrderDate, ShipDate,
 OrderStatus, ShipAddress, BillAddress, Quantity, Sales, CreationTime)
VALUES
(105, 101, 1, 11, '2026-11-03', NULL, 'Pending', NULL, '10 Nizami St, Baku', 1, 55, '2026-11-03 10:00:00'),
(110, 102, 2, 11, '2026-11-04', NULL, 'Pending', NULL, '45 Main St, New York', 1, 230, '2026-11-04 10:00:00'),
(999, 104, 3, 12, '2026-11-05', NULL, 'Pending', NULL, '22 Oak St, Berlin', 1, 12, '2026-11-05 10:00:00');

-- [2.5] Preview, update status/date for only OrderID 105, verify.
SELECT OrderID, OrderStatus, ShipDate FROM Orders WHERE OrderID = 105;
UPDATE Orders
SET OrderStatus = 'Shipped', ShipDate = '2026-11-05'
WHERE OrderID = 105;
SELECT OrderID, OrderStatus, ShipDate FROM Orders WHERE OrderID = 105;

-- [2.6] Preview, correct only OrderID 110's shipping address, verify.
SELECT OrderID, ShipAddress FROM Orders WHERE OrderID = 110;
UPDATE Orders
SET ShipAddress = '45 Main Street, Baku'
WHERE OrderID = 110;
SELECT OrderID, ShipAddress FROM Orders WHERE OrderID = 110;

-- [2.7] Preview and delete ONLY the temporary OrderID 999.
SELECT OrderID, OrderStatus FROM Orders WHERE OrderID = 999;
DELETE FROM Orders WHERE OrderID = 999;
SELECT OrderID FROM Orders WHERE OrderID = 999; -- Empty = deleted

-- [2.8] Count per status in the practice copy after the changes.
SELECT OrderStatus, COUNT(*) AS OrderCount
FROM Orders
GROUP BY OrderStatus
ORDER BY OrderStatus;

-- [2.9] Unshipped in the practice copy; Pending and Cancelled are not conflated.
SELECT o.OrderID, c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate, o.ShipDate, o.OrderStatus
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
WHERE o.ShipDate IS NULL
ORDER BY o.OrderDate, o.OrderID;

-- Restore the clean 24-row reference dataset before other scenarios.
ROLLBACK TO SAVEPOINT scenario_2_practice;
RELEASE SAVEPOINT scenario_2_practice;


-- ===========================================================================
-- FILE: 04_scenario_3.sql
-- ===========================================================================
-- SCENARIO 3: Products and employee performance | 3.1-3.12
-- Uses all stored orders, not qualifying-sale rules of Scenarios 4/6.

-- [3.1] Products priced from 50 to 300 inclusive.
SELECT Product, Category, Price
FROM Products
WHERE Price BETWEEN 50 AND 300
ORDER BY Price ASC, ProductID;

-- [3.2] Electronics with Price > 500.
SELECT ProductID, Product, Category, Price
FROM Products
WHERE Category = 'Electronics' AND Price > 500;

-- [3.3] Every order and its related product attributes.
SELECT p.Product, p.Category, o.Quantity, o.Sales
FROM Orders AS o
JOIN Products AS p ON p.ProductID = o.ProductID
ORDER BY o.OrderID;

-- [3.4] Best-selling products by summed quantity; use ID to distinguish items.
SELECT p.ProductID, p.Product, SUM(o.Quantity) AS TotalQuantity
FROM Products AS p
JOIN Orders AS o ON o.ProductID = p.ProductID
GROUP BY p.ProductID, p.Product
ORDER BY TotalQuantity DESC, p.ProductID
LIMIT 5;

-- [3.5] Products never ordered.
SELECT p.ProductID, p.Product, p.Category, p.Price
FROM Products AS p
LEFT JOIN Orders AS o ON o.ProductID = p.ProductID
WHERE o.OrderID IS NULL
ORDER BY p.ProductID;

-- [3.6] Employees with orders and their stored total Sales.
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Department, SUM(o.Sales) AS TotalSales
FROM Employees AS e
JOIN Orders AS o ON o.SalesPersonID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName, e.Department
ORDER BY TotalSales DESC, e.EmployeeID;

-- [3.7] Employees with summed Sales > 5000.
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       SUM(o.Sales) AS TotalSales
FROM Employees AS e
JOIN Orders AS o ON o.SalesPersonID = e.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING SUM(o.Sales) > 5000
ORDER BY TotalSales DESC, e.EmployeeID;

SAVEPOINT scenario_3_practice;

-- [3.8] Insert the explicitly requested new product (practice only).
INSERT INTO Products (ProductID, Product, Category, Price)
VALUES (501, 'Wireless Keyboard', 'Electronics', 75);
SELECT * FROM Products WHERE ProductID = 501;

-- [3.9] Change 501's price from 75 to 90 and verify.
UPDATE Products SET Price = 90 WHERE ProductID = 501 AND Price = 75;
SELECT ProductID, Product, Price FROM Products WHERE ProductID = 501;

-- [3.10] Add an integer stock column, in the SAME practice savepoint.
ALTER TABLE Products ADD COLUMN StockQuantity INTEGER;
PRAGMA table_info(Products); -- Verify structure, includes StockQuantity.

-- [3.11] Unique name combinations from customers and employees.
SELECT FirstName, LastName FROM Customers
UNION
SELECT FirstName, LastName FROM Employees
ORDER BY FirstName, LastName;

-- [3.12] Category quantity & total stored Sales, only totals above 2000.
SELECT p.Category, SUM(o.Quantity) AS TotalQuantity,
       SUM(o.Sales) AS TotalSales
FROM Products AS p
JOIN Orders AS o ON o.ProductID = p.ProductID
GROUP BY p.Category
HAVING SUM(o.Sales) > 2000
ORDER BY TotalSales DESC, p.Category;

-- In SQLite ALTER TABLE ADD COLUMN can be rolled back inside a savepoint.
ROLLBACK TO SAVEPOINT scenario_3_practice;
RELEASE SAVEPOINT scenario_3_practice;


-- ===========================================================================
-- FILE: 05_scenario_4.sql
-- ===========================================================================
-- SCENARIO 4: Targeted campaign planning | 4.1-4.10
-- Every commercial query uses qualifying OCTOBER sales:
-- status Shipped/Delivered, ShipDate present AND >= OrderDate,
-- OrderDate from 2026-10-01 through 2026-10-31 inclusive.
-- For target-country queries, countries = Germany, France, USA.

-- [4.1] Four-table campaign sales register: one row per order.
SELECT o.OrderID, o.OrderDate, c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName, c.Country,
       p.Product, p.Category,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.Quantity, o.Sales
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
ORDER BY c.Country, o.OrderDate, o.OrderID;

-- [4.2] Priority electronics: score >=500 OR this order's Sales >=1000.
-- Parentheses make sure both alternatives obey all outer conditions.
SELECT o.OrderID, c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country, c.Score, p.Product, o.Sales
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Electronics'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
  AND (c.Score >= 500 OR o.Sales >= 1000)
ORDER BY o.OrderID;

-- [4.3] Catalogue only: no order or date filter.
SELECT ProductID, Product, Category, Price
FROM Products
WHERE Category = 'Electronics'
  AND Price BETWEEN 40 AND 100
  AND (Product LIKE '%Wireless%' OR Product LIKE '%USB%')
ORDER BY Price, ProductID;

-- [4.4] Each customer once; EXISTS avoids duplicate recipient rows.
SELECT c.CustomerID, c.FirstName, c.LastName, c.Country, c.Score
FROM Customers AS c
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND c.Score >= 500
  AND EXISTS (
      SELECT 1
      FROM Orders AS o
      JOIN Products AS p ON p.ProductID = o.ProductID
      WHERE o.CustomerID = c.CustomerID
        AND p.Category = 'Electronics'
        AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
        AND o.OrderStatus IN ('Shipped', 'Delivered')
        AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
  )
ORDER BY c.CustomerID;

-- [4.5] At least 2 qualifying orders AND Sales >= 1000.
SELECT c.CustomerID, c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Quantity) AS TotalQuantity, SUM(o.Sales) AS TotalSales
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(o.OrderID) >= 2 AND SUM(o.Sales) >= 1000
ORDER BY TotalSales DESC, c.CustomerID;

-- [4.6] Country/category demand with aggregate Sales > 500.
SELECT c.Country, p.Category,
       COUNT(o.OrderID) AS OrderCount,
       SUM(o.Quantity) AS TotalQuantity, SUM(o.Sales) AS TotalSales
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
GROUP BY c.Country, p.Category
HAVING SUM(o.Sales) > 500
ORDER BY TotalSales DESC, c.Country, p.Category;

-- [4.7] No qualifying October activity; filter the JOIN, not WHERE.
SELECT c.CustomerID, c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country, c.Score
FROM Customers AS c
LEFT JOIN Orders AS o
  ON o.CustomerID = c.CustomerID
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND o.OrderID IS NULL
ORDER BY c.CustomerID;

-- [4.8] INTERSECT = buyers of BOTH Electronics AND Furniture.
SELECT c.CustomerID
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Electronics'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
INTERSECT
SELECT c.CustomerID
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Furniture'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
ORDER BY 1;

-- [4.9] UNION = customers in EITHER of the two qualifying categories.
SELECT c.CustomerID
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Electronics'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
UNION
SELECT c.CustomerID
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Furniture'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
ORDER BY 1;

-- [4.10] EXCEPT = Electronics buyers without qualifying Furniture purchase.
SELECT c.CustomerID
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Electronics'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
EXCEPT
SELECT c.CustomerID
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE c.Country IN ('Germany', 'France', 'USA')
  AND p.Category = 'Furniture'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
ORDER BY 1;

-- Filter explanation (4.2): order 206 qualifies by Sales >= 1000 even though
-- John Miller's Score is 450. Order 212 is Pending and is excluded despite Emma's high Score.
-- JOIN explanation (4.1): order 205 matches one Customer, Product and Employee
-- via IDs and yields exactly one row. Order 221 is excluded: Shipped but ShipDate NULL.


-- ===========================================================================
-- FILE: 06_scenario_5.sql
-- ===========================================================================
-- SCENARIO 5: Fulfilment exception desk | 5.1-5.10
-- Fixed operational snapshot = 2026-11-07.
-- Examine raw operational anomalies: do NOT apply commercial-sale filters.

-- [5.1] Pending work queue, one row per order and oldest first.
SELECT o.OrderID, o.OrderDate,
       c.FirstName || ' ' || c.LastName AS CustomerName, c.Country,
       p.Product, o.Quantity, o.Sales,
       e.FirstName || ' ' || e.LastName AS EmployeeName,
       o.ShipAddress
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderStatus = 'Pending' AND o.OrderDate <= '2026-11-07'
ORDER BY o.OrderDate, o.OrderID;

-- [5.2] Pending/no ShipDate and > 7 days old: strictly before Oct 31.
SELECT o.OrderID, c.FirstName || ' ' || c.LastName AS CustomerName,
       o.OrderDate, p.Product,
       e.FirstName || ' ' || e.LastName AS EmployeeName, o.Sales
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderStatus = 'Pending'
  AND o.ShipDate IS NULL
  AND o.OrderDate < '2026-10-31'
ORDER BY o.OrderDate, o.OrderID;

-- [5.3] Pending orders with NULL or empty ShipAddress.
SELECT o.OrderID, c.CustomerID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS EmployeeName, o.ShipAddress
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderDate <= '2026-11-07'
  AND o.OrderStatus = 'Pending'
  AND (o.ShipAddress IS NULL OR TRIM(o.ShipAddress) = '')
ORDER BY o.OrderID;

-- [5.4] Two present, non-empty address fields that differ.
SELECT o.OrderID,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       o.ShipAddress, o.BillAddress, o.OrderStatus
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
WHERE o.OrderDate <= '2026-11-07'
  AND o.OrderStatus <> 'Cancelled'
  AND o.ShipAddress IS NOT NULL AND TRIM(o.ShipAddress) <> ''
  AND o.BillAddress IS NOT NULL AND TRIM(o.BillAddress) <> ''
  AND o.ShipAddress <> o.BillAddress
ORDER BY o.OrderID;

-- [5.5] ShipDate earlier than OrderDate OR Shipped/Delivered without ShipDate.
SELECT o.OrderID, o.OrderStatus, o.OrderDate, o.ShipDate,
       c.FirstName || ' ' || c.LastName AS CustomerName,
       e.FirstName || ' ' || e.LastName AS EmployeeName
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderDate <= '2026-11-07'
  AND (o.ShipDate < o.OrderDate
       OR (o.OrderStatus IN ('Shipped', 'Delivered') AND o.ShipDate IS NULL))
ORDER BY o.OrderID;

-- [5.6] Valid dispatch dates, non-cancelled, delay strictly > 7 days.
SELECT o.OrderID, c.FirstName || ' ' || c.LastName AS CustomerName,
       p.Product, o.OrderDate, o.ShipDate,
       CAST(julianday(o.ShipDate) - julianday(o.OrderDate) AS INTEGER) AS DaysToShip
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE o.OrderDate <= '2026-11-07'
  AND o.OrderStatus <> 'Cancelled'
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
  AND julianday(o.ShipDate) - julianday(o.OrderDate) > 7
ORDER BY DaysToShip DESC, o.OrderID;

-- [5.7] Every Sales employee, even with 0 pending/unshipped orders.
-- Conditions in ON ensure unmatched employees remain in the results.
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(o.OrderID) AS PendingOrderCount,
       COALESCE(SUM(o.Sales), 0) AS PendingSales
FROM Employees AS e
LEFT JOIN Orders AS o
  ON o.SalesPersonID = e.EmployeeID
 AND o.OrderStatus = 'Pending' AND o.ShipDate IS NULL
 AND o.OrderDate <= '2026-11-07'
WHERE e.Department = 'Sales'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY e.EmployeeID;

-- [5.8] Customers with >= 2 Pending orders and ShipDate NULL.
SELECT c.CustomerID, c.FirstName || ' ' || c.LastName AS CustomerName,
       COUNT(o.OrderID) AS PendingOrderCount, SUM(o.Sales) AS PendingSales
FROM Customers AS c
JOIN Orders AS o ON o.CustomerID = c.CustomerID
WHERE o.OrderStatus = 'Pending' AND o.ShipDate IS NULL
  AND o.OrderDate <= '2026-11-07'
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING COUNT(o.OrderID) >= 2
ORDER BY c.CustomerID;

-- [5.9] Target country + min Sales apply to BOTH urgency conditions.
SELECT o.OrderID, c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country, p.Product, o.Sales, o.OrderStatus,
       o.OrderDate, o.ShipDate
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
WHERE o.OrderDate <= '2026-11-07'
  AND c.Country IN ('Germany', 'USA')
  AND o.OrderStatus <> 'Cancelled'
  AND o.Sales >= 500
  AND (
      (o.OrderStatus = 'Pending' AND o.ShipDate IS NULL)
      OR (o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
          AND julianday(o.ShipDate) - julianday(o.OrderDate) > 7)
  )
ORDER BY o.OrderID;

-- [5.10] Dispatch-ready Pending orders: shipping address present, ShipDate NULL.
SELECT o.OrderID, c.FirstName || ' ' || c.LastName AS CustomerName,
       c.Country, p.Product, o.Quantity, o.ShipAddress,
       e.FirstName || ' ' || e.LastName AS EmployeeName
FROM Orders AS o
JOIN Customers AS c ON c.CustomerID = o.CustomerID
JOIN Products AS p ON p.ProductID = o.ProductID
JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
WHERE o.OrderDate <= '2026-11-07'
  AND o.OrderStatus = 'Pending'
  AND o.ShipDate IS NULL
  AND o.ShipAddress IS NOT NULL AND TRIM(o.ShipAddress) <> ''
ORDER BY c.Country, o.OrderDate, o.OrderID;

-- Filter explanation (5.5): order 221 is Shipped but ShipDate is NULL;
-- it must be flagged. Order 210 is Cancelled with NULL ShipDate and is not flagged.
-- JOIN explanation (5.7): Nina Stone (15) is included despite zero orders;
-- LEFT JOIN retains her row and COALESCE makes her amount 0.


-- ===========================================================================
-- FILE: 07_scenario_6.sql
-- ===========================================================================
-- SCENARIO 6: Sales team review and retention | 6.1-6.10
-- Qualifying sales: OrderStatus Shipped/Delivered, ShipDate present and >= OrderDate.
-- Report period is always OrderDate; October and Nov 01-07 are disjoint.

-- [6.1] Employees and direct managers, including those without a manager.
SELECT e.EmployeeID,
       e.FirstName || ' ' || e.LastName AS EmployeeName, e.Department,
       e.ManagerID,
       m.FirstName || ' ' || m.LastName AS ManagerName
FROM Employees AS e
LEFT JOIN Employees AS m ON m.EmployeeID = e.ManagerID
ORDER BY e.EmployeeID;

-- [6.2] Fair October scorecard: retain staff with no qualifying sales.
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(o.OrderID) AS OrderCount,
       COALESCE(SUM(o.Quantity), 0) AS TotalQuantity,
       COALESCE(SUM(o.Sales), 0) AS TotalSales
FROM Employees AS e
LEFT JOIN Orders AS o
  ON o.SalesPersonID = e.EmployeeID
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
WHERE e.Department = 'Sales'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY TotalSales DESC, e.EmployeeID;

-- [6.3] Direct-report Sales employees ONLY; exclude the manager's own orders.
SELECT m.EmployeeID AS ManagerID,
       m.FirstName || ' ' || m.LastName AS ManagerName,
       COUNT(DISTINCT s.EmployeeID) AS DirectSalesStaffCount,
       COUNT(o.OrderID) AS TeamOrderCount,
       COALESCE(SUM(o.Sales), 0) AS TeamSales
FROM Employees AS m
JOIN Employees AS s ON s.ManagerID = m.EmployeeID AND s.Department = 'Sales'
LEFT JOIN Orders AS o
  ON o.SalesPersonID = s.EmployeeID
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
GROUP BY m.EmployeeID, m.FirstName, m.LastName
ORDER BY m.EmployeeID;

-- [6.4] At least 2 qualifying October orders AND total Sales >= 1000.
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(o.OrderID) AS OrderCount, SUM(o.Sales) AS TotalSales
FROM Employees AS e
JOIN Orders AS o ON o.SalesPersonID = e.EmployeeID
WHERE e.Department = 'Sales'
  AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND o.OrderStatus IN ('Shipped', 'Delivered')
  AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) >= 2 AND SUM(o.Sales) >= 1000
ORDER BY TotalSales DESC, e.EmployeeID;

-- [6.5] Distinct October customers and their distinct countries per salesperson.
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       COUNT(DISTINCT c.CustomerID) AS DistinctCustomers,
       COUNT(DISTINCT c.Country) AS DistinctCountries
FROM Employees AS e
LEFT JOIN Orders AS o
  ON o.SalesPersonID = e.EmployeeID
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
LEFT JOIN Customers AS c ON c.CustomerID = o.CustomerID
WHERE e.Department = 'Sales'
GROUP BY e.EmployeeID, e.FirstName, e.LastName
ORDER BY e.EmployeeID;

-- [6.6] Sales staff without qualifying October orders (including zero activity).
SELECT e.EmployeeID, e.FirstName || ' ' || e.LastName AS EmployeeName,
       e.Department
FROM Employees AS e
LEFT JOIN Orders AS o
  ON o.SalesPersonID = e.EmployeeID
 AND o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
 AND o.OrderStatus IN ('Shipped', 'Delivered')
 AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
WHERE e.Department = 'Sales' AND o.OrderID IS NULL
ORDER BY e.EmployeeID;

-- [6.7] INTERSECT: customers with qualifying orders in BOTH periods.
SELECT CustomerID FROM Orders
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND OrderStatus IN ('Shipped', 'Delivered')
  AND ShipDate IS NOT NULL AND ShipDate >= OrderDate
INTERSECT
SELECT CustomerID FROM Orders
WHERE OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
  AND OrderStatus IN ('Shipped', 'Delivered')
  AND ShipDate IS NOT NULL AND ShipDate >= OrderDate
ORDER BY 1;

-- [6.8] EXCEPT: October customers who have NOT returned by Nov 07.
SELECT CustomerID FROM Orders
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND OrderStatus IN ('Shipped', 'Delivered')
  AND ShipDate IS NOT NULL AND ShipDate >= OrderDate
EXCEPT
SELECT CustomerID FROM Orders
WHERE OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
  AND OrderStatus IN ('Shipped', 'Delivered')
  AND ShipDate IS NOT NULL AND ShipDate >= OrderDate
ORDER BY 1;

-- [6.9] EXCEPT reversed: present in Nov snapshot, absent in October.
-- This does NOT prove they were first-time customers historically.
SELECT CustomerID FROM Orders
WHERE OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
  AND OrderStatus IN ('Shipped', 'Delivered')
  AND ShipDate IS NOT NULL AND ShipDate >= OrderDate
EXCEPT
SELECT CustomerID FROM Orders
WHERE OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
  AND OrderStatus IN ('Shipped', 'Delivered')
  AND ShipDate IS NOT NULL AND ShipDate >= OrderDate
ORDER BY 1;

-- [6.10] UNION ALL two non-overlapping, qualifying reporting registers.
SELECT * FROM (
    SELECT 'October 2026' AS PeriodLabel, o.OrderID, o.OrderDate, c.CustomerID,
           c.FirstName || ' ' || c.LastName AS CustomerName,
           e.FirstName || ' ' || e.LastName AS EmployeeName, o.Sales
    FROM Orders AS o
    JOIN Customers AS c ON c.CustomerID = o.CustomerID
    JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
    WHERE o.OrderDate BETWEEN '2026-10-01' AND '2026-10-31'
      AND o.OrderStatus IN ('Shipped', 'Delivered')
      AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
    UNION ALL
    SELECT 'November 01–07' AS PeriodLabel, o.OrderID, o.OrderDate, c.CustomerID,
           c.FirstName || ' ' || c.LastName AS CustomerName,
           e.FirstName || ' ' || e.LastName AS EmployeeName, o.Sales
    FROM Orders AS o
    JOIN Customers AS c ON c.CustomerID = o.CustomerID
    JOIN Employees AS e ON e.EmployeeID = o.SalesPersonID
    WHERE o.OrderDate BETWEEN '2026-11-01' AND '2026-11-07'
      AND o.OrderStatus IN ('Shipped', 'Delivered')
      AND o.ShipDate IS NOT NULL AND o.ShipDate >= o.OrderDate
)
ORDER BY OrderDate, OrderID;

-- Filter explanation (6.7): Ayla (CustomerID 1) has qualifying orders
-- 201/209 in October and 216 in November, so her ID appears in both sets.
-- JOIN explanation (6.2): Nina Stone has no matching qualifying October order,
-- but LEFT JOIN keeps employee 15 with zero orders, quantity and Sales.
