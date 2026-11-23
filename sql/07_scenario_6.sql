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
