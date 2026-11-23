# Real SQL query results / Faktiki SQL nəticələri

> **DBMS:** SQLite 3. Nəticələr 24 sifarişlik orijinal verilənlər üzərində hesablanıb.
> **İstisna:** 2.5–2.9 müvəqqəti test qeydləri ilə icra edilir, sonra geri qaytarılır.
> 3.8–3.10 test məhsulu və `StockQuantity` sütunu da sonunda geri qaytarılır.
> `NULL` — boş mətn deyil, SQL NULL dəyəridir.

## Basic SQL / Əsas SQL

### Task B01

*Bu tapşırıqda bir neçə yoxlama sorğusu var; hamısının nəticəsi göstərilir.*

**Yoxlama sorğusu 1:**

| CustomerID | FirstName | LastName | Country | Score |
| --- | --- | --- | --- | --- |
| 1 | Ayla | Karimova | Azerbaijan | 720 |
| 2 | John | Miller | USA | 450 |
| 3 | Emma | Schmidt | Germany | 860 |
| 4 | Sara | Martin | France | 280 |
| 5 | Lukas | Weber | Germany | 550 |
| 6 | Noah | Adams | USA | 610 |
| 7 | Lea | Fischer | Germany | 680 |
| 8 | Sofia | Rossi | Italy | 700 |
| 9 | Ali | Hasanov | Azerbaijan | 330 |


**Yoxlama sorğusu 2:**

| FirstName | LastName | Country |
| --- | --- | --- |
| Ayla | Karimova | Azerbaijan |
| John | Miller | USA |
| Emma | Schmidt | Germany |
| Sara | Martin | France |
| Lukas | Weber | Germany |
| Noah | Adams | USA |
| Lea | Fischer | Germany |
| Sofia | Rossi | Italy |
| Ali | Hasanov | Azerbaijan |


### Task B02

| CustomerID | FirstName | LastName | Country |
| --- | --- | --- | --- |
| 3 | Emma | Schmidt | Germany |
| 5 | Lukas | Weber | Germany |
| 7 | Lea | Fischer | Germany |


### Task B03

| CustomerID | FirstName | LastName | Country | Score |
| --- | --- | --- | --- | --- |
| 3 | Emma | Schmidt | Germany | 860 |
| 5 | Lukas | Weber | Germany | 550 |
| 7 | Lea | Fischer | Germany | 680 |


### Task B04

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 103 | Laptop | Electronics | 850 |
| 105 | Smart Phone | Electronics | 420 |
| 106 | Standing Desk | Furniture | 380 |
| 102 | Office Chair | Furniture | 230 |
| 108 | Desk Lamp | Furniture | 65 |
| 101 | Wireless Mouse | Electronics | 55 |
| 107 | USB Hub | Electronics | 45 |
| 104 | Notebook | Stationery | 12 |


### Task B05

| Product | Price |
| --- | --- |
| Wireless Mouse | 55 |
| Office Chair | 230 |
| Desk Lamp | 65 |


### Task B06

| Product | Category |
| --- | --- |
| Smart Phone | Electronics |


### Task B07

| Category |
| --- |
| Electronics |
| Furniture |
| Stationery |


### Task B08

| OrderID | FirstName | LastName |
| --- | --- | --- |
| 201 | Ayla | Karimova |
| 202 | Emma | Schmidt |
| 203 | John | Miller |
| 204 | Lukas | Weber |
| 205 | Emma | Schmidt |
| 206 | John | Miller |
| 207 | Noah | Adams |
| 208 | Sara | Martin |
| 209 | Ayla | Karimova |
| 210 | Noah | Adams |
| 211 | Lukas | Weber |
| 212 | Emma | Schmidt |
| 213 | John | Miller |
| 214 | Sofia | Rossi |
| 215 | Lukas | Weber |
| 216 | Ayla | Karimova |
| 217 | Lea | Fischer |
| 218 | Noah | Adams |
| 219 | Emma | Schmidt |
| 220 | John | Miller |
| 221 | Noah | Adams |
| 222 | Sara | Martin |
| 223 | John | Miller |
| 224 | Emma | Schmidt |


### Task B09

