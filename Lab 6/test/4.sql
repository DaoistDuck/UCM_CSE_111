--SQLite

WITH supplierCount AS
(
    SELECT s_suppkey
    FROM part, partsupp, supplier, nation
    WHERE s_nationkey = n_nationkey AND n_name = 'UNITED STATES'
    AND s_suppkey = ps_suppkey AND ps_partkey = p_partkey 
    GROUP BY s_suppkey
    HAVING count(p_partkey) > 40
)
SELECT count(*)
FROM supplierCount;