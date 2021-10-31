--SQLlite
SELECT s_name, n2.n_name, w_name
FROM supplier, nation as n1, warehouse, nation as n2
WHERE w_nationkey = n1.n_nationkey
AND n1.n_name = 'JAPAN' --this needs to be changed
AND s_suppkey = w_suppkey
AND s_nationkey = n2.n_nationkey
GROUP BY s_name
ORDER BY s_name ASC