| OrderStatus | OrderCount | TotalSales |
| --- | --- | --- |
| Delivered | 11 | 11585 |
| Shipped | 6 | 2340 |
| Pending | 6 | 2090 |
| Cancelled | 1 | 1700 |


### Task B10

*Bu tapşırıqda bir neçə yoxlama sorğusu var; hamısının nəticəsi göstərilir.*

**Yoxlama sorğusu 1:**

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 999 | Practice Product | Electronics | 20 |


**Yoxlama sorğusu 2:**

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 999 | Practice Product | Electronics | 25 |


**Yoxlama sorğusu 3:**

*Nəticə: 0 sətir (sorğuya uyğun qeyd yoxdur).*


## Scenario 1 — Customer loyalty

### Task 1.1

| FirstName | LastName | Country | Score |
| --- | --- | --- | --- |
| Emma | Schmidt | Germany | 860 |
| Ayla | Karimova | Azerbaijan | 720 |
| Sofia | Rossi | Italy | 700 |
| Lea | Fischer | Germany | 680 |
| Noah | Adams | USA | 610 |
| Lukas | Weber | Germany | 550 |


### Task 1.2

| FirstName | LastName | Country | Score |
| --- | --- | --- | --- |
| John | Miller | USA | 450 |
| Emma | Schmidt | Germany | 860 |
| Lukas | Weber | Germany | 550 |
| Noah | Adams | USA | 610 |
| Lea | Fischer | Germany | 680 |


### Task 1.3

| CustomerName | OrderID | OrderDate | Sales |
| --- | --- | --- | --- |
| Ayla Karimova | 201 | 2026-10-04 | 110 |
| Emma Schmidt | 202 | 2026-10-08 | 850 |
| John Miller | 203 | 2026-10-12 | 230 |
| Lukas Weber | 204 | 2026-10-15 | 420 |
| Emma Schmidt | 205 | 2026-10-20 | 6800 |
| John Miller | 206 | 2026-10-21 | 1260 |
| Noah Adams | 207 | 2026-10-22 | 920 |
| Sara Martin | 208 | 2026-10-23 | 110 |
| Ayla Karimova | 209 | 2026-10-24 | 760 |
| Noah Adams | 210 | 2026-10-25 | 1700 |
| Lukas Weber | 211 | 2026-10-26 | 120 |
| Emma Schmidt | 212 | 2026-10-27 | 840 |
| John Miller | 213 | 2026-10-28 | 135 |
| Sofia Rossi | 214 | 2026-10-29 | 850 |
| Lukas Weber | 215 | 2026-10-30 | 380 |
| Ayla Karimova | 216 | 2026-11-02 | 55 |
| Lea Fischer | 217 | 2026-11-03 | 230 |
| Noah Adams | 218 | 2026-11-04 | 420 |
| Emma Schmidt | 219 | 2026-11-05 | 850 |
| John Miller | 220 | 2026-11-06 | 60 |
| Noah Adams | 221 | 2026-10-28 | 45 |
| Sara Martin | 222 | 2026-10-31 | 230 |
| John Miller | 223 | 2026-10-29 | 230 |
| Emma Schmidt | 224 | 2026-11-02 | 110 |


### Task 1.4

| CustomerID | FirstName | LastName | Country |
| --- | --- | --- | --- |
| 9 | Ali | Hasanov | Azerbaijan |


### Task 1.5

| CustomerID | CustomerName | TotalSales |
| --- | --- | --- |
| 3 | Emma Schmidt | 9450 |
| 6 | Noah Adams | 3085 |
| 2 | John Miller | 1915 |
| 1 | Ayla Karimova | 925 |
| 5 | Lukas Weber | 920 |
| 8 | Sofia Rossi | 850 |
| 4 | Sara Martin | 340 |
| 7 | Lea Fischer | 230 |


### Task 1.6

| CustomerID | CustomerName | TotalSales |
| --- | --- | --- |
| 3 | Emma Schmidt | 9450 |
| 6 | Noah Adams | 3085 |
| 2 | John Miller | 1915 |


### Task 1.7

