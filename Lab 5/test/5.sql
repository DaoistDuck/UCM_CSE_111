--SQLite

SELECT s_name, p_size, min(ps_supplycost)
FROM supplier, partsupp, part, nation, region
WHERE s_nationkey = n_nationkey AND n_regionkey = r_regionkey 
AND r_name = 'ASIA' 
AND s_suppkey = ps_suppkey AND ps_partkey = p_partkey
AND p_type like '%STEEL%'
GROUP BY p_size;

--IGNORE FAIL ERROR FOR THIS FILE