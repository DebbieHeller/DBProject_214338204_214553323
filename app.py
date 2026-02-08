
import streamlit as st
import pandas as pd
from sqlalchemy import create_engine, text

# פונקציית חיבור למסד הנתונים ב-Docker
def get_connection():
    # ודאי שהפרטים תואמים להגדרות ה-Docker שלך
    conn_str = "postgresql://postgres:123456@127.0.0.1:5432/BakeryDB"
    engine = create_engine(conn_str)
    return engine

st.title("🍞 מערכת ניהול מאפייה - BakeryDB")

# תפריט ניווט בצד
# ודאי שהשורה הזו כוללת את האפשרות החדשה:
menu = ["דף הבית", "ניהול סניפים", "ניהול מוצרים", "ניהול עובדים", "ביצוע הזמנה", "ביצועי עובד (Procedure)"]
choice = st.sidebar.selectbox("תפריט", menu)

conn = get_connection()

# --- 1. דף הבית: צפייה ב-VIEW ---
if choice == "דף הבית":
    st.header("📊 דוח מכירות מוצרים לפי סניף (VIEW)")
    try:
        query = text("SELECT * FROM branch_product_revenue")
        df = pd.read_sql_query(query, conn)
        st.dataframe(df, use_container_width=True)
    except Exception as e:
        st.error(f"שגיאה בטעינת ה-View: {e}")

# --- 2. ניהול סניפים (CRUD) ---
elif choice == "ניהול סניפים":
    st.header("🏢 ניהול סניפים")
    tab1, tab2, tab3 = st.tabs(["הוספת סניף", "עדכון טלפון", "מחיקת סניף"])

    with tab1:
        with st.form("insert_branch"):
            name = st.text_input("שם הסניף")
            addr = st.text_input("כתובת")
            phone = st.text_input("טלפון")
            submitted = st.form_submit_button("הוסף סניף")
            if submitted:
                with conn.connect() as connection:
                    query = text("INSERT INTO branches (branchname, address, phone) VALUES (:name, :addr, :phone)")
                    connection.execute(query, {"name": name, "addr": addr, "phone": phone})
                    connection.commit()
                st.success(f"הסניף {name} נוסף!")

    with tab2:
        with st.form("update_branch"):
            b_id = st.number_input("ID של סניף לעדכון", min_value=1)
            new_phone = st.text_input("טלפון חדש")
            submitted = st.form_submit_button("עדכן טלפון")
            if submitted:
                with conn.connect() as connection:
                    query = text("UPDATE branches SET phone = :phone WHERE branchid = :id")
                    connection.execute(query, {"phone": new_phone, "id": b_id})
                    connection.commit()
                st.success("הטלפון עודכן!")

    with tab3:
        del_id = st.number_input("ID של סניף למחיקה", min_value=1, key="del_br")
        if st.button("מחק סניף"):
            with conn.connect() as connection:
                connection.execute(text("DELETE FROM branches WHERE branchid = :id"), {"id": del_id})
                connection.commit()
            st.warning(f"סניף {del_id} נמחק.")

# --- 3. ניהול מוצרים (CRUD) ---
elif choice == "ניהול מוצרים":
    st.header("📦 ניהול מוצרים")
    tab1, tab2, tab3 = st.tabs(["הוספת מוצר", "עדכון מחיר", "מחיקת מוצר"])

    with tab1:
        with st.form("insert_product"):
            # שימי לב: כל השורות האלו חייבות להיות מוזזות ימינה
            p_name = st.text_input("שם המוצר")
            p_price = st.number_input("מחיר", min_value=0.0)
            
            cat_options = {"מאפים": 1, "עוגיות": 2, "לחמים": 3, "שתייה": 4}
            selected_cat_name = st.selectbox("בחר קטגוריה", list(cat_options.keys()))
            p_cat_id = cat_options[selected_cat_name]
            
            submitted = st.form_submit_button("הוסף מוצר")
            
            if submitted:
                with conn.connect() as connection:
                    query = text("INSERT INTO products (productname, price, categoryid, isavailable) VALUES (:n, :p, :c, :a)")
                    connection.execute(query, {"n": p_name, "p": p_price, "c": p_cat_id, "a": True})
                    connection.commit()
                st.success(f"המוצר '{p_name}' נוסף!")

    with tab2:
        with st.form("update_product"):
            p_id = st.number_input("ID מוצר", min_value=1)
            new_p = st.number_input("מחיר חדש", min_value=0.0)
            if st.form_submit_button("עדכן מחיר"):
                with conn.connect() as connection:
                    connection.execute(text("UPDATE products SET price = :p WHERE productid = :id"), {"p": new_p, "id": p_id})
                    connection.commit()
                st.success("המחיר עודכן!")

    with tab3:
        p_del = st.number_input("ID מוצר למחיקה", min_value=1, key="del_pr")
        if st.button("מחק מוצר"):
            with conn.connect() as connection:
                connection.execute(text("DELETE FROM products WHERE productid = :id"), {"id": p_del})
                connection.commit()
            st.warning("המוצר נמחק.")

