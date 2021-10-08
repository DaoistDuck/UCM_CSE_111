--SQLite

--WITH justAmerican AS
--(

    --SELECT s_suppkey FROM supplier

    
--)
--SELECT count(*)
SELECT DISTINCT c_name
FROM supplier, nation, region, customer, orders
WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey 
AND r_name == 'AMERICA'
AND c_custkey = o_custkey

--AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey
--AND c_custkey = o_custkey
GROUP BY c_name
HAVING count(o_orderkey) >= 1


