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
