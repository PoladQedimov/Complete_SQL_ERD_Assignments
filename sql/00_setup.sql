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
