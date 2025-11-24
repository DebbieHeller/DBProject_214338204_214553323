-- Customers
INSERT INTO Customers VALUES (1,'Alice','0501234567','Main St 1','2025-01-10');
INSERT INTO Customers VALUES (2,'Bob','0509876543','Second St 5','2025-02-12');
INSERT INTO Customers VALUES (3,'Carol','0505551234','Third St 9','2025-03-05');

-- Products
INSERT INTO Products VALUES (1,'Baguette','Bread',5.00,'2024-12-01');
INSERT INTO Products VALUES (2,'Croissant','Pastry',3.50,'2024-11-15');
INSERT INTO Products VALUES (3,'Sourdough','Bread',6.00,'2024-12-20');

-- Employees
INSERT INTO Employees VALUES (1,'David','Driver','0501112222','2024-10-01');
INSERT INTO Employees VALUES (2,'Emma','Driver','0503334444','2024-11-15');
INSERT INTO Employees VALUES (3,'Frank','Baker','0505556666','2024-09-20');

-- Orders
INSERT INTO Orders VALUES (1,1,'2025-11-20','2025-11-21',15.50);
INSERT INTO Orders VALUES (2,2,'2025-11-21','2025-11-22',9.50);
INSERT INTO Orders VALUES (3,3,'2025-11-22','2025-11-23',11.00);

-- OrderItems
INSERT INTO OrderItems VALUES (1,1,2);
INSERT INTO OrderItems VALUES (1,2,1);
INSERT INTO OrderItems VALUES (2,2,2);

-- Deliveries
INSERT INTO Deliveries VALUES (1,1,1,'Main St 1','2025-11-21','Delivered');
INSERT INTO Deliveries VALUES (2,2,2,'Second St 5','2025-11-22','Pending');
INSERT INTO Deliveries VALUES (3,3,1,'Third St 9','2025-11-23','Pending');
