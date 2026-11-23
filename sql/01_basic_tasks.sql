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
