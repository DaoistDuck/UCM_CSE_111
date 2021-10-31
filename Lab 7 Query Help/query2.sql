--SQLlite
SELECT n_name, COUNT(w_warehousekey), SUM(w_capacity)
FROM nation, warehouse
WHERE w_nationkey = n_nationkey
GROUP BY n_name
ORDER BY COUNT(w_warehousekey) DESC, n_name ASC