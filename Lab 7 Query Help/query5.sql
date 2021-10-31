--SQLite
WITH regionTotalCapacity AS(
SELECT r_name as name, SUM(w_capacity) as sumCap
FROM supplier, nation as n1, warehouse, nation as n2, region
WHERE w_nationkey = n1.n_nationkey
AND n2.n_name = 'UNITED STATES' --this needs to be changed
AND s_suppkey = w_suppkey
AND s_nationkey = n2.n_nationkey
AND n1.n_regionkey = r_regionkey
GROUP BY r_name
)
SELECT r_name, CASE WHEN regionTotalCapacity.sumCap > 0 THEN regionTotalCapacity.sumCap ELSE 0 END
FROM region
LEFT JOIN regionTotalCapacity ON r_name = regionTotalCapacity.name
GROUP BY r_name
ORDER BY r_name ASC