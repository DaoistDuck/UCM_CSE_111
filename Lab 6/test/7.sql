--SQLite

WITH less50 AS
(
    SELECT s_suppkey
    FROM supplier, lineitem, orders, customer, nation
    WHERE s_suppkey = l_suppkey AND l_orderkey = o_orderkey 
    AND c_nationkey = n_nationkey AND n_name in ('GERMANY', 'FRANCE')
    AND c_custkey = o_custkey 
    GROUP BY s_suppkey
    HAVING count(distinct o_orderkey) < 50
)
SELECT count(*)
FROM less50;