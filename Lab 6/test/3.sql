    --SQLite

WITH twoSupp AS
(
SELECT p_partkey
FROM part, supplier, partsupp, nation
WHERE ps_partkey = p_partkey AND s_suppkey = ps_suppkey
AND s_nationkey = n_nationkey AND n_name = 'UNITED STATES'
GROUP BY p_partkey
HAVING count(s_suppkey) == 2
)
SELECT count(*)
FROM twoSupp