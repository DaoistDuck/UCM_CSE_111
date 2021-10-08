--SQLite

--WITH justAmerican AS
--(

    
--)
--SELECT count(*)
WITH tmp AS(
SELECT s_suppkey
FROM region
INNER JOIN nation on n_nationkey = r_nationkey
INNER JOIN supplier on s_nationkey = n_nationkey
WHERE r_name in ('AMERICA')
), anotherTmp AS(
    SELECT s_suppkey
FROM region
INNER JOIN nation on n_nationkey = r_nationkey
INNER JOIN supplier on s_nationkey = n_nationkey
WHERE r_name <> 'AMERICA'
        
)
SELECT DISTINCT c_name
    FROM supplier, nation, region, customer, orders, lineitem, 
    WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey AND r_name in ('AMERICA')
    AND s_suppkey = l_suppkey AND l_orderkey = o_orderkey
    AND c_custkey = o_custkey --AND c_nationkey = s_nationkey
    GROUP BY c_name
    HAVING count(l_quantity) >= 1


