
/* =========================
   8 שאילתות SELECT
   ========================= */

/* 1. סיכום הזמנות לכל לקוח לפי שנה */
SELECT
    c.CustomerID,
    c.FirstName,
    c.LastName,
    EXTRACT(YEAR FROM o.OrderDate) AS OrderYear,
    COUNT(o.OrderID) AS TotalOrders
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, EXTRACT(YEAR FROM o.OrderDate)
ORDER BY OrderYear DESC;

/* 2. סך הכנסות מכל מוצר */
-- SELECT
--     p.ProductID,
--     p.ProductName,
--     SUM(oi.Quantity * oi.UnitPrice) AS TotalRevenue
-- FROM Products p
-- JOIN OrderItems oi ON p.ProductID = oi.ProductID
-- GROUP BY p.ProductID, p.ProductName
-- ORDER BY TotalRevenue DESC;

-- /* 3. עובדים שטיפלו ביותר מ-10 הזמנות */
-- SELECT
--     e.EmployeeID,
--     e.FirstName,
--     e.LastName,
--     COUNT(o.OrderID) AS OrdersHandled
-- FROM Employees e
-- JOIN Orders o ON e.EmployeeID = o.EmployeeID
-- GROUP BY e.EmployeeID, e.FirstName, e.LastName
-- HAVING COUNT(o.OrderID) > 10;

-- /* 4. מספר הזמנות לפי חודש ושנה */
-- SELECT
--     EXTRACT(YEAR FROM OrderDate) AS Year,
--     EXTRACT(MONTH FROM OrderDate) AS Month,
--     COUNT(OrderID) AS OrdersCount
-- FROM Orders
-- GROUP BY EXTRACT(YEAR FROM OrderDate), EXTRACT(MONTH FROM OrderDate)
-- ORDER BY Year, Month;

-- /* 5. לקוחות שלא ביצעו הזמנות בכלל */
-- SELECT
--     c.CustomerID,
--     c.FirstName,
--     c.LastName,
--     c.RegistrationDate
-- FROM Customers c
-- LEFT JOIN Orders o ON c.CustomerID = o.CustomerID
-- WHERE o.OrderID IS NULL;

-- /* 6. מוצרים שלא הוזמנו מעולם */
-- SELECT
--     p.ProductID,
--     p.ProductName,
--     p.Price
-- FROM Products p
-- LEFT JOIN OrderItems oi ON p.ProductID = oi.ProductID
-- WHERE oi.ProductID IS NULL;

-- /* 7. ממוצע מחיר להזמנה לפי סטטוס */
-- SELECT
--     o.Status,
--     AVG(oi.Quantity * oi.UnitPrice) AS AvgOrderValue
-- FROM Orders o
-- JOIN OrderItems oi ON o.OrderID = oi.OrderID
-- GROUP BY o.Status;

-- /* 8. לקוחות עם סכום קנייה כולל מעל 500 */
-- SELECT
--     c.CustomerID,
--     c.FirstName,
--     c.LastName,
--     SUM(oi.Quantity * oi.UnitPrice) AS TotalSpent
-- FROM Customers c
-- JOIN Orders o ON c.CustomerID = o.CustomerID
-- JOIN OrderItems oi ON o.OrderID = oi.OrderID
-- GROUP BY c.CustomerID, c.FirstName, c.LastName
-- HAVING SUM(oi.Quantity * oi.UnitPrice) > 500;


-- /* =========================
--    3 שאילתות UPDATE
--    ========================= */

-- /* 1. עדכון סטטוס להזמנות ישנות משנה */
-- UPDATE Orders
-- SET Status = 'ARCHIVED'
-- WHERE OrderDate < ADD_MONTHS(SYSDATE, -12);

-- /* 2. העלאת מחיר ב-10% למוצרים בקטגוריה מסוימת */
-- UPDATE Products
-- SET Price = Price * 1.10
-- WHERE CategoryID = 1;

-- /* 3. שינוי תפקיד לעובדים שנשכרו לפני 2018 */
-- UPDATE Employees
-- SET Role = 'Senior Staff'
-- WHERE HireDate < TO_DATE('01-01-2018', 'DD-MM-YYYY');


-- /* =========================
--    3 שאילתות DELETE
--    ========================= */

-- /* 1. מחיקת הזמנות ללא פריטים */
-- DELETE FROM Orders
-- WHERE OrderID NOT IN (
--     SELECT DISTINCT OrderID FROM OrderItems
-- );

-- /* 2. מחיקת מוצרים שלא זמינים ולא הוזמנו */
-- DELETE FROM Products
-- WHERE IsAvailable = 'N'
-- AND ProductID NOT IN (
--     SELECT DISTINCT ProductID FROM OrderItems
-- );

-- /* 3. מחיקת לקוחות שלא ביצעו הזמנות מעל 5 שנים */
-- DELETE FROM Customers
-- WHERE CustomerID NOT IN (
--     SELECT DISTINCT CustomerID FROM Orders
-- )
-- AND RegistrationDate < ADD_MONTHS(SYSDATE, -60);
