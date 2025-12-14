-- Customers
INSERT INTO Customers VALUES (1, 'Avi', 'Cohen', '0501234567', 'avi@gmail.com', DATE '2023-01-01');
INSERT INTO Customers VALUES (2, 'David', 'Levi', '0529876543', 'david@gmail.com', DATE '2023-02-14');
INSERT INTO Customers VALUES (3, 'Moshe', 'Sharabi', '0541112222', 'moshe@gmail.com', DATE '2023-03-10');
INSERT INTO Customers VALUES (4, 'Roni', 'Peretz', '0534445566', 'roni@gmail.com', DATE '2023-04-05');
INSERT INTO Customers VALUES (5, 'Dana', 'Mizrahi', '0587778899', 'dana@gmail.com', DATE '2023-05-18');


-- Employees
INSERT INTO Employees VALUES (1, 'Yossi', 'Katz', 'Baker', DATE '2022-01-10');
INSERT INTO Employees VALUES (2, 'Arik', 'Ben Harush', 'Cashier', DATE '2021-06-20');
INSERT INTO Employees VALUES (3, 'Nir', 'Azoulay', 'Delivery', DATE '2023-05-01');
INSERT INTO Employees VALUES (4, 'Itai', 'Mor', 'Manager', DATE '2020-03-15');
INSERT INTO Employees VALUES (5, 'Shai', 'Gold', 'Cleaner', DATE '2022-11-01');


-- Categories
INSERT INTO Categories VALUES (1, 'Bread');
INSERT INTO Categories VALUES (2, 'Cakes');
INSERT INTO Categories VALUES (3, 'Pastries');
INSERT INTO Categories VALUES (4, 'Cookies');
INSERT INTO Categories VALUES (5, 'Drinks');


-- Products
INSERT INTO Products VALUES (1, 'Baguette', 1, 12.00, 'Y');
INSERT INTO Products VALUES (2, 'Chocolate Cake', 2, 45.00, 'Y');
INSERT INTO Products VALUES (3, 'Croissant', 3, 9.00, 'Y');
INSERT INTO Products VALUES (4, 'Chocolate Cookie', 4, 6.00, 'Y');
INSERT INTO Products VALUES (5, 'Iced Coffee', 5, 10.00, 'Y');


-- Orders
INSERT INTO Orders VALUES (1, 1, 1, DATE '2023-10-10', 'Preparing');
INSERT INTO Orders VALUES (2, 2, 2, DATE '2023-10-11', 'Completed');
INSERT INTO Orders VALUES (3, 3, 3, DATE '2023-10-12', 'New');
INSERT INTO Orders VALUES (4, 4, 4, DATE '2023-10-13', 'Preparing');
INSERT INTO Orders VALUES (5, 5, 5, DATE '2023-10-14', 'New');
INSERT INTO Orders VALUES (6, 4, 2, DATE '2023-10-15', 'Completed');
INSERT INTO Orders VALUES (7, 5, 3, DATE '2023-10-16', 'Preparing');
INSERT INTO Orders VALUES (8, 4, 1, DATE '2022-12-20', 'Completed');
INSERT INTO Orders VALUES (9, 5, 2, DATE '2021-11-05', 'Completed');



-- OrderItems
INSERT INTO OrderItems VALUES (1, 1, 2, 12.00);
INSERT INTO OrderItems VALUES (2, 2, 1, 45.00);
INSERT INTO OrderItems VALUES (3, 1, 1, 12.00);
INSERT INTO OrderItems VALUES (4, 4, 3, 6.00);
INSERT INTO OrderItems VALUES (5, 5, 2, 10.00);
INSERT INTO OrderItems VALUES (6, 2, 1, 45.00);
INSERT INTO OrderItems VALUES (7, 3, 2, 9.00);
INSERT INTO OrderItems VALUES (8, 1, 3, 12.00);
INSERT INTO OrderItems VALUES (9, 4, 2, 6.00);
INSERT INTO OrderItems VALUES (10, 5, 1, 10.00);
