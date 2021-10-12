--SQLite


  SELECT DISTINCT p1.p_name as name
    FROM part as p1, supplier, partsupp, nation as supnation, region as supregion
    ,customer, nation as cusnation, region as cusregion, orders,lineitem
    WHERE s_suppkey = ps_suppkey AND ps_partkey = p1.p_partkey
    AND p1.p_partkey = l_partkey AND l_orderkey = o_orderkey
    AND o_custkey = c_custkey 
    AND s_nationkey = supnation.n_nationkey AND supnation.n_regionkey = supregion.r_regionkey
    AND supregion.r_name NOT IN('ASIA')
 
    AND c_nationkey = cusnation.n_nationkey AND cusnation.n_regionkey = cusregion.r_regionkey
    AND cusregion.r_name LIKE('AMERICA')
    GROUP BY p1.p_name
    HAVING COUNT(s_suppkey) == 3
