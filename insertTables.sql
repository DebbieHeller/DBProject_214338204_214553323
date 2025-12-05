-- Customers
INSERT INTO Customers VALUES (1, 'Avi', 'Cohen', '0501234567', 'avi@gmail.com', DATE '2023-01-01');
INSERT INTO Customers VALUES (2, 'David', 'Levi', '0529876543', 'david@gmail.com', DATE '2023-02-14');
INSERT INTO Customers VALUES (3, 'Moshe', 'Sharabi', '0541112222', 'moshe@gmail.com', DATE '2023-03-10');

-- Employees
INSERT INTO Employees VALUES (1, 'Yossi', 'Katz', 'Baker', DATE '2022-01-10');
INSERT INTO Employees VALUES (2, 'Arik', 'Ben Harush', 'Cashier', DATE '2021-06-20');
INSERT INTO Employees VALUES (3, 'Nir', 'Azoulay', 'Delivery', DATE '2023-05-01');

-- Categories
INSERT INTO Categories VALUES (1, 'Bread');
INSERT INTO Categories VALUES (2, 'Cakes');
INSERT INTO Categories VALUES (3, 'Pastries');

-- Products
INSERT INTO Products VALUES (1, 'Baguette', 1, 12.00, 'Y');
INSERT INTO Products VALUES (2, 'Chocolate Cake', 2, 45.00, 'Y');
INSERT INTO Products VALUES (3, 'Croissant', 3, 9.00, 'Y');

-- Orders
INSERT INTO Orders VALUES (1, 1, 1, DATE '2023-10-10', 'Preparing');
INSERT INTO Orders VALUES (2, 2, 2, DATE '2023-10-11', 'Completed');
INSERT INTO Orders VALUES (3, 3, 3, DATE '2023-10-12', 'New');

-- OrderItems
INSERT INTO OrderItems VALUES (1, 1, 2, 12.00);
INSERT INTO OrderItems VALUES (1, 3, 4, 9.00);
INSERT INTO OrderItems VALUES (2, 2, 1, 45.00);
