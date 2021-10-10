--SQLite
WITH minPrice AS(
SELECT n_name, sum(o_totalprice) as totalPrice
FROM nation, customer, orders
WHERE c_nationkey = n_nationkey AND c_custkey = o_custkey
GROUP BY n_name
ORDER BY totalPrice ASC
LIMIT 1
)
SELECT minPrice.n_name
FROM minPrice
