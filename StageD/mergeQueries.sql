/* =============================================================
   שלב 4: שאילתות מורכבות, Views, Triggers ו-Procedures
   ============================================================= */

-- 1. הכנת תשתית: עדכון סוגי נתונים לחישובי זמן בטריגר
ALTER TABLE employeeshifts 
ALTER COLUMN starttime TYPE TIME USING starttime::TIME,
ALTER COLUMN endtime TYPE TIME USING endtime::TIME;

-- 2. יצירת VIEW: דוח מכירות מוצרים לפי סניף (חיבור 4 טבלאות)
CREATE OR REPLACE VIEW branch_product_revenue AS
SELECT 
    b.branchname,
    p.productname,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.quantity * oi.unitprice) AS total_revenue
FROM branches b
JOIN orders o ON b.branchid = o.branchid
JOIN orderitems oi ON o.orderid = oi.orderid
JOIN products p ON oi.productid = p.productid
GROUP BY b.branchname, p.productname;

-- 3. יצירת STORED PROCEDURE: בדיקת ביצועי עובד (שאילתה עם פרמטרים)
CREATE OR REPLACE FUNCTION get_employee_performance(emp_id INT)
RETURNS TABLE(emp_name TEXT, orders_count BIGINT, total_sales NUMERIC) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        e.fullname::TEXT,
        COUNT(o.orderid),
        COALESCE(SUM(oi.quantity * oi.unitprice), 0)
    FROM employees e
    LEFT JOIN orders o ON e.employeeid = o.employeeid
    LEFT JOIN orderitems oi ON o.orderid = oi.orderid
    WHERE e.employeeid = emp_id
    GROUP BY e.fullname;
END;
$$ LANGUAGE plpgsql;

-- 4. יצירת TRIGGER: הגבלת משמרות ל-12 שעות (לוגיקה עסקית)
CREATE OR REPLACE FUNCTION validate_shift_hours()
RETURNS TRIGGER AS $$
BEGIN
    IF (NEW.endtime - NEW.starttime) > INTERVAL '12 hours' THEN
        RAISE EXCEPTION 'חריגה: משמרת לא יכולה לעלות על 12 שעות!';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_check_hours
BEFORE INSERT OR UPDATE ON employeeshifts
FOR EACH ROW EXECUTE FUNCTION validate_shift_hours();

/* -------------------------------------------------------------
   4 שאילתות מורכבות חדשות
   ------------------------------------------------------------- */

-- שאילתה 1: לקוחות נאמנים - מי הלקוח שהוציא הכי הרבה בכל סניף
SELECT branchname, customer_name, total_spent
FROM (
    SELECT 
        b.branchname,
        c.firstname || ' ' || c.lastname AS customer_name,
        SUM(oi.quantity * oi.unitprice) AS total_spent,
        RANK() OVER (PARTITION BY b.branchid ORDER BY SUM(oi.quantity * oi.unitprice) DESC) as rnk
    FROM branches b
    JOIN orders o ON b.branchid = o.branchid
    JOIN customers c ON o.customerid = c.customerid
    JOIN orderitems oi ON o.orderid = oi.orderid
    GROUP BY b.branchid, b.branchname, customer_name
) ranked_customers
WHERE rnk = 1;

-- שאילתה 2: ביצועי עובדים - הכנסות מול כמות הזמנות לפי עובד וסניף
SELECT 
    e.fullname, 
    b.branchname, 
    COUNT(o.orderid) AS sales_count,
    SUM(oi.quantity * oi.unitprice) AS total_revenue
FROM employees e
JOIN orders o ON e.employeeid = o.employeeid
JOIN branches b ON o.branchid = b.branchid
JOIN orderitems oi ON o.orderid = oi.orderid
GROUP BY e.fullname, b.branchname
ORDER BY total_revenue DESC;

-- שאילתה 3: רווחיות לפי קטגוריית מוצר וסניף
SELECT 
    b.branchname,
    pc.categoryname,
    COUNT(o.orderid) AS amount_of_sales,
    SUM(oi.quantity * oi.unitprice) AS category_revenue
FROM branches b
JOIN orders o ON b.branchid = o.branchid
JOIN orderitems oi ON o.orderid = oi.orderid
JOIN products p ON oi.productid = p.productid
JOIN productcategories pc ON p.categoryid = pc.categoryid
GROUP BY b.branchname, pc.categoryname
ORDER BY category_revenue DESC;

-- שאילתה 4: מדד יעילות - יחס הכנסות למספר עובדים בסניף
SELECT 
    b.branchname,
    COUNT(DISTINCT es.employeeid) AS staff_on_duty,
    COALESCE(SUM(oi.quantity * oi.unitprice), 0) AS total_revenue,
    ROUND(COALESCE(SUM(oi.quantity * oi.unitprice), 0) / NULLIF(COUNT(DISTINCT es.employeeid), 0), 2) AS revenue_per_employee
FROM branches b
LEFT JOIN employeeshifts es ON b.branchid = es.branchid
LEFT JOIN orders o ON b.branchid = o.branchid AND o.orderdate = es.shiftdate
LEFT JOIN orderitems oi ON o.orderid = oi.orderid
GROUP BY b.branchid, b.branchname
ORDER BY total_revenue DESC;