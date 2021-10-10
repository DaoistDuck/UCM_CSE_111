--SQLite
WITH minCus AS(
SELECT n_name, count(c_custkey) as totalCus
FROM nation, customer
WHERE c_nationkey = n_nationkey
GROUP BY n_name
ORDER BY totalCus ASC
LIMIT 1
)
SELECT minCus.n_name
FROM minCus

--https://stackoverflow.com/questions/27983/sql-group-by-with-an-order-by
--understanding the order by confused me