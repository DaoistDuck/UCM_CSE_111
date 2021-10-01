--SQLite

SELECT r_name, count(c_custkey)
FROM customer, region, nation,
(
    SELECT avg(c_acctbal) as avg_cus_acctbal
    FROM customer
) as avgcacctbal

LEFT JOIN orders ON c_custkey = o_custkey
WHERE o_custkey is NULL
AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey
AND c_acctbal < avgcacctbal.avg_cus_acctbal
GROUP BY r_name;

--https://stackoverflow.com/questions/3859896/sql-statement-to-get-all-customers-with-no-orders how to find customers with no orders