| CustomerID | CustomerName | Country | TotalSales |
| --- | --- | --- | --- |
| 3 | Emma Schmidt | Germany | 9450 |
| 6 | Noah Adams | USA | 3085 |
| 2 | John Miller | USA | 1915 |
| 1 | Ayla Karimova | Azerbaijan | 925 |
| 5 | Lukas Weber | Germany | 920 |


## Scenario 2 — Orders and delivery

### Task 2.1

| OrderID | CustomerID | OrderDate | ShipDate | OrderStatus |
| --- | --- | --- | --- | --- |
| 201 | 1 | 2026-10-04 | 2026-10-06 | Delivered |
| 202 | 3 | 2026-10-08 | 2026-10-18 | Shipped |
| 203 | 2 | 2026-10-12 | `NULL` | Pending |
| 204 | 5 | 2026-10-15 | 2026-10-19 | Delivered |
| 205 | 3 | 2026-10-20 | 2026-10-22 | Delivered |
| 206 | 2 | 2026-10-21 | 2026-10-23 | Delivered |
| 207 | 6 | 2026-10-22 | 2026-10-24 | Delivered |
| 208 | 4 | 2026-10-23 | `NULL` | Pending |
| 209 | 1 | 2026-10-24 | 2026-10-27 | Delivered |
| 210 | 6 | 2026-10-25 | `NULL` | Cancelled |
| 211 | 5 | 2026-10-26 | 2026-10-28 | Delivered |
| 212 | 3 | 2026-10-27 | `NULL` | Pending |
| 213 | 2 | 2026-10-28 | 2026-10-30 | Shipped |
| 221 | 6 | 2026-10-28 | `NULL` | Shipped |
| 214 | 8 | 2026-10-29 | 2026-11-01 | Delivered |
| 223 | 2 | 2026-10-29 | 2026-10-31 | Delivered |
| 215 | 5 | 2026-10-30 | `NULL` | Pending |
| 222 | 4 | 2026-10-31 | 2026-10-30 | Shipped |


### Task 2.2

| OrderID | CustomerID | OrderDate | ShipDate | OrderStatus |
| --- | --- | --- | --- | --- |
| 203 | 2 | 2026-10-12 | `NULL` | Pending |
| 208 | 4 | 2026-10-23 | `NULL` | Pending |
| 212 | 3 | 2026-10-27 | `NULL` | Pending |
| 215 | 5 | 2026-10-30 | `NULL` | Pending |
| 224 | 3 | 2026-11-02 | `NULL` | Pending |
| 218 | 6 | 2026-11-04 | `NULL` | Pending |


### Task 2.3

| OrderID | CustomerName | OrderDate | ShipDate |
| --- | --- | --- | --- |
| 202 | Emma Schmidt | 2026-10-08 | 2026-10-18 |


### Task 2.4

| CustomerID | FirstName | LastName | Country |
| --- | --- | --- | --- |
| 3 | Emma | Schmidt | Germany |


### Task 2.5

*Bu tapşırıqda bir neçə yoxlama sorğusu var; hamısının nəticəsi göstərilir.*

**Yoxlama sorğusu 1:**

| OrderID | OrderStatus | ShipDate |
| --- | --- | --- |
| 105 | Pending | `NULL` |


**Yoxlama sorğusu 2:**

| OrderID | OrderStatus | ShipDate |
| --- | --- | --- |
| 105 | Shipped | 2026-11-05 |


### Task 2.6

*Bu tapşırıqda bir neçə yoxlama sorğusu var; hamısının nəticəsi göstərilir.*

**Yoxlama sorğusu 1:**

| OrderID | ShipAddress |
| --- | --- |
| 110 | `NULL` |


**Yoxlama sorğusu 2:**

| OrderID | ShipAddress |
| --- | --- |
| 110 | 45 Main Street, Baku |


### Task 2.7

*Bu tapşırıqda bir neçə yoxlama sorğusu var; hamısının nəticəsi göstərilir.*

**Yoxlama sorğusu 1:**

| OrderID | OrderStatus |
| --- | --- |
| 999 | Pending |


**Yoxlama sorğusu 2:**

*Nəticə: 0 sətir (sorğuya uyğun qeyd yoxdur).*


### Task 2.8

