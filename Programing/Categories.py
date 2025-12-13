
with open("insertTables.sql", "a", encoding="utf-8") as f:
    for i in range(1, 401):
        f.write(
            f"INSERT INTO Categories VALUES ({i}, 'Category{i}');\n"
        )
