
/* =========================
   8 שאילתות SELECT
   ========================= */

/* 1. סיכום הזמנות לכל לקוח לפי שנה */
-- SELECT
--     c.CustomerID,
--     c.FirstName,
--     c.LastName,
--     EXTRACT(YEAR FROM o.OrderDate) AS OrderYear,
--     COUNT(o.OrderID) AS TotalOrders
-- FROM Customers c
-- JOIN Orders o ON c.CustomerID = o.CustomerID
-- GROUP BY c.CustomerID, c.FirstName, c.LastName, EXTRACT(YEAR FROM o.OrderDate)
-- ORDER BY OrderYear DESC;

/* 2. סך הכנסות מכל מוצר */
 SELECT
   p.ProductID,
   p.ProductName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
FROM Products p
 JOIN OrderItems oi ON p.ProductID = oi.ProductID
 GROUP BY p.ProductID, p.ProductName
ORDER BY TotalRevenue DESC;

/* 3. עובדים שטיפלו ביותר מ-10 הזמנות */
SELECT
    e.EmployeeID,
    e.FirstName,
    e.LastName,
    COUNT(o.OrderID) AS OrdersHandled
FROM Employees e
JOIN Orders o ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName, e.LastName
HAVING COUNT(o.OrderID) > 10;

/* 4. מספר הזמנות לפי חודש ושנה */
SELECT
    EXTRACT(YEAR FROM OrderDate) AS Year,
    EXTRACT(MONTH FROM OrderDate) AS Month,
    COUNT(OrderID) AS OrdersCount
FROM Orders
GROUP BY EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate)
ORDER BY Year, Month;

/* 5. מספר הזמנות לכל לקוח, כולל אלו שלא ביצעו כלל */
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName
ORDER BY TotalOrders ASC;


/* 6. מוצרים שלא הוזמנו מעולם */
SELECT
    p.ProductID,
    p.ProductName,
    p.Price
FROM Products p
LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
WHERE oi.ProductID IS NULL;

/* 7. ממוצע מחיר להזמנה לפי סטטוס */
SELECT
    o.Status,
    AVG(oi.Quantity * oi.UnitPrice) AS AvgOrderValue
FROM Orders o
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY o.Status;

/* 8. לקוחות עם סכום קנייה כולל מעל 500 */
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderItems oi ON o.OrderID = oi.OrderID
GROUP BY c.CustomerID, c.FirstName, c.LastName
HAVING SUM(oi.Quantity * oi.UnitPrice) > 500;


/* =========================
   3 שאילתות UPDATE
   ========================= */

/* 1. עדכון סטטוס להזמנות ישנות משנה */
UPDATE Orders
SET Status = 'ARCHIVED'
WHERE OrderDate < ADD_MONTHS(SYSDATE, -12);

/* 2. העלאת מחיר ב-10% למוצרים בקטגוריה מסוימת */
UPDATE Products
SET Price = Price * 1.10
WHERE CategoryID = 1;

UPDATE Customers
SET LastName = 'Levi'
WHERE CustomerID = 3;


-- /* =========================
--    3 שאילתות DELETE
--    ========================= */

DELETE FROM Products
WHERE ProductID NOT IN (
    SELECT DISTINCT ProductID
    FROM OrderItems
);


DELETE FROM Products
WHERE ProductID IN (
    SELECT p.ProductID
    FROM Products p
    LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
    GROUP BY p.ProductID, p.Price
    HAVING COALESCE(SUM(oi.Quantity), 0) < 15 AND p.Price > 50
);

DELETE FROM Customers
WHERE RegistrationDate < '2022-01-01'
  AND LENGTH(Phone) < 10
  AND (Email NOT LIKE '%@%' OR Email LIKE '%test%' OR Email LIKE '%fake%');
