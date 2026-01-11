-- 1. הכנסת תפקידים
INSERT INTO Roles (RoleName, BasicSalary) VALUES
('Manager', 60.00),
('Baker', 45.00),
('Cashier', 33.00),
('Cook', 50.00),
('Cleaner', 35.00);

-- 2. הכנסת עובדים
INSERT INTO Employees (FullName, Phone, HireDate, BirthDate, RoleID) VALUES
('Alice Johnson', '050-111-0001', '2019-06-01', '1994-04-12', 1),
('Ben Cohen', '050-111-0002', '2018-03-15', '1989-09-05', 2),
('David Amir', '050-111-0004', '2021-02-01', '1996-07-30', 3),
('Frank Rose', '050-222-0006', '2023-08-01', '1998-11-03', 4),
('Leo Stern', '050-444-0012', '2023-10-03', '1999-05-14', 2);

-- 3. הכנסת סניפים
INSERT INTO Branches (BranchName, Address, Phone, ManagerID, FoundedDate, AvgCustomersPerMonth) VALUES
('Jerusalem Main', '12 King Street, Jerusalem', '02-555-1001', 1, '2015-05-01', 1200),
('Tel Aviv Center', '45 Market Road, Tel Aviv', '03-666-2002', 2, '2017-09-15', 1800),
('Haifa Port', '9 Sea View Ave, Haifa', '04-777-3003', 3, '2018-11-20', 900),
('Beersheba South', '78 Central Blvd, Beersheba', '08-888-4004', 4, '2016-02-10', 700),
('Eilat Sun', '5 Red Sea St, Eilat', '08-999-5005', 5, '2020-03-01', 1500);

-- 4. קטגוריות מוצרים
INSERT INTO ProductCategories (CategoryName) VALUES
('Breads'),
('Cakes'),
('Pastries'),
('Cookies'),
('Sandwiches');

-- 5. מוצרים
INSERT INTO Products (ProductName, CategoryID, Price, IsAvailable) VALUES
('Sourdough Bread', 1, 18.50, TRUE),
('Chocolate Cake', 2, 85.00, TRUE),
('Butter Croissant', 3, 12.00, TRUE),
('Chocolate Chip Cookies', 4, 25.00, TRUE),
('Tuna Sandwich', 5, 32.00, TRUE);

-- 6. לקוחות
INSERT INTO Customers (FirstName, LastName, Phone, Email, RegistrationDate) VALUES
('John', 'Doe', '054-123-4567', 'john@example.com', '2023-01-15'),
('Jane', 'Smith', '054-987-6543', 'jane@example.com', '2023-02-20'),
('Michael', 'Levi', '052-555-4444', 'mike@mail.com', '2023-03-10'),
('Sarah', 'Cohen', '053-111-2222', 'sarah@mail.com', '2023-04-05'),
('Robert', 'Brown', '050-888-9999', 'rob@example.com', '2023-05-12');

-- 7. הזמנות
INSERT INTO Orders (CustomerID, EmployeeID, BranchID, OrderDate, Status) VALUES
(1, 3, 1, '2024-01-10', 'Completed'),
(2, 3, 2, '2024-01-11', 'Completed'),
(3, 4, 1, '2024-01-12', 'Pending'),
(4, 5, 3, '2024-01-12', 'Shipped'),
(5, 3, 4, '2024-01-13', 'Cancelled');

-- 8. פריטי הזמנה
INSERT INTO OrderItems (OrderID, ProductID, Quantity, UnitPrice) VALUES
(1, 1, 2, 18.50),
(1, 3, 4, 12.00),
(2, 2, 1, 85.00),
(3, 5, 2, 32.00),
(4, 4, 3, 25.00);

-- 9. לו"ז סניפים ומשמרות
INSERT INTO BranchSchedules (BranchID, DayInWeek, OpenAt, CloseAt) VALUES
(1, 'Sunday', '08:00:00', '20:00:00'),
(2, 'Sunday', '08:00:00', '20:00:00'),
(3, 'Monday', '07:30:00', '21:00:00'),
(4, 'Tuesday', '08:00:00', '19:00:00'),
(5, 'Wednesday', '09:00:00', '22:00:00');

INSERT INTO EmployeeShifts (EmployeeID, BranchID, ShiftDate, StartTime, EndTime) VALUES
(1, 1, '2024-01-14', '08:00:00', '16:00:00'),
(2, 2, '2024-01-14', '08:00:00', '16:00:00'),
(3, 1, '2024-01-15', '14:00:00', '22:00:00'),
(4, 3, '2024-01-15', '07:00:00', '15:00:00'),
(5, 4, '2024-01-16', '12:00:00', '20:00:00');