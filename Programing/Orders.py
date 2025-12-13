
import random
from datetime import date, timedelta

def random_date():
    start = date(2021, 1, 1)
    end = date(2025, 12, 31)
    return start + timedelta(days=random.randint(0, (end - start).days))

with open("insertTables.sql", "a", encoding="utf-8") as f:
    for i in range(1, 401):
        f.write(
            f"INSERT INTO Orders VALUES ({i}, "
            f"{random.randint(1,400)}, "
            f"{random.randint(1,400)}, "
            f"DATE '{random_date()}', 'Completed');\n"
        )
