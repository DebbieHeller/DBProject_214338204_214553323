
import random
from datetime import date, timedelta

def random_date():
    start = date(2018, 1, 1)
    end = date(2024, 12, 31)
    return start + timedelta(days=random.randint(0, (end - start).days))

roles = ['Manager', 'Cashier', 'Baker']

with open("insertTables.sql", "a", encoding="utf-8") as f:
    for i in range(1, 401):
        f.write(
            f"INSERT INTO Employees VALUES ({i}, 'Emp{i}', 'Worker{i}', "
            f"'{random.choice(roles)}', DATE '{random_date()}');\n"
        )
