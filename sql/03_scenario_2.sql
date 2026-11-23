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
