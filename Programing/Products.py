
import random

with open("insertTables.sql", "a", encoding="utf-8") as f:
    for i in range(1, 401):
        f.write(
            f"INSERT INTO Products VALUES ({i}, 'Product{i}', "
            f"{random.randint(1,400)}, "
            f"{round(random.uniform(5, 50), 2)}, "
            f"'{random.choice(['Y','N'])}');\n"
        )
