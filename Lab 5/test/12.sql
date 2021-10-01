--SQLite

SELECT total(ps_supplycost)
FROM partsupp, part,supplier as s1, lineitem

WHERE ps_partkey = p_partkey AND ps_suppkey = s_suppkey AND l_partkey = p_partkey
AND p_retailprice < 1000
AND strftime('%Y', l_shipdate) = '1997'

AND NOT EXISTS
(
    select *
    FROM supplier as s2, lineitem
    WHERE l_suppkey = s2.s_suppkey 
    AND s2.s_name = s1.s_name
    AND l_extendedprice < 2000
    AND strftime('%Y', l_shipdate) = '1996'
);

--https://stackoverflow.com/questions/17738657/sql-using-not-exists