| OrderStatus | OrderCount |
| --- | --- |
| Cancelled | 1 |
| Delivered | 11 |
| Pending | 7 |
| Shipped | 7 |


### Task 2.9

| OrderID | CustomerName | OrderDate | ShipDate | OrderStatus |
| --- | --- | --- | --- | --- |
| 203 | John Miller | 2026-10-12 | `NULL` | Pending |
| 208 | Sara Martin | 2026-10-23 | `NULL` | Pending |
| 210 | Noah Adams | 2026-10-25 | `NULL` | Cancelled |
| 212 | Emma Schmidt | 2026-10-27 | `NULL` | Pending |
| 221 | Noah Adams | 2026-10-28 | `NULL` | Shipped |
| 215 | Lukas Weber | 2026-10-30 | `NULL` | Pending |
| 224 | Emma Schmidt | 2026-11-02 | `NULL` | Pending |
| 110 | John Miller | 2026-11-04 | `NULL` | Pending |
| 218 | Noah Adams | 2026-11-04 | `NULL` | Pending |


## Scenario 3 — Products and employees

### Task 3.1

| Product | Category | Price |
| --- | --- | --- |
| Wireless Mouse | Electronics | 55 |
| Desk Lamp | Furniture | 65 |
| Office Chair | Furniture | 230 |


### Task 3.2

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 103 | Laptop | Electronics | 850 |


### Task 3.3

| Product | Category | Quantity | Sales |
| --- | --- | --- | --- |
| Wireless Mouse | Electronics | 2 | 110 |
| Laptop | Electronics | 1 | 850 |
| Office Chair | Furniture | 1 | 230 |
| Smart Phone | Electronics | 1 | 420 |
| Laptop | Electronics | 8 | 6800 |
| Smart Phone | Electronics | 3 | 1260 |
| Office Chair | Furniture | 4 | 920 |
| Wireless Mouse | Electronics | 2 | 110 |
| Standing Desk | Furniture | 2 | 760 |
| Laptop | Electronics | 2 | 1700 |
| Notebook | Stationery | 10 | 120 |
| Smart Phone | Electronics | 2 | 840 |
| USB Hub | Electronics | 3 | 135 |
| Laptop | Electronics | 1 | 850 |
| Standing Desk | Furniture | 1 | 380 |
| Wireless Mouse | Electronics | 1 | 55 |
| Office Chair | Furniture | 1 | 230 |
| Smart Phone | Electronics | 1 | 420 |
| Laptop | Electronics | 1 | 850 |
| Notebook | Stationery | 5 | 60 |
| USB Hub | Electronics | 1 | 45 |
| Office Chair | Furniture | 1 | 230 |
| Office Chair | Furniture | 1 | 230 |
| Wireless Mouse | Electronics | 2 | 110 |


### Task 3.4

| ProductID | Product | TotalQuantity |
| --- | --- | --- |
| 104 | Notebook | 15 |
| 103 | Laptop | 13 |
| 102 | Office Chair | 8 |
| 101 | Wireless Mouse | 7 |
| 105 | Smart Phone | 7 |


### Task 3.5

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 108 | Desk Lamp | Furniture | 65 |


### Task 3.6

| EmployeeID | EmployeeName | Department | TotalSales |
| --- | --- | --- | --- |
| 12 | Maya Brown | Sales | 10250 |
| 14 | Omar Ali | Sales | 4925 |
| 11 | David Lee | Sales | 2540 |


### Task 3.7

| EmployeeID | EmployeeName | TotalSales |
| --- | --- | --- |
| 12 | Maya Brown | 10250 |


### Task 3.8

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 501 | Wireless Keyboard | Electronics | 75 |


### Task 3.9

| ProductID | Product | Price |
| --- | --- | --- |
| 501 | Wireless Keyboard | 90 |


### Task 3.10

| cid | name | type | notnull | dflt_value | pk |
| --- | --- | --- | --- | --- | --- |
| 0 | ProductID | INTEGER | 0 | `NULL` | 1 |
| 1 | Product | VARCHAR(100) | 1 | `NULL` | 0 |
| 2 | Category | VARCHAR(50) | 1 | `NULL` | 0 |
| 3 | Price | DECIMAL(10,2) | 1 | `NULL` | 0 |
| 4 | StockQuantity | INTEGER | 0 | `NULL` | 0 |


