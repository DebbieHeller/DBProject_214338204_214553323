-- ========================================
-- ROLLBACK - ביטול שינויים
-- ========================================

-- צעד 1: הצגת מצב המוצר לפני העדכון
SELECT * FROM Products WHERE ProductID = 1;

-- צעד 2: התחלת טרנזקציה
BEGIN;

-- צעד 3: עדכון מחיר המוצר
UPDATE Products SET Price = 9999.99 WHERE ProductID = 1;

-- צעד 4: הצגת מצב המוצר אחרי העדכון (בתוך הטרנזקציה)
SELECT * FROM Products WHERE ProductID = 1;

-- צעד 5: ביטול השינויים
ROLLBACK;

-- צעד 6: הצגת מצב המוצר אחרי ROLLBACK (חזר למצב המקורי)
SELECT * FROM Products WHERE ProductID = 1;


-- ========================================
-- COMMIT - שמירת שינויים
-- ========================================

-- צעד 1: הצגת מצב המוצר לפני העדכון
SELECT * FROM Products WHERE ProductID = 2;

-- צעד 2: התחלת טרנזקציה
BEGIN;

-- צעד 3: עדכון מחיר המוצר
UPDATE Products SET Price = 199.99 WHERE ProductID = 2;

-- צעד 4: הצגת מצב המוצר אחרי העדכון (בתוך הטרנזקציה)
SELECT * FROM Products WHERE ProductID = 2;

-- צעד 5: שמירת השינויים
COMMIT;

-- צעד 6: הצגת מצב המוצר אחרי COMMIT (השינוי נשמר לצמיתות)
SELECT * FROM Products WHERE ProductID = 2;