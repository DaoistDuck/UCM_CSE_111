--SQLite

SELECT p_mfgr
FROM part, partsupp, supplier,
(
    SELECT min(ps_availqty) as miniumum
    FROM part,partsupp,supplier
    WHERE p_partkey = ps_partkey AND ps_suppkey = s_suppkey 
    AND s_name = 'Supplier#000000010' 
) as minps

WHERE p_partkey = ps_partkey AND ps_suppkey = s_suppkey 
AND s_name = 'Supplier#000000010' 
AND ps_availqty <= minps.miniumum;