### Task 3.11

| FirstName | LastName |
| --- | --- |
| Alex | Green |
| Ali | Hasanov |
| Ayla | Karimova |
| David | Lee |
| Emma | Schmidt |
| John | Miller |
| Lea | Fischer |
| Lukas | Weber |
| Maya | Brown |
| Nina | Stone |
| Noah | Adams |
| Omar | Ali |
| Sara | Martin |
| Sofia | Rossi |


### Task 3.12

| Category | TotalQuantity | TotalSales |
| --- | --- | --- |
| Electronics | 31 | 14555 |
| Furniture | 11 | 2980 |


## Scenario 4 — Targeted campaigns

### Task 4.1

| OrderID | OrderDate | CustomerID | CustomerName | Country | Product | Category | EmployeeName | Quantity | Sales |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 202 | 2026-10-08 | 3 | Emma Schmidt | Germany | Laptop | Electronics | Maya Brown | 1 | 850 |
| 204 | 2026-10-15 | 5 | Lukas Weber | Germany | Smart Phone | Electronics | Maya Brown | 1 | 420 |
| 205 | 2026-10-20 | 3 | Emma Schmidt | Germany | Laptop | Electronics | Maya Brown | 8 | 6800 |
| 211 | 2026-10-26 | 5 | Lukas Weber | Germany | Notebook | Stationery | David Lee | 10 | 120 |
| 206 | 2026-10-21 | 2 | John Miller | USA | Smart Phone | Electronics | David Lee | 3 | 1260 |
| 207 | 2026-10-22 | 6 | Noah Adams | USA | Office Chair | Furniture | Omar Ali | 4 | 920 |
| 213 | 2026-10-28 | 2 | John Miller | USA | USB Hub | Electronics | David Lee | 3 | 135 |
| 223 | 2026-10-29 | 2 | John Miller | USA | Office Chair | Furniture | David Lee | 1 | 230 |


### Task 4.2

| OrderID | CustomerID | CustomerName | Country | Score | Product | Sales |
| --- | --- | --- | --- | --- | --- | --- |
| 202 | 3 | Emma Schmidt | Germany | 860 | Laptop | 850 |
| 204 | 5 | Lukas Weber | Germany | 550 | Smart Phone | 420 |
| 205 | 3 | Emma Schmidt | Germany | 860 | Laptop | 6800 |
| 206 | 2 | John Miller | USA | 450 | Smart Phone | 1260 |


### Task 4.3

| ProductID | Product | Category | Price |
| --- | --- | --- | --- |
| 107 | USB Hub | Electronics | 45 |
| 101 | Wireless Mouse | Electronics | 55 |


### Task 4.4

| CustomerID | FirstName | LastName | Country | Score |
| --- | --- | --- | --- | --- |
| 3 | Emma | Schmidt | Germany | 860 |
| 5 | Lukas | Weber | Germany | 550 |


### Task 4.5

| CustomerID | CustomerName | OrderCount | TotalQuantity | TotalSales |
| --- | --- | --- | --- | --- |
| 3 | Emma Schmidt | 2 | 9 | 7650 |
| 2 | John Miller | 3 | 7 | 1625 |


### Task 4.6

| Country | Category | OrderCount | TotalQuantity | TotalSales |
| --- | --- | --- | --- | --- |
| Germany | Electronics | 3 | 10 | 8070 |
| USA | Electronics | 2 | 6 | 1395 |
| USA | Furniture | 2 | 5 | 1150 |


### Task 4.7

| CustomerID | CustomerName | Country | Score |
| --- | --- | --- | --- |
| 4 | Sara Martin | France | 280 |
| 7 | Lea Fischer | Germany | 680 |


### Task 4.8

| CustomerID |
| --- |
| 2 |


### Task 4.9

| CustomerID |
| --- |
| 2 |
| 3 |
| 5 |
| 6 |


### Task 4.10

| CustomerID |
| --- |
| 3 |
| 5 |


## Scenario 5 — Fulfilment exceptions

### Task 5.1

