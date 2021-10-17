--SQLite  

WITH cusAmerican AS(

    SELECT p_partkey
    FROM orders, customer, nation, region, lineitem, part
    WHERE c_custkey = o_custkey
    AND o_orderkey = l_orderkey AND l_partkey = p_partkey
    AND c_nationkey = n_nationkey AND n_regionkey = r_regionkey
    AND r_name = 'AMERICA'

), threeSupplier AS(

    SELECT p_partkey
    FROM supplier, nation, region, lineitem, part
    WHERE p_partkey = l_partkey
    AND l_suppkey = s_suppkey
    AND s_nationkey = n_nationkey AND n_regionkey = r_regionkey 
    AND r_name = 'ASIA'
    GROUP BY p_partkey
    HAVING COUNT(*) = 3

)

  
 SELECT DISTINCT p1.p_name
  FROM lineitem, part as p1, cusAmerican, threeSupplier
  WHERE l_partkey = threeSupplier.p_partkey
  AND l_partkey = cusAmerican.p_partkey
  AND l_partkey = p1.p_partkey
  
 --using code from the TA as a base