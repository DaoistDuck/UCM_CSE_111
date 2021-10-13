--SQLite

WITH cusAmerican AS(

    SELECT o_orderkey 
    FROM orders, customer, nation, region
    WHERE c_custkey = o_custkey
    AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey
    AND r_name = 'AMERICA'

), threeSupplier AS(

    SELECT ps_partkey
    FROM supplier, nation, region, partsupp
    WHERE ps_suppkey = s_suppkey 
    AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey 
    AND r_name = 'ASIA'
    GROUP BY ps_partkey
    HAVING COUNT(s_suppkey) = 3

)

  
 SELECT DISTINCT p_name
  FROM lineitem, part, cusAmerican, threeSupplier
  WHERE l_orderkey = cusAmerican.o_orderkey
  AND l_partkey = p_partkey
  AND p_partkey = threeSupplier.ps_partkey
  
