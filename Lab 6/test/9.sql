--SQLite



    SELECT DISTINCT p_name
    FROM supplier, nation as asna, region as asre, part, 
    customer, nation as amcna, region as amcre, orders, lineitem, partsupp

    WHERE c_nationkey = amcna.n_nationkey AND amcna.n_regionkey = amcre.r_regionkey 
    AND amcre.r_name = 'AMERICA' 

    AND s_nationkey = asna.n_nationkey AND asna.n_regionkey = asre.r_regionkey 
    AND asre.r_name = 'ASIA' 
    
    AND c_custkey = o_custkey AND o_orderkey = l_orderkey AND l_partkey = p_partkey
    AND l_suppkey = s_suppkey AND ps_partkey = p_partkey AND ps_suppkey = s_suppkey

    GROUP BY p_name
    HAVING count(s_suppkey) = 3

