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
