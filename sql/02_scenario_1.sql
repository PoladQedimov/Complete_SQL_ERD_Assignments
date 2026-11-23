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