| OrderID | OrderDate | CustomerName | Country | Product | Quantity | Sales | EmployeeName | ShipAddress |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 203 | 2026-10-12 | John Miller | USA | Office Chair | 1 | 230 | David Lee | `NULL` |
| 208 | 2026-10-23 | Sara Martin | France | Wireless Mouse | 2 | 110 | David Lee | `NULL` |
| 212 | 2026-10-27 | Emma Schmidt | Germany | Smart Phone | 2 | 840 | Maya Brown | `NULL` |
| 215 | 2026-10-30 | Lukas Weber | Germany | Standing Desk | 1 | 380 | Maya Brown | 16 Park Rd, Munich |
| 224 | 2026-11-02 | Emma Schmidt | Germany | Wireless Mouse | 2 | 110 | Maya Brown | 22 Oak St, Berlin |
| 218 | 2026-11-04 | Noah Adams | USA | Smart Phone | 1 | 420 | Omar Ali | 31 Oak St, Boston |


### Task 5.2

| OrderID | CustomerName | OrderDate | Product | EmployeeName | Sales |
| --- | --- | --- | --- | --- | --- |
| 203 | John Miller | 2026-10-12 | Office Chair | David Lee | 230 |
| 208 | Sara Martin | 2026-10-23 | Wireless Mouse | David Lee | 110 |
| 212 | Emma Schmidt | 2026-10-27 | Smart Phone | Maya Brown | 840 |
| 215 | Lukas Weber | 2026-10-30 | Standing Desk | Maya Brown | 380 |


### Task 5.3

| OrderID | CustomerID | CustomerName | EmployeeName | ShipAddress |
| --- | --- | --- | --- | --- |
| 203 | 2 | John Miller | David Lee | `NULL` |
| 208 | 4 | Sara Martin | David Lee | `NULL` |
| 212 | 3 | Emma Schmidt | Maya Brown | `NULL` |


### Task 5.4

| OrderID | CustomerName | ShipAddress | BillAddress | OrderStatus |
| --- | --- | --- | --- | --- |
| 206 | John Miller | 45 Main St, New York | 9 Pine St, Boston | Delivered |


### Task 5.5

| OrderID | OrderStatus | OrderDate | ShipDate | CustomerName | EmployeeName |
| --- | --- | --- | --- | --- | --- |
| 221 | Shipped | 2026-10-28 | `NULL` | Noah Adams | Omar Ali |
| 222 | Shipped | 2026-10-31 | 2026-10-30 | Sara Martin | David Lee |


### Task 5.6

| OrderID | CustomerName | Product | OrderDate | ShipDate | DaysToShip |
| --- | --- | --- | --- | --- | --- |
| 202 | Emma Schmidt | Laptop | 2026-10-08 | 2026-10-18 | 10 |


### Task 5.7

| EmployeeID | EmployeeName | PendingOrderCount | PendingSales |
| --- | --- | --- | --- |
| 11 | David Lee | 2 | 340 |
| 12 | Maya Brown | 3 | 1330 |
| 14 | Omar Ali | 1 | 420 |
| 15 | Nina Stone | 0 | 0 |


### Task 5.8

| CustomerID | CustomerName | PendingOrderCount | PendingSales |
| --- | --- | --- | --- |
| 3 | Emma Schmidt | 2 | 950 |


### Task 5.9

| OrderID | CustomerName | Country | Product | Sales | OrderStatus | OrderDate | ShipDate |
| --- | --- | --- | --- | --- | --- | --- | --- |
| 202 | Emma Schmidt | Germany | Laptop | 850 | Shipped | 2026-10-08 | 2026-10-18 |
| 212 | Emma Schmidt | Germany | Smart Phone | 840 | Pending | 2026-10-27 | `NULL` |


### Task 5.10

| OrderID | CustomerName | Country | Product | Quantity | ShipAddress | EmployeeName |
| --- | --- | --- | --- | --- | --- | --- |
| 215 | Lukas Weber | Germany | Standing Desk | 1 | 16 Park Rd, Munich | Maya Brown |
| 224 | Emma Schmidt | Germany | Wireless Mouse | 2 | 22 Oak St, Berlin | Maya Brown |
| 218 | Noah Adams | USA | Smart Phone | 1 | 31 Oak St, Boston | Omar Ali |


