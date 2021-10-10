--SQLite


SELECT count(s_suppkey)
FROM supplier, part, partsupp
WHERE p_partkey = ps_partkey AND ps_suppkey = s_suppkey
AND p_retailprice = (select max(p_retailprice) from part);