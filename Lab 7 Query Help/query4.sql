--SQLlite
SELECT w_name, w_capacity
FROM warehouse, nation, region
WHERE w_nationkey = n_nationkey
AND n_regionkey = r_regionkey
AND r_name = 'ASIA'
AND w_capacity > 2000
GROUP BY w_name
ORDER BY w_capacity DESC