## Scenario 6 — Sales team and retention

### Task 6.1

| EmployeeID | EmployeeName | Department | ManagerID | ManagerName |
| --- | --- | --- | --- | --- |
| 11 | David Lee | Sales | 12 | Maya Brown |
| 12 | Maya Brown | Sales | `NULL` | `NULL` |
| 13 | Alex Green | Support | 12 | Maya Brown |
| 14 | Omar Ali | Sales | 12 | Maya Brown |
| 15 | Nina Stone | Sales | 12 | Maya Brown |


### Task 6.2

| EmployeeID | EmployeeName | OrderCount | TotalQuantity | TotalSales |
| --- | --- | --- | --- | --- |
| 12 | Maya Brown | 3 | 10 | 8070 |
| 14 | Omar Ali | 3 | 7 | 2530 |
| 11 | David Lee | 5 | 19 | 1855 |
| 15 | Nina Stone | 0 | 0 | 0 |


### Task 6.3

| ManagerID | ManagerName | DirectSalesStaffCount | TeamOrderCount | TeamSales |
| --- | --- | --- | --- | --- |
| 12 | Maya Brown | 3 | 8 | 4385 |


### Task 6.4

| EmployeeID | EmployeeName | OrderCount | TotalSales |
| --- | --- | --- | --- |
| 12 | Maya Brown | 3 | 8070 |
| 14 | Omar Ali | 3 | 2530 |
| 11 | David Lee | 5 | 1855 |


### Task 6.5

| EmployeeID | EmployeeName | DistinctCustomers | DistinctCountries |
| --- | --- | --- | --- |
| 11 | David Lee | 3 | 3 |
| 12 | Maya Brown | 2 | 1 |
| 14 | Omar Ali | 3 | 3 |
| 15 | Nina Stone | 0 | 0 |


### Task 6.6

| EmployeeID | EmployeeName | Department |
| --- | --- | --- |
| 15 | Nina Stone | Sales |


### Task 6.7

| CustomerID |
| --- |
| 1 |
| 2 |
| 3 |


### Task 6.8

| CustomerID |
| --- |
| 5 |
| 6 |
| 8 |


### Task 6.9

| CustomerID |
| --- |
| 7 |


### Task 6.10

| PeriodLabel | OrderID | OrderDate | CustomerID | CustomerName | EmployeeName | Sales |
| --- | --- | --- | --- | --- | --- | --- |
| October 2026 | 201 | 2026-10-04 | 1 | Ayla Karimova | David Lee | 110 |
| October 2026 | 202 | 2026-10-08 | 3 | Emma Schmidt | Maya Brown | 850 |
| October 2026 | 204 | 2026-10-15 | 5 | Lukas Weber | Maya Brown | 420 |
| October 2026 | 205 | 2026-10-20 | 3 | Emma Schmidt | Maya Brown | 6800 |
| October 2026 | 206 | 2026-10-21 | 2 | John Miller | David Lee | 1260 |
| October 2026 | 207 | 2026-10-22 | 6 | Noah Adams | Omar Ali | 920 |
| October 2026 | 209 | 2026-10-24 | 1 | Ayla Karimova | Omar Ali | 760 |
| October 2026 | 211 | 2026-10-26 | 5 | Lukas Weber | David Lee | 120 |
| October 2026 | 213 | 2026-10-28 | 2 | John Miller | David Lee | 135 |
| October 2026 | 214 | 2026-10-29 | 8 | Sofia Rossi | Omar Ali | 850 |
| October 2026 | 223 | 2026-10-29 | 2 | John Miller | David Lee | 230 |
| November 01–07 | 216 | 2026-11-02 | 1 | Ayla Karimova | David Lee | 55 |
| November 01–07 | 217 | 2026-11-03 | 7 | Lea Fischer | Omar Ali | 230 |
| November 01–07 | 219 | 2026-11-05 | 3 | Emma Schmidt | Maya Brown | 850 |
| November 01–07 | 220 | 2026-11-06 | 2 | John Miller | David Lee | 60 |

