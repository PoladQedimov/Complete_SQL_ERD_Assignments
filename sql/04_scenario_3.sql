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
