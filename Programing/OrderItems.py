
import random

used_pairs = set()

with open("insertTables.sql", "a", encoding="utf-8") as f:
    while len(used_pairs) < 800:
        order_id = random.randint(1, 400)
        product_id = random.randint(1, 400)

        if (order_id, product_id) in used_pairs:
            continue

        used_pairs.add((order_id, product_id))

        f.write(
            f"INSERT INTO OrderItems VALUES ("
            f"{order_id}, {product_id}, "
            f"{random.randint(1,5)}, "
            f"{round(random.uniform(5,50),2)});\n"
        )
