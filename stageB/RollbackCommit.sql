
-- ================================
-- דוגמה 1: ROLLBACK
-- ================================

BEGIN;

UPDATE Products
SET Price = Price * 1.1
WHERE CategoryID = 1;

-- בדיקה אחרי העדכון
SELECT ProductID, ProductName, Price
FROM Products
WHERE CategoryID = 1;

ROLLBACK;

-- בדיקה אחרי rollback
SELECT ProductID, ProductName, Price
FROM Products
WHERE CategoryID = 1;


-- ================================
-- דוגמה 2: COMMIT
-- ================================

BEGIN;

UPDATE Orders
SET Status = 'Completed'
WHERE OrderID = 1;

-- בדיקה אחרי העדכון
SELECT OrderID, Status
FROM Orders
WHERE OrderID = 1;

COMMIT;

-- בדיקה אחרי commit
SELECT OrderID, Status
FROM Orders
WHERE OrderID = 1;
