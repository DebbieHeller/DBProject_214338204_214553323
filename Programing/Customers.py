
import random
from datetime import date, timedelta

def random_date():
    start = date(2020, 1, 1)
    end = date(2025, 12, 31)
    return start + timedelta(days=random.randint(0, (end - start).days))

with open("insertTables.sql", "w", encoding="utf-8") as f:
    for i in range(1, 401):
        f.write(
            f"INSERT INTO Customers VALUES ({i}, 'First{i}', 'Last{i}', "
            f"'050-{random.randint(1000000,9999999)}', "
            f"'customer{i}@mail.com', DATE '{random_date()}');\n"
        )