# --- 4. ניהול עובדים (CRUD) ---
elif choice == "ניהול עובדים":
    st.header("👥 ניהול עובדים")
    tab1, tab2, tab3 = st.tabs(["הוספת עובד", "עדכון תפקיד", "מחיקת עובד"])

    with tab1:
        # שליפת סניפים לבחירה - מתבצעת בתוך tab1
        try:
            with conn.connect() as connection:
                branches = connection.execute(text("SELECT branchid, branchname FROM branches")).fetchall()
                branch_options = {f"{b[1]} (ID: {b[0]})": b[0] for b in branches}
        except:
            st.error("לא ניתן לטעון סניפים. ודאי שטבלת branches קיימת.")
            branch_options = {}

        # יצירת הטופס
        with st.form("insert_employee_form"):
            st.subheader("הוספת עובד חדש")
            f_name = st.text_input("שם מלא")
            phone = st.text_input("מספר טלפון")
            r_id = st.number_input("קוד תפקיד (Role ID)", min_value=1, step=1)
            
            # בחירת סניף מתוך הרשימה ששלפנו
            selected_branch = st.selectbox("שייך לסניף", list(branch_options.keys()))
            
            submitted = st.form_submit_button("שמור עובד")
            
            if submitted:
                if f_name and selected_branch:
                    branch_id = branch_options[selected_branch]
                    try:
                        with conn.connect() as connection:
                            query = text("""
                                INSERT INTO employees (fullname, phone, roleid, branchid, hiredate) 
                                VALUES (:n, :p, :r, :b, NOW())
                            """)
                            connection.execute(query, {"n": f_name, "p": phone, "r": r_id, "b": branch_id})
                            connection.commit()
                        st.success(f"העובד {f_name} נוסף בהצלחה!")
                    except Exception as e:
                        st.error(f"שגיאה בשמירה למסד הנתונים: {e}")
                else:
                    st.error("נא למלא את כל השדות")

    with tab2:
        # כאן יבוא הקוד של עדכון תפקיד...
        with st.form("update_emp"):
            e_id = st.number_input("ID עובד", min_value=1)
            new_r = st.number_input("ID תפקיד חדש", min_value=1)
            if st.form_submit_button("עדכן תפקיד"):
                with conn.connect() as connection:
                    connection.execute(text("UPDATE employees SET roleid = :r WHERE employeeid = :id"), {"r": new_r, "id": e_id})
                    connection.commit()
                st.success("התפקיד עודכן!")

    with tab3:
        e_del = st.number_input("ID עובד למחיקה", min_value=1, key="del_em")
        if st.button("מחק עובד"):
            with conn.connect() as connection:
                connection.execute(text("DELETE FROM employees WHERE employeeid = :id"), {"id": e_del})
                connection.commit()
            st.warning("העובד נמחק.")

# --- 5. ביצועי עובד (Procedure/Function) ---
elif choice == "ביצועי עובד (Procedure)":
    st.header("⚙️ נתוני ביצועי עובד")
    emp_id = st.number_input("הזן ID של עובד", min_value=1)
    if st.button("חשב נתונים"):
        try:
            query = text(f"SELECT * FROM get_employee_performance({emp_id})")
            df = pd.read_sql_query(query, conn)
            if not df.empty:
                st.table(df)
            else:
                st.info("אין נתונים לעובד זה.")
        except Exception as e:
            st.error(f"שגיאה: {e}")
elif choice == "ביצוע הזמנה":
    st.header("🛒 יצירת הזמנה חדשה")
    
    try:
        with conn.connect() as connection:
            # 1. קודם כל שולפים את הסניפים
            branches = connection.execute(text("SELECT branchid, branchname FROM branches")).fetchall()
            branch_dict = {f"{b[1]} (ID: {b[0]})": b[0] for b in branches}

        # בחירת סניף (מחוץ לטופס כדי שנוכל לעדכן את רשימת העובדים מיד)
        selected_branch_name = st.selectbox("בחר סניף", list(branch_dict.keys()))
        branch_id = branch_dict[selected_branch_name]

        with conn.connect() as connection:
            # 2. שליפת עובדים לפי הסניף שנבחר בלבד!
            emps = connection.execute(
                text("SELECT employeeid, fullname FROM employees WHERE branchid = :bid"),
                {"bid": branch_id}
            ).fetchall()
            emp_dict = {f"{e[1]} (ID: {e[0]})": e[0] for e in emps}
            
            # 3. שליפת מוצרים
            prods = connection.execute(text("SELECT productid, productname, price FROM products")).fetchall()
            prod_dict = {f"{p[1]} (מחיר: {p[2]})": {"id": p[0], "price": p[2]} for p in prods}

        if not emp_dict:
            st.warning(f"אין עובדים רשומים בסניף {selected_branch_name}. יש להוסיף עובדים לסניף זה קודם.")
        else:
            with st.form("new_order_form"):
                col1, col2 = st.columns(2)
                with col1:
                    # כאן יוצגו רק העובדים של הסניף שנבחר
                    selected_emp = st.selectbox("בחר עובד מבצע", list(emp_dict.keys()))
                with col2:
                    selected_prod = st.selectbox("בחר מוצר", list(prod_dict.keys()))
                    qty = st.number_input("כמות", min_value=1, step=1)
                
                if st.form_submit_button("בצע הזמנה"):
                    emp_id = emp_dict[selected_emp]
                    prod_id = prod_dict[selected_prod]["id"]
                    unit_price = prod_dict[selected_prod]["price"]
                    
                    with conn.connect() as connection:
                        res = connection.execute(text(
                            "INSERT INTO orders (employeeid, branchid, orderdate) "
                            "VALUES (:e, :b, NOW()) RETURNING orderid"),
                            {"e": emp_id, "b": branch_id})
                        new_order_id = res.fetchone()[0]
                        
                        connection.execute(text(
                            "INSERT INTO orderitems (orderid, productid, quantity, unitprice) "
                            "VALUES (:oid, :pid, :q, :p)"),
                            {"oid": new_order_id, "pid": prod_id, "q": qty, "p": unit_price})
                        connection.commit()
                        
                    st.success(f"הזמנה מספר {new_order_id} בוצעה בהצלחה בסניף {selected_branch_name}!")
                    st.balloons()
    except Exception as e:
        st.error(f"שגיאה בתהליך ההזמנה: